package com.team34.codehappy.board;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.team34.codehappy.member.Member;

@Controller
@RequestMapping("board")
@SessionAttributes("msg")
public class BoardController {
	@Autowired
	private BoardService bService;
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="fetch", method=RequestMethod.GET)
	@ResponseBody
	public List<Board> fetchView(Model model,
			@RequestParam(value="type", required=false) String type,
			@RequestParam(value="page", required=false) Integer page,
			@RequestParam(value="limit", required=false) Integer limit) {
		int currentPage = page != null ? page + 1 : 1;
		int boardLimit = limit != null ? limit : 15;
		
		System.out.println("fetch 글 보기 limit : " + boardLimit);
		System.out.println("글 전체 보기 type : " + type);
		System.out.println("리스트 보기 전 currentPage : " + currentPage);
		
		
		if(type == null || type.equals("none")) {
			List<Board> list = bService.selectList(currentPage, boardLimit);
			return list;
		} else if(type.equals("frontend")) {
			type = "1";
		} else if(type.equals("backend")) {
			type = "2";
		} else if(type.equals("others")) {
			type = "3";
		} else if(type.equals("freetalk")) {
			type = "4";
		} else {
			
		}
		List<Board> list = bService.selectList(type, currentPage, boardLimit);
		return list;
	}
	
	
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView boardList(ModelAndView mv,
			@RequestParam(value="type", required=false) String type,
			@RequestParam(value="page", required=false) Integer page,
			@RequestParam(value="limit", required=false) Integer limit) {

		int currentPage = page != null ? page : 1;
		int boardLimit = limit != null ? limit : 15;
		
		System.out.println("글 보기 limit : " + boardLimit);
		System.out.println("글 전체 보기 type : " + type);
		System.out.println("글 전체 보기 currentPage : " + currentPage);
		System.out.println("글 전체 보기 page : " + page);
		
		if(type == null) {
			List<Board> list = bService.selectList(currentPage, boardLimit);
			
			int countList = bService.getListCount();
			
			mv.addObject("bName", "모아보기").
			   addObject("countList", countList).
			   addObject("list", list).
			   addObject("type", "none").
			   addObject("pageInfo", currentPage).
			   addObject("boardLimit", boardLimit).
			   addObject("name", "boardlist");
			mv.setViewName("board");
			return mv;
		} else if(type.equals("frontend")) {
			type = "1";
			mv.addObject("bName", "프론트엔드").
			   addObject("type", "frontend");
		} else if(type.equals("backend")) {
			type = "2";
			mv.addObject("bName", "백엔드").
			   addObject("type", "backend");
		} else if(type.equals("others")) {
			type = "3";
			mv.addObject("bName", "그외 프로그래밍 관련").
			   addObject("type", "others");
		} else if(type.equals("freetalk")) {
			type = "4";
			mv.addObject("bName", "프리톡").
			   addObject("type", "freetalk");
		} else {
			mv.addObject("msg", "잘못된 검색값 입력");
			mv.setViewName("common/errorpage");
			return mv;
		}
		
		List<Board> list = bService.selectList(type, currentPage, boardLimit);
		
		int countList = bService.getListCount(type);
		mv.addObject("list", list).
		   addObject("countList", countList).
			addObject("pageInfo", currentPage).
			addObject("boardLimit", boardLimit).
		 	addObject("name", "boardlist");
		mv.setViewName("board");
		return mv;
	}
	
	
	// 게시글 상세 보기 
	@RequestMapping(value="{aNo}", method=RequestMethod.GET)
	public ModelAndView boardDetail(ModelAndView mv, @PathVariable("aNo") int aNo, 
			HttpServletRequest request, HttpServletResponse response) {
		Board board = null;
		List<Reply> rList = null;
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		// 회원별 찜하기 정보 가져오기
		if(loginMember == null) {
			mv.addObject("star", 0);
		} else {
			HashMap<String, Integer> starMap = new HashMap<String, Integer>();
			starMap.put("mNo", loginMember.getmNo());
			starMap.put("aNo", aNo);
			int star = bService.getStarCountByArticle(starMap);
			System.out.println("star : " + star);
			mv.addObject("star", star);
		}
		
		// 글 읽음 상태에 대한 쿠키값 설정(1일 내 조회 증가 2회 방지)
		boolean flag = false;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c: cookies) {
				if(c.getName().equals("aNo"+aNo)) {
					flag = true;
				}
			}
			
			if(!flag) {
				Cookie c = new Cookie("aNo"+aNo, String.valueOf(aNo));
				c.setMaxAge(1 * 24 * 60 * 60);
				response.addCookie(c);
			}
			board = bService.selectArticle(aNo, flag);
			rList = bService.selectReplyList(aNo);
		}
		
		if(board != null) {
			mv.addObject("name", "boarddetail").
			   addObject("board", board).
			   addObject("reply", rList).
			   setViewName("board");
		}
		return mv;
	}
	
	// 게시글 좋아요 클릭
	@RequestMapping(value="{aNo}/like", method=RequestMethod.POST)
	public String addLike(Model model, int aNo, Integer mNo, HttpServletRequest request, HttpServletResponse response) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		System.out.println("aNo : " + aNo);
		System.out.println("mNo : " + mNo);
		// 글 읽음 상태에 대한 쿠키값 설정(1일 내 좋아요 증가 2회 방지)
			boolean flag = false;
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie c: cookies) {
					if(c.getName().equals("aNoLike"+aNo)) {
						flag = true;
						model.addAttribute("msg", "연속된 좋아요 클릭은 안돼요~");
						return "redirect:/board/" + aNo;
					}
				}
				
				if(!flag) {
					Cookie c = new Cookie("aNoLike"+aNo, String.valueOf(aNo));
					c.setMaxAge(1 * 24 * 60 * 60);
					response.addCookie(c);
					if(loginMember != null && loginMember.getmNo() == mNo) {
						model.addAttribute("msg", "본인 글에 좋아요를 누르실 수 없습니다.");
						return "redirect:/board/" + aNo;
					}
					int result = bService.addLike(aNo);
					
					if(result > 0) {
						model.addAttribute("msg", "좋아요 클릭 완료!");
					} else {
						System.out.println("추후에 수정필요(Exception)");
					}
				}
			}
			return "redirect:/board/" + aNo;
	}
	
	// 게시글 찜하기 클릭
	@RequestMapping(value="{aNo}/star", method=RequestMethod.POST)
	public String addStar(Model model, int star, HttpServletRequest request, @PathVariable("aNo") int aNo, HttpServletResponse response) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		HashMap<String, Integer> starMap = new HashMap<String, Integer>();
		starMap.put("aNo", aNo);
		starMap.put("mNo", loginMember.getmNo());
		
		int result = 0;
		if(star == 0) {
			result = bService.addArticleStar(starMap);
		} else {
			result = bService.removeArticleStar(starMap);
		}
		return "redirect:/board/" + aNo;
	}
	
	
	
	
	@RequestMapping(value="post/{aNo}/comment", method=RequestMethod.POST)
	public String insertReply(@PathVariable("aNo") int aNo, String editor, Integer refRNo, HttpServletRequest request) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		Reply r = new Reply();
		
		r.setaNo(aNo);
		r.setrContent(editor);
		r.setmNo(loginMember.getmNo());
		if(refRNo != null) {
			r.setRefRNo(refRNo);
		}
		
		int result = bService.insertReply(r);
		
		return "redirect:/board/" + aNo;
	}
	
	// 게시글 작성
	// 게시글 작성 화면으로 이동
	@RequestMapping(value="post", method=RequestMethod.GET)
	public ModelAndView insertBoard(ModelAndView mv) {
		mv.addObject("name", "boardinsert").
		   setViewName("board");
		return mv;
	}
	
	@RequestMapping(value="post", method=RequestMethod.POST)
	public String insertBoard(HttpServletRequest request, HttpServletResponse response,
							Board b) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		b.setaType(1);	
		b.setmNo(loginMember.getmNo());
		
		int result = bService.insertBoard(b);

		return "redirect:/board/";
	}
}
