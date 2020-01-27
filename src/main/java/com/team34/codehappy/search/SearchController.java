package com.team34.codehappy.search;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.BoardService;

@Controller
public class SearchController {
	
	@Autowired
	private BoardService bService;
	
	
	@RequestMapping(value="search", method=RequestMethod.GET)
	public ModelAndView search(ModelAndView mv, String aTag, String q) {
		System.out.println("query : " + q);
		System.out.println("aTag : " + aTag);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String searchItem = "";
		String searchType = "";

		if(aTag != null) {
			map.put("aTag", "aTag");
			map.put("searchItem", aTag);
			searchItem = aTag;
			searchType = "aTag";
		} else {
			map.put("q", "q");
			map.put("searchItem", q);
			searchItem = q;
			searchType = "q";
		}
		
		System.out.println(map);
		
		List<Board> searchResult = bService.searchList(map);
		
		List<Board> articleSearchResult = new ArrayList<>();
		List<Board> blogSearchResult = new ArrayList<>();
		
		for(Board b: searchResult) {
			if(b.getaType() == 1) {
				articleSearchResult.add(b);
			}
			else {
				blogSearchResult.add(b);
			}
		}
		
		System.out.println(articleSearchResult);
		System.out.println(blogSearchResult);
		
		mv.addObject("articleSearchResult", articleSearchResult).
		   addObject("blogSearchResult", blogSearchResult).
		   addObject("name", "searchOverview").
		   addObject("searchItem", searchItem).
		   addObject("searchType", searchType).
		   setViewName("search");
		
		return mv;
	}
	
	// 상세 검색결과 페이지 화면
	@RequestMapping(value="searchdetail")
	public String searchDetail(Model model,
			@RequestParam(value="q", required=false) String q,
			@RequestParam(value="aTag", required=false) String aTag,
			@RequestParam(value="aType") int aType) {
		String searchType = "";
		String searchItem = "";
		if(q != null) {
			searchType = "q";
			searchItem = q;
		} else {
			searchType = "aTag";
			searchItem = aTag;
		}
		model.addAttribute("name", "searchDetail").
			  addAttribute("searchType", searchType).
			  addAttribute("aType", aType).
			  addAttribute("searchItem", searchItem);
		return "search";
	}
	
	// 검색결과 fetch API를 통한 전송
	@RequestMapping(value="searchdetail/fetch")
	@ResponseBody
	public List<Board> fetchView (Model model,
			@RequestParam(value="q", required=false) String q,
			@RequestParam(value="aTag", required=false) String aTag,
			@RequestParam(value="aType", required=false) Integer aType,
			@RequestParam(value="sort", required=false) String sort) {
		List<Board> list = new ArrayList<>();
		
		HashMap<String, Object> map = new HashMap<>(); 
		map.put("aType", aType);
		
		if(sort == null || sort.equals("recent")) {
			map.put("sort", "recent");
		} else if(sort.equals("new")) {
			map.put("sort", "new");
		} else if(sort.equals("like")) {
			map.put("sort", "like");
		} else if(sort.equals("star")) {
			map.put("sort", "star");
		} else if(sort.equals("reply")) {
			map.put("sort", "reply");
		} 
		
		if(q != null) {
			map.put("q", "q");
			map.put("searchItem", q);
		} else {
			map.put("aTag", "aTag");
			map.put("searchItem", aTag);
		}
		
		System.out.println(map);
		
		list = bService.searchList(map);
		
		System.out.println("fetch" + list);
		return list;
	}
	

}
