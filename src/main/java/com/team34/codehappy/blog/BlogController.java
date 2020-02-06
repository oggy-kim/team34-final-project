package com.team34.codehappy.blog;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.BoardService;
import com.team34.codehappy.board.Reply;
import com.team34.codehappy.member.Member;

@Controller
@RequestMapping("blog")
@SessionAttributes("msg")
public class BlogController {

	@Autowired
	private BlogService blogService;
	
	@Autowired
	private BoardService bService;
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String blogMain(Model model) {
		model.addAttribute("name", "blogmain");
		return "blog";
	}
	
	@RequestMapping(value="fetch/editorspick")
	@ResponseBody
	public Board selectEditorsPick() {
		Board b = blogService.selectEditorsPick();
		if(b.getbContent().indexOf(".png") != -1) {					
			b.setImageUrl(b.getbContent().substring(b.getbContent().indexOf("src=\"") + "src=\"".length(), b.getbContent().indexOf(".png")) + ".png");
			}
		if(b.getbContent().indexOf(".jpg") != -1) {					
		b.setImageUrl(b.getbContent().substring(b.getbContent().indexOf("src=\"") + "src=\"".length(), b.getbContent().indexOf(".jpg")) + ".jpg");
		}
		return b;
	}
	
	// 게시판 메인화면(리스트 불러오기)
		@RequestMapping(method=RequestMethod.GET)
		public ModelAndView blogList(ModelAndView mv,
				@RequestParam(value="type", required=false) String type,
				@RequestParam(value="page", required=false) Integer page,
				@RequestParam(value="limit", required=false) Integer limit) {

			int currentPage = page != null ? page : 1;
			int boardLimit = limit != null ? limit : 15;
			
			if(type == null || type.equals("all")) {
				List<Board> list = blogService.selectList(currentPage, boardLimit);
				
				int countList = blogService.getListCount();
				
				mv.addObject("bName", "모아보기").
				   addObject("countList", countList).
				   addObject("list", list).
				   addObject("type", "all").
				   addObject("pageInfo", currentPage).
				   addObject("boardLimit", boardLimit).
				   addObject("name", "bloglist");
				mv.setViewName("blog");
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
			
			List<Board> list = blogService.selectList(type, currentPage, boardLimit);
			
			int countList = blogService.getListCount(type);
			mv.addObject("list", list).
			   addObject("countList", countList).
				addObject("pageInfo", currentPage).
				addObject("boardLimit", boardLimit).
			 	addObject("name", "bloglist");
			mv.setViewName("blog");
			return mv;
		}
	
	// '더보기'로 게시글 리스트 더 출력하기
	@RequestMapping(value="fetch", method=RequestMethod.GET)
	@ResponseBody
	public List<Board> fetchView(Model model,
		@RequestParam(value="type", required=false) String type,
		@RequestParam(value="page", required=false) Integer page,
		@RequestParam(value="limit", required=false) Integer limit) {
		int currentPage = page != null ? page + 1 : 1;
		int boardLimit = limit != null ? limit : 15;
		
		
		if(type == null || type.equals("all")) {
			List<Board> list = blogService.selectList(currentPage, boardLimit);
			for(Board b : list) {
				if(b.getbContent().indexOf(".png") != -1) {					
				b.setImageUrl(b.getbContent().substring(b.getbContent().indexOf("src=\"") + "src=\"".length(), b.getbContent().indexOf(".png")) + ".png");
				}
				if(b.getbContent().indexOf(".jpg") != -1) {					
				b.setImageUrl(b.getbContent().substring(b.getbContent().indexOf("src=\"") + "src=\"".length(), b.getbContent().indexOf(".jpg")) + ".jpg");
				}
			}
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
		List<Board> list = blogService.selectList(type, currentPage, boardLimit);
	return list;
	}
	
	
	
	
	// 블로그 글 세부 보기
	@RequestMapping(value="{aNo}", method=RequestMethod.GET)
	public ModelAndView boardDetail(Model model, ModelAndView mv, @PathVariable("aNo") int aNo, 
			HttpServletRequest request, HttpServletResponse response) {
		Board board = null;
		List<Reply> rList = null;
		List<Reply> replyList = new ArrayList<Reply>();
		List<Reply> reReplyList = new ArrayList<Reply>();
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		
		// 회원별 찜하기 정보 가져오기
		if(loginMember == null) {
			mv.addObject("star", 0);
		} else {
			HashMap<String, Integer> starMap = new HashMap<String, Integer>();
			starMap.put("mNo", loginMember.getmNo());
			starMap.put("aNo", aNo);
			int star = bService.getStarCountByArticle(starMap);
			mv.addObject("star", star);
		}
		
		// 글 읽음 상태에 대한 쿠키값 설정(1일 내 조회 증가 2회 방지)
		boolean flag = false;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c: cookies) {
				if(c.getName().equals("blogaNo"+aNo)) {
					flag = true;
				}
			}
			
			if(!flag) {
				Cookie c = new Cookie("blogaNo"+aNo, String.valueOf(aNo));
				c.setMaxAge(1 * 24 * 60 * 60);
				response.addCookie(c);
			}
			board = bService.selectArticle(aNo, flag);
			rList = bService.selectReplyList(aNo);
			
			
			for(Reply r : rList) {
				if(r.getRefRNo() == 0) {
					replyList.add(r);
				}
			}
			for(Reply r : rList) {
				if(r.getRefRNo() != 0) {
					reReplyList.add(r);
				}
			}
		}
		Gson gson = new Gson();
		if(board != null) {
			mv.addObject("name", "blogdetail").
			   addObject("board", board).
			   addObject("reply", replyList).
			   addObject("jsonReply", gson.toJson(replyList)).
			   addObject("jsonReReply", gson.toJson(reReplyList)).
			   addObject("reReply", reReplyList).
			   setViewName("blog");
		}
		return mv;
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

		return "redirect:/blog/?type=all";
	}
	
