package com.team34.codehappy.board;

import java.util.HashMap;
import java.util.List;

public interface BoardService {
	
	// 글 갯수 count
	int getListCount();
	int getListCount(String type);
	
	
	// 게시글 불러오기
	// 전체
	List<Board> selectList(int currentPage, int boardLimit);
	// type에 따라
	List<Board> selectList(String type, int currentPage, int boardLimit);

	// 글 세부읽기
	Board selectArticle(int aNo, boolean flag);

	// 댓글 리스트 불러오기
	List<Reply> selectReplyList(int aNo);

	// 댓글 등록하기
	int insertReply(Reply r);

	// 좋아요 등록하기
	int addLike(int aNo);

	// 게시글 등록하기
	int insertBoard(Board b);
	
	// 게시물별 찜하기 숫자 확인
	int getStarCountByArticle(HashMap<String, Integer> starMap);
	
	// 게시물에 즐겨찾기 추가/삭제
	int addArticleStar(HashMap<String, Integer> starMap);
	int removeArticleStar(HashMap<String, Integer> starMap);
	
	// 게시물 조회수 증가 
	int addViewCount(int aNo);
	
	// 마이페이지 게시글 목록 조회	
	List<Board> selectArticleByUser(int mNo);
	
	// 마이페이지 답변 목록 조회
	List<Reply> selectReplyByUser(int mNo);
  
	// 댓글 좋아요 등록하기
	int addReplyLike(Integer rNo);
	
	// 검색 리스트 불러오기
	List<Board> searchList(HashMap<Object, Object> map);
	
	
	
	
} 