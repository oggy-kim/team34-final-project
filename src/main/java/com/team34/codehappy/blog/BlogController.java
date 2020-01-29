package com.team34.codehappy.blog;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.BoardService;
import com.team34.codehappy.member.Member;

@Controller
@RequestMapping("blog")
public class BlogController {

	@Autowired
	private BlogService blogService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String blogMain(Model model) {
		model.addAttribute("name", "blogmain");
		return "blog";
	}
	
	// 게시글 작성
	// 게시글 작성 화면으로 이동
	@RequestMapping(value="post", method=RequestMethod.GET)
	public ModelAndView insertBlog(ModelAndView mv) {
		mv.addObject("name", "bloginsert").
		   setViewName("blog");
		return mv;
	}
	
	// 게시글 작성
	@RequestMapping(value="post", method=RequestMethod.POST)
	public String insertBlog(HttpServletRequest request, HttpServletResponse response,
							Board b) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		b.setaType(2);	
		b.setmNo(loginMember.getmNo());
		
		int result = blogService.insertBlog(b);

		return "redirect:/blog/";
	}
	
	
}