	// 이미지 업로드 관련
	@ResponseBody
	@RequestMapping(value="imageUpload.do", method=RequestMethod.POST)
	public JsonObject uploadImage(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("upload") MultipartFile upload) throws Exception {
		String originalFile = upload.getOriginalFilename();
		String originalFileExtension = originalFile.substring(originalFile.lastIndexOf("."));

		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
		
		String url = request.getSession().getServletContext().getRealPath("/resources/images/blog/");

		File file = new File(url + storedFileName);
		upload.transferTo(file);
		
		JsonObject json = new JsonObject();
		json.addProperty("uploaded", 1);
		json.addProperty("fileName", storedFileName);
		json.addProperty("url", "/codehappy/resources/images/blog/" + storedFileName);

		return json;
	}
	
	
	// 댓글 좋아요 클릭
		@RequestMapping(value="{aNo}/comment/like", method=RequestMethod.POST)
		public String addReplyLike(Model model, @PathVariable("aNo") int aNo, Integer rNo,
				HttpServletRequest request, HttpServletResponse response) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			// 글 읽음 상태에 대한 쿠키값 설정(1일 내 좋아요 증가 2회 방지)
			boolean flag = false;
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie c: cookies) {
					if(c.getName().equals("rNoLike"+rNo)) {
						flag = true;
						model.addAttribute("msg", "연속된 좋아요 클릭은 안돼요~");
						return "redirect:/blog/" + aNo;
					}
				}
				
				Reply r = bService.selectReplyMember(rNo);
				
				if(!flag) {
					Cookie c = new Cookie("aNoLike"+rNo, String.valueOf(rNo));
					c.setMaxAge(1 * 24 * 60 * 60);
					response.addCookie(c);
					if(loginMember != null && loginMember.getmNo() == r.getmNo()) {
						model.addAttribute("msg", "본인 댓글에 좋아요를 누르실 수 없습니다.");
						return "redirect:/blog/" + aNo;
					}
					int result = bService.addReplyLike(rNo);
					
					if(result > 0) {
						model.addAttribute("msg", "좋아요 클릭 완료!");
					} else {
						System.out.println("추후에 수정필요(Exception)");
					}
				}
			}
			return "redirect:/blog/" + aNo;
		}
		
		
		// 게시글 좋아요 클릭
		@RequestMapping(value="{aNo}/like", method=RequestMethod.POST)
		public String addLike(Model model, @PathVariable("aNo") int aNo, Integer mNo, Integer rNo, HttpServletRequest request, HttpServletResponse response) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			// 글 읽음 상태에 대한 쿠키값 설정(1일 내 좋아요 증가 2회 방지)
				boolean flag = false;
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(Cookie c: cookies) {
						if(c.getName().equals("aNoLike"+aNo)) {
							flag = true;
							model.addAttribute("msg", "연속된 좋아요 클릭은 안돼요~");
							return "redirect:/blog/" + aNo;
						}
					}
					
					if(!flag) {
						Cookie c = new Cookie("aNoLike"+aNo, String.valueOf(aNo));
						c.setMaxAge(1 * 24 * 60 * 60);
						response.addCookie(c);
						if(loginMember != null && loginMember.getmNo() == mNo) {
							model.addAttribute("msg", "본인 글에 좋아요를 누르실 수 없습니다.");
							return "redirect:/blog/" + aNo;
						}
						int result = bService.addLike(aNo);
						
						if(result > 0) {
							model.addAttribute("msg", "좋아요 클릭 완료!");
						} else {
							System.out.println("추후에 수정필요(Exception)");
						}
					}
				}
				return "redirect:/blog/" + aNo;
		}
		
		// 게시글 찜하기 클릭
		@RequestMapping(value="{aNo}/star", method=RequestMethod.POST)
		public String addStar(Model model, int star, HttpServletRequest request, @PathVariable("aNo") int aNo, HttpServletResponse response) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			if(loginMember == null) {
				model.addAttribute("msg", "회원만 찜기능을 사용할 수 있습니다.");
				return "redirect:/blog/" + aNo;
			}
			
			HashMap<String, Integer> starMap = new HashMap<String, Integer>();
			starMap.put("aNo", aNo);
			starMap.put("mNo", loginMember.getmNo());
			
			int result = 0;
			
			// 찜하기 상태에서 넘어오면 찜삭제, 찜이 안되어 있으면 찜하기 Service로 전달
			if(star == 0) {
				result = bService.addArticleStar(starMap);
			} else {
				result = bService.removeArticleStar(starMap);
			}
			return "redirect:/blog/" + aNo;
		}
		
		
		// 댓글 달기
		@RequestMapping(value="post/{aNo}/comment", method=RequestMethod.POST)
		public String insertReply(@PathVariable("aNo") int aNo, String editor, Integer refRNo, HttpServletRequest request) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			Reply r = new Reply();
			r.setaNo(aNo);
