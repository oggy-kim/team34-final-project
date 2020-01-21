package com.team34.codehappy;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.BoardService;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private BoardService bService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "index";
	}
	
	@RequestMapping(value="search", method=RequestMethod.GET)
	public ModelAndView search(ModelAndView mv, String aTag, String q) {
		System.out.println("query : " + q);
		System.out.println("aTag : " + aTag);
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		
		if(aTag != null) {
			map.put("aTag", "\"" + aTag + "\"");
		} else {
			map.put("query", "" + q + "");
		}
		
		System.out.println(map);
		
		List<Board> searchResult = bService.searchList(map);
		
		System.out.println(searchResult);
		
		mv.addObject("searchResult", searchResult);
		
		return mv;
	}
	
}
