package com.team34.codehappy.blog;

import java.util.List;

import com.team34.codehappy.board.Board;

public interface BlogService {

	int insertBlog(Board b);

	List<Board> selectList(int currentPage, int boardLimit);

	List<Board> selectList(String type, int currentPage, int boardLimit);

	int getListCount();
	
	int getListCount(String type);

}