//			r.setrContent(editor.substring(0, editor.length()- "<p>&nbsp;</p>  ".length()));
			r.setrContent(editor);
			r.setmNo(loginMember.getmNo());
			if(refRNo != null) {
				r.setRefRNo(refRNo);
			}
			
			int result = bService.insertReply(r);
			
			return "redirect:/blog/" + aNo;
		}
		
		// 대댓글 달기
		@RequestMapping(value="post/{aNo}/recomment", method=RequestMethod.POST)
		@ResponseBody
		public List<Reply> insertReply(@RequestBody HashMap<String, Object> map, 
				HttpServletRequest request) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			Reply r = new Reply();
			
			
			
			r.setaNo(Integer.parseInt(map.get("aNo").toString()));
			r.setmNo(loginMember.getmNo());
			r.setRefRNo(Integer.parseInt(map.get("refRNo").toString()));
			r.setrContent((String)map.get("rContent"));
			
			int result = bService.insertReply(r);
			List<Reply> list = bService.selectReplyList(r.getaNo());
			return list;
		}
		
		// 게시글 수정 및 삭제 페이지
		@RequestMapping(value="post/{aNo}", method=RequestMethod.GET)
		public String modifyBoardForm(@PathVariable("aNo") int aNo, 
				Model model, HttpServletRequest request) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			
			Board b = bService.selectArticle(aNo, true);
			if(!(b.getmNo() == loginMember.getmNo())) {
				model.addAttribute("msg", "글쓴이만 접근 가능합니다.");
				return "index";
			} else {
				model.addAttribute("board", b);
				model.addAttribute("name", "bloginsert");
				return "blog";
			}
		}
		
		// 게시글 수정
		@RequestMapping(value="post/{aNo}", method=RequestMethod.POST)
		public String modifyBoard(@PathVariable("aNo") int aNo,
				Model Model, Board b) {
			
			int result = bService.modifyBoard(b);

			return "redirect:/blog/" + aNo;
		}
		
		// 게시글 삭제
		@RequestMapping(value="{aNo}/delete.do", method=RequestMethod.GET)
		public String deleteBoard(@PathVariable("aNo") int aNo,
				Model model, HttpServletRequest request) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			if(loginMember.getmNo() == bService.selectArticle(aNo, true).getmNo()) {
				int result = bService.deleteBoard(aNo);
				if (result > 0) {
					model.addAttribute("msg", "글 삭제가 완료되었습니다.");
				} else {
					model.addAttribute("msg", "게시글 삭제에 실패하였습니다.");
				}
			}
			
			return "redirect:/blog";
			
		}
		
		// 댓글 삭제
		@RequestMapping(value="comment/{rNo}/delete.do", method=RequestMethod.GET)
		public String deleteReply(@PathVariable("rNo") int rNo,
				Model model, HttpServletRequest request) {
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			Reply r = bService.selectReplyMember(rNo);
			
			if(loginMember.getmNo() == r.getmNo()) {
				int result = bService.deleteReply(rNo);
				if (result > 0) {
					model.addAttribute("msg", "댓글 삭제가 완료되었습니다.");
				} else {
					model.addAttribute("msg", "댓글 삭제에 실패하였습니다.");
				}
			}
			
			return "redirect:/blog/" + r.getaNo();
			
		}
	
	// Editor's Pick 등록
	@RequestMapping(value="editorspick/{aNo}")
	public String changeEditorsPick(@PathVariable("aNo") int aNo,
			Model model, HttpServletRequest request) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		if(!loginMember.getLevelName().equals("주관리자")) {
			model.addAttribute("msg", "관리자만 해당 기능 수행이 가능합니다.");
		} else {
			int beforeANo = blogService.selectEditorsPick().getaNo();
			int result = blogService.removeEditorsPick(beforeANo);
			
			if(result > 0) {
				result = blogService.addEditorsPick(aNo);
				if(result > 0) {
					model.addAttribute("msg", "변경 성공");
				} else {
					model.addAttribute("msg", "추가 실패");
				}
			} else {
				model.addAttribute("msg", "삭제 실패");
			}
			
			
			
		}
		return "redirect:/blog/" + aNo;
	}
	
}
