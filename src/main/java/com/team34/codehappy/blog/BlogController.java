package com.team34.codehappy.blog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.team34.codehappy.board.BoardService;

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
}
