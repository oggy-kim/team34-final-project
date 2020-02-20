package com.team34.codehappy.blog;

import com.team34.codehappy.board.Board;

public interface BlogService {

	int insertBlog(Board b);

	Board selectEditorsPick();

	int removeEditorsPick(int beforeANo);

	int addEditorsPick(int aNo);

}
