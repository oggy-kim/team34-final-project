package com.team34.codehappy.board;

import java.util.List;

public interface BoardService {
	
	// 글 갯수 count
	int getListCount();
	
	
	// 게시글 불러오기
	// 전체
	List<Board> selectList();
	// type에 따라
	List<Board> selectList(String type);

	// 글 세부읽기
	Board selectArticle(int aNo, boolean flag);

	// 댓글 리스트 불러오기
	List<Reply> selectReplyList(int aNo);

	// 댓글 등록하기
	int insertReply(Reply r);

	// 좋아요 등록하기
	int addLike(int aNo);
	
	
	
	
} 