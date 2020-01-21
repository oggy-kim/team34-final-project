package com.team34.codehappy.member;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

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

			if (logger.isDebugEnabled()) {
				logger.info(loginMember.getmId() + "로그인");
			}
			model.addAttribute("loginMember", loginMember);
			return "index";
		} else {
			throw new MemberException("로그인 실패하였습니다.");
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

	// 회원가입 요청
	@RequestMapping("minsert")
	public String memberInsert(Member m, Model model) {
		String encPwd = bcryptPasswordEncoder.encode(m.getmPwd());

		m.setmPwd(encPwd);

		int result = mService.insertMember(m);

		if (result > 0) {
			model.addAttribute("msg", "회원가입이 완료되었습니다.");
			model.addAttribute("loginMember", mService.loginMember(m));
			return "index";
		} else {
			throw new MemberException("회원가입 실패");
		}
	}

	// 임시 로그인
	@RequestMapping(value = "tempLogin", method = RequestMethod.GET)
	public String tempLogin(Model model) {
		Member m = new Member(25, "5@naver.com", "5", "옥철_TEST", "주관리자", "옥철_TESTID", 'Y', "kotlin,javascript,python",
				new Date(), new Date(), 180, 0, new Date());
		model.addAttribute("loginMember", m);
		return "redirect:/";
	}

	@RequestMapping(value = "mypage/{mNo}", method = RequestMethod.GET)
	public String myPage(Model model, @PathVariable("mNo") int mNo, HttpServletRequest request, HttpServletResponse response) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		if(loginMember.getmNo() != mNo) {
			model.addAttribute("msg", "조회된 목록이 없습니다.");
		}
		List<Board> bList = bService.selectArticleByUser(mNo);
		List<Reply> rList = bService.selectReplyByUser(mNo);
		
		model.addAttribute("bList", bList);
		model.addAttribute("rList", rList);
		
		System.out.println(bList);
		System.out.println(rList);
		
		return "mypage";
	}

	@RequestMapping(value = "mypage/{mNo}", method = RequestMethod.POST)
	public String memberUpdate(Member m, Model model, @PathVariable("mNo") int mNo) {
		m.setmNo(mNo);

		
		int result = mService.updateNick(m);
		
		System.out.println(m);

		if (result > 0) {

			model.addAttribute("msg", "수정 완료.");
			model.addAttribute("loginMember", m);
			
		} else {
			throw new MemberException("수정 실패!");
		}

		return "mypage";
	}
	
	


}