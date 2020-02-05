package com.team34.codehappy.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.team34.codehappy.board.BoardService;

@Controller
@RequestMapping("admin")
@SessionAttributes("msg")
public class AdminController {
	@Autowired
	private AdminService aService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String adminMain(Model model) {
		model.addAttribute("name", "main");
		return "admin";
	}
	
	@RequestMapping(value="editorsPick")
	public String editorsPick(Model model) {
		model.addAttribute("name", "editorspick");
		return "admin";
	}
	
}
