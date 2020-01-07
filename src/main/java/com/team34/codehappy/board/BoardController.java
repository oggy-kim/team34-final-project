package com.team34.codehappy.board;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.team34.codehappy.member.Member;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private BoardService bService;
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView boardList(ModelAndView mv) {
		int countList = bService.getListCount();
		
		List<Board> list = bService.selectList();
		
		mv.addObject("countList", countList);
		mv.addObject("list", list);
		mv.addObject("name", "boardlist");
		mv.setViewName("board");
		return mv;
	
	}
	
	@RequestMapping(value="category", method=RequestMethod.GET)
	public ModelAndView boardListByTag(ModelAndView mv,
			@RequestParam(value="type", required=false) String type) {
		if(type.equals("frontend")) {
			type = "1";
		} else if(type.equals("backend")) {
			type = "2";
		} else if(type.equals("others")) {
			type = "3";
		} else if(type.equals("freetalk")) {
			type = "4";
		} else {
			mv.addObject("msg", "잘못된 검색값 입력");
			mv.setViewName("common/errorpage");
			return mv;
		}
		
		List<Board> list = bService.selectList(type);
		mv.addObject("list", list)
		  .addObject("name", "boardlist")
		  .setViewName("board");
		return mv;
	}
	
	@RequestMapping(value="{aNo}", method=RequestMethod.GET)
	public ModelAndView boardDetail(ModelAndView mv, @PathVariable("aNo") int aNo, 
			HttpServletRequest request, HttpServletResponse response) {
		Board board = null;
		List<Reply> rList = null;
		
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
	
	@RequestMapping(value="post", method=RequestMethod.GET)
	public ModelAndView insertBoard(ModelAndView mv) {
		mv.addObject("name", "boardinsert").
		   setViewName("board");
		return mv;
	}
	
	@RequestMapping(value="{aNo}/like", method=RequestMethod.POST)
	public String addLike(Model model, int aNo, Integer mNo, HttpServletRequest request, HttpServletResponse response) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		// 글 읽음 상태에 대한 쿠키값 설정(1일 내 좋아요 증가 2회 방지)
			boolean flag = false;
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie c: cookies) {
					if(c.getName().equals("aNoLike"+aNo)) {
						flag = true;
						model.addAttribute("msg", "연속된 좋아요 클릭은 안돼요~");
						return "board/" + aNo;
					}
				}
				
				if(!flag) {
					Cookie c = new Cookie("aNoLike"+aNo, String.valueOf(aNo));
					c.setMaxAge(1 * 24 * 60 * 60);
					response.addCookie(c);
					if(loginMember.getmNo() == mNo) {
						model.addAttribute("msg", "본인 글에 좋아요를 누르실 수 없습니다.");
						return "board/" + aNo;
					}
					int result = bService.addLike(aNo);
					
					if(result > 0) {
						model.addAttribute("msg", "해당 글에 좋아요를 누르셨습니다.");
					} else {
						System.out.println("추후에 수정필요(Exception)");
					}
				}
			}
			return "board/" + aNo;
		
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
	
	
	
	
	
	
}
