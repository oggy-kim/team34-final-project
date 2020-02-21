package com.team34.codehappy.member;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.BoardService;
import com.team34.codehappy.board.Reply;

@SessionAttributes("loginMember")
@Controller
public class MemberController {

	@Autowired
	private MemberService mService;

	@Autowired
	private BoardService bService;

	// 로그인 암호화 처리
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 로그인 폼 으로 이동! GET 방식
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm(Model model) {
		String kakaoUrl = KakaoController.getAuthorizationUrl();
		model.addAttribute("kakao_url", kakaoUrl);
		String githubUrl = GithubController.getAuthorizationUrl();
		model.addAttribute("github_url", githubUrl);
		return "member/login";
	}

	// 암호화 처리후 로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String memberlogin(Member m, Model model) {

		Member loginMember = mService.loginMember(m);

		if (loginMember != null && loginMember.getAuthKey() != "kakao" && bcryptPasswordEncoder.matches(m.getmPwd(), loginMember.getmPwd())) {
			if (!loginMember.getLevelName().equals("회원가입중")) {
				model.addAttribute("loginMember", loginMember);
				System.out.println("------ 로그인 발생 ------");
				System.out.println(new Date());
				System.out.println(loginMember.getmNick() + "님이 로그인하셨습니다.");
				return "redirect:/";
			} else if(loginMember.getLevelName().equals("회원가입중")) {
				model.addAttribute("msg", "이메일 인증 먼저 진행해주세요.");
				return "member/login";
			} else {
				throw new MemberException("로그인 실패하였습니다.");
			}
		} else {
			model.addAttribute("msg", "비밀번호 오류입니다.");
			return "member/login";
		}
	}
	
	// 비밀번호 찾기 이동! GET 방식
	@RequestMapping(value = "findPwd1", method = RequestMethod.GET)
	public String findPwdForm() {
		return "member/findPwd";
	}
	
	// 임시비밀번호 변경
	@RequestMapping("findPwd")
	public String updatePwd2(Member m) throws MemberException {
					System.out.println(m);
		String newPwd = bcryptPasswordEncoder.encode(m.getmPwd());
					
		m.setmPwd(newPwd);
					System.out.println(m);
		int result = mService.updatePwd2(m);
			System.out.println(result);
		if(result < 1) {
			throw new MemberException("비밀번호 변경 실패");
		} else {
			return "";
		}
					
	}
	// 로그아웃
	@RequestMapping("logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}

	// 회원가입 페이지로 이동
	@RequestMapping("enrollView")
	public String enrollView(Model model) {
		List<String> list = mService.getTagList();
		model.addAttribute("tagList", list);
		
		return "member/memberJoin";
	}
	
	// 회원가입 이메일 인증 요청
	@RequestMapping(value = "minsert", method = RequestMethod.POST)
	public String memberInsert(Member m, Model model) throws Exception {
		String encPwd = bcryptPasswordEncoder.encode(m.getmPwd());
		
		m.setmPwd(encPwd);
		m.setmLevel(9);
		
		mService.insertMember(m);
		
		model.addAttribute("msg", "회원가입 인증 메일이 발송되었습니다.");
		
		return "member/login";
	}
	
	// 회원가입 이메일 인증 요청 마무리
	@RequestMapping(value = "emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(Member m, Model model) throws Exception {
		
		m.setmLevel(8);
		
		mService.updateMlevel(m);
		
		model.addAttribute("auth_check", 8);
		model.addAttribute("mId", m.getmId());
		
		return "emailConfirm";
		
	}

	// 비밀번호 재설정 페이지로 이동
	@RequestMapping(value = "mypage/updatePwd", method = RequestMethod.GET)
	public String updatePwdForm() {
		return "member/updatePwd";
	}
	
	// 비밀번호 재설정
	@RequestMapping(value = "mypage/updatePwd", method = RequestMethod.POST)
	public String updatePwd(HttpSession session, @RequestParam(value="newmPwd") String newmPwd)throws MemberException{
		Member m = (Member) session.getAttribute("loginMember");
		
		String changePwd = bcryptPasswordEncoder.encode(newmPwd);
		
		m.setmPwd(changePwd);
		
		int result = mService.updatePwd(m);
		
		if(result < 1) {
			throw new MemberException("비밀번호 변경 실패 에러");
		} else {
			session.setAttribute("msg", "비밀번호가 변경되었습니다.");
			return "member/updatePwd";
		}
	}
	
	// 비밀번호 재설정 확인
	@RequestMapping(value = "mypage/pwdCheck", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String pwdCheck(@RequestParam(value="mPwd") String mPwd, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String curPwd = loginMember.getmPwd();
		
		JSONObject job = new JSONObject();
		
		if(bcryptPasswordEncoder.matches(mPwd, curPwd)){
			job.put("result", true);
		}
		
		return job.toJSONString();
	}
	
	
	// 회원 탈퇴
	@RequestMapping("member/{mNo}")
	public String deleteMember(@PathVariable("mNo") int mNo, Model model, SessionStatus status) {
		System.out.println(mNo);
		// 삭제할 아이디 mService로 넘겨주기
		int result = mService.deleteMember(mNo);

		if(result > 0) {
			model.addAttribute("msg", "CODEHAPPY 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.");
		} else {
			model.addAttribute("msg", "탈퇴에 실패하였습니다. 관리자에게 문의해주세요.");
		}

		// 로그아웃
		status.setComplete();

		return "index";
	}
	
	// 아이디 중복체크
	@RequestMapping("dupid")
	public ModelAndView isDuplicateCheck(String mId, ModelAndView mv) {
		
		boolean isUsable = mService.checkIdDup(mId) == 0 ? true : false;
		
		Map map = new HashMap();
		map.put("isUsable", isUsable);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	// 회원가입 닉네임 중복체크
	@RequestMapping("dupnick")
	public ModelAndView inckDuplicateCheck(String mNick, ModelAndView mv) {
			
		boolean isUsable = mService.checkNickDup(mNick) == 0 ? true : false;
			
		Map map = new HashMap();
		map.put("isUsable", isUsable);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
			
			return mv;
			
	}
	
	// 마이페이지 닉네임 중복체크
	@RequestMapping("mypage/dupnick")
	public ModelAndView inckDuplicateCheck1(String mNick, ModelAndView mv) {
		
		boolean isUsable = mService.checkNickDup(mNick) == 0 ? true : false;
		
		Map map = new HashMap();
		map.put("isUsable", isUsable);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		
		 return mv;
		
	}
	
	@RequestMapping(value = "mypage/{mNo}", method = RequestMethod.GET)
	public String myPage(Model model, @PathVariable("mNo") int mNo, HttpServletRequest request,
			HttpServletResponse response) {

		List<Board> bList = bService.selectArticleByUser(mNo);
		List<Reply> rList = bService.selectReplyByUser(mNo);
		Member member = mService.selectMemberByMNo(mNo);
		model.addAttribute("bList", bList);
		model.addAttribute("rList", rList);
		model.addAttribute("myPageInfo", member);
		
		Member loginMember = (Member) request.getSession().getAttribute("loginMember");
		if (loginMember == null || loginMember.getmNo() != mNo) {
			model.addAttribute("sList", "notUser");
			return "mypage";
		}
		List<Board> sList = bService.selectStarArticleByUser(mNo);
		model.addAttribute("sList", sList);

		return "mypage";
	}

	// 자기소개 및 닉네임 수정
	@RequestMapping(value = "mypage/{mNo}", method = RequestMethod.POST)
	public String memberUpdate(Member m, Model model, @PathVariable("mNo") int mNo) {
		m.setmNo(mNo);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("mNo", String.valueOf(m.getmNo()));
		
		if(m.getAboutMe() != "") {
			map.put("aboutMe", m.getAboutMe());
		} else {
			map.put("mNick", m.getmNick());
		}

		int result = mService.updateMemberNick(map);

		if (result > 0) {
			Member updateM = mService.selectMemberByMNo(mNo);
			model.addAttribute("loginMember", updateM)
				 .addAttribute("msg", "정보 수정이 완료되었습니다!");
		} else {
			throw new MemberException("정보 수정 실패!");
		}

		return "redirect:/mypage/" + mNo;
		
	}
	
	// 프로필 사진 업데이트
	@ResponseBody
	@RequestMapping(value = "mypage/updateProfilePic", method=RequestMethod.POST)
	public JsonObject updateProfilePic(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("avatar") MultipartFile formData) throws Exception {
		Member loginMember = (Member) request.getSession().getAttribute("loginMember");
		String originalFile = formData.getOriginalFilename();
		String storedFileName = String.valueOf(loginMember.getmNo()) + ".png";
		String url = request.getSession().getServletContext().getRealPath("/resources/images/member/");
		
		File file = new File(url + storedFileName);
		formData.transferTo(file);
		
		JsonObject json = new JsonObject();
		json.addProperty("success", 1);
		
		return json;
	}
	
	@RequestMapping(value="/kakaologin", produces="application/json", method = {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin(@RequestParam("code") String code,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		new com.team34.codehappy.member.KakaoController();
		JsonNode accessToken = KakaoController.getAccessToken(code);
		JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
		
		JsonNode properties = userInfo.path("properties");
		
		Member loginMember = mService.selectMemberById("kakao" + userInfo.path("id").asText());
		
		if(loginMember == null) {
			Member m = new Member();
			
			m.setmNick(properties.path("nickname").asText());
			m.setmId("kakao" + userInfo.path("id").asText());
			m.setmLevel(8);
			m.setAuthKey("kakao");
			m.setMyTag(null);
			
			mService.insertMemberViaSocial(m);
			loginMember = mService.selectMemberById(m.getmId());
			System.out.println(loginMember.getmNick() + "님이 kakao를 통해 가입하셨습니다.");
			
			// 프로필 사진 저장
			String thumbnailUrl = properties.path("profile_image").asText();
			String saveUrl = request.getSession().getServletContext().getRealPath("/resources/images/member/");
			File outputFile = new File(saveUrl + loginMember.getmNo() + ".png");
			URL url = null;
			BufferedImage bi = null;
			try {
				url = new URL(thumbnailUrl);
				bi = ImageIO.read(url);
				ImageIO.write(bi, "png", outputFile);
			} catch(IOException e) {
				System.out.println(e);
			}
		} 
		model.addAttribute("loginMember", loginMember);

		return "redirect:/";
	}
	
	@RequestMapping(value="/githublogin", produces="application/json", method = {RequestMethod.GET, RequestMethod.POST})
	public String githubLogin(@RequestParam("code") String code,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		new com.team34.codehappy.member.KakaoController();
		JsonNode accessToken = GithubController.getAccessToken(code);
		JsonNode userInfo = GithubController.getGithubUserInfo(accessToken);
		
		Member loginMember = mService.selectMemberById("github" + userInfo.path("id").asText());
		
		if(loginMember == null) {
			Member m = new Member();
			
			m.setmNick(userInfo.path("login").asText());
			m.setmId("github" + userInfo.path("id").asText());
			m.setmLevel(8);
			m.setAuthKey("github");
			m.setMyTag(null);
			
			mService.insertMemberViaSocial(m);
			loginMember = mService.selectMemberById(m.getmId());
			System.out.println(loginMember.getmNick() + "님이 Github를 통해 가입하셨습니다.");
			
			// 프로필 사진 저장
			String thumbnailUrl = userInfo.path("avatar_url").asText();
			String saveUrl = request.getSession().getServletContext().getRealPath("/resources/images/member/");
			File outputFile = new File(saveUrl + loginMember.getmNo() + ".png");
			URL url = null;
			BufferedImage bi = null;
			try {
				url = new URL(thumbnailUrl);
				bi = ImageIO.read(url);
				ImageIO.write(bi, "png", outputFile);
			} catch(IOException e) {
				System.out.println(e);
			}
		} 
		model.addAttribute("loginMember", loginMember);
		return "redirect:/";
	}
}
