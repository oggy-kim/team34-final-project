package com.team34.codehappy.member;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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

	private Logger logger = LoggerFactory.getLogger(MemberController.class);

	// 로그인 암호화 처리
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 로그인 폼 으로 이동! GET 방식
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm() {
		return "member/login";
	}

	// 암호화 처리후 로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String memberlogin(Member m, Model model) {

		Member loginMember = mService.loginMember(m);
		System.out.println(loginMember);

		if (loginMember != null && bcryptPasswordEncoder.matches(m.getmPwd(), loginMember.getmPwd())) {
			if (loginMember.getLevelName() != "회원가입중") {
				model.addAttribute("loginMember", loginMember);
				return "index";
			} else if(loginMember.getLevelName() == "회원가입중") {
				model.addAttribute("msg", "이메일 인증 먼저 진행해주세요.");
			} else {
				throw new MemberException("로그인 실패하였습니다.");
			}
			return "index";
		} else {
			model.addAttribute("msg", "비밀번호 오류입니다.");
			return "redirect:/login";
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
		return "index";
	}

	// 회원가입 페이지로 이동
	@RequestMapping("enrollView")
	public String enrollView() {
		return "member/memberJoin";
	}
	
	// 회원가입 이메일 인증 요청
	@RequestMapping(value = "minsert", method = RequestMethod.POST)
	public String memberInsert(Member m, Model model) throws Exception {
		String encPwd = bcryptPasswordEncoder.encode(m.getmPwd());
		
		m.setmPwd(encPwd);
		
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
	
	// 임시 로그인
	@RequestMapping(value = "tempLogin", method = RequestMethod.GET)
	public String tempLogin(Model model) {
		Member m = new Member(25, "5@naver.com", "5", "옥철_TEST", 1, "주관리자", "옥철_TESTID", 'Y', "kotlin,javascript,python",
				new Date(), new Date(), 180, 0, new Date(), null);
		model.addAttribute("loginMember", m);
		return "redirect:/";
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
	
	// 비밀번호 확인
	@RequestMapping(value = "mypage/pwdCheck", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String pwdCheck(@RequestParam(value="mPwd") String mPwd, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String curPwd = loginMember.getmPwd();
		
		JSONObject job = new JSONObject();
		
		if(bcryptPasswordEncoder.matches(mPwd, curPwd)){
			job.put("result", true);
		}
		
		return job.toJSONString(); // toJSONString();
	}
	
	
	// 회원 탈퇴
	@RequestMapping("member/{mNo}")
	public String deleteMember(@PathVariable("mNo") int mNo, Model model, SessionStatus status) {
		System.out.println(mNo);
		// 삭제할 아이디 mService로 넘겨주기
		int result = mService.deleteMember(mNo);

		if(result > 0) {
			model.addAttribute("msg", "회원 정보 삭제 완료");
		} else {
			model.addAttribute("msg", "회원 정보 삭제 실패");
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
	
	// 닉네임 중복체크
	@RequestMapping("dupnick")
	public ModelAndView inckDuplicateCheck(String mNick, ModelAndView mv) {
		
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
		Member loginMember = (Member) request.getSession().getAttribute("loginMember");
		if (loginMember.getmNo() != mNo) {
			model.addAttribute("msg", "조회된 목록이 없습니다.");
		}
		List<Board> bList = bService.selectArticleByUser(mNo);
		List<Reply> rList = bService.selectReplyByUser(mNo);
		List<Board> sList = bService.selectStarArticleByUser(mNo);
		
		model.addAttribute("bList", bList);
		model.addAttribute("rList", rList);
		model.addAttribute("sList", sList);
	
		System.out.println(sList);

		return "mypage";
	}

	@RequestMapping(value = "mypage/{mNo}", method = RequestMethod.POST)
	public String memberUpdate(Member m, Model model, @PathVariable("mNo") int mNo) {
		m.setmNo(mNo);

		int result = mService.updateMemberNick(m);

		if (result > 0) {
			Member updateM = mService.selectMemberByMNo(mNo);
			model.addAttribute("loginMember", updateM)
				 .addAttribute("msg", "정보 수정 완료.");
		} else {
			throw new MemberException("정보 수정 실패!");
		}

		return "mypage";
		
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
}
