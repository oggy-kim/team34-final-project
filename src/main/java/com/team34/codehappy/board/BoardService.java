package com.team34.codehappy.board;

import java.util.HashMap;
import java.util.List;

import com.team34.codehappy.member.Member;

public interface BoardService {
	
	// 글 갯수 count
	int getListCount(HashMap<String, Object> map);
	
	
	// 게시글 불러오기
	// 전체
	List<Board> selectList(HashMap<String, Object> map);

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
	List<Board> searchList(HashMap<String, Object> map);
	
	// 게시글 수정하기
	int modifyBoard(Board b);
	
	// 게시글 삭제하기
	int deleteBoard(int aNo);
	
	// 삭제 댓글 정보 확인을 위한 불러오기
	Reply selectReplyMember(int rNo);
	
	// 댓글 삭제하기
	int deleteReply(int rNo);
	
	// 회원별 찜리스트 불러오기
	List<Board> selectStarArticleByUser(int mNo);
	
	
	
	
	
} 