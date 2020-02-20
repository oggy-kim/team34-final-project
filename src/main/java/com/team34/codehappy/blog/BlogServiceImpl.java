package com.team34.codehappy.blog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team34.codehappy.board.Board;

@Service("blogService")
public class BlogServiceImpl implements BlogService {

	@Autowired
	BlogDao blogDao;

	@Override
	public int insertBlog(Board b) {
		return blogDao.insertBlog(b);
	}

	@Override
	public Board selectEditorsPick() {
		return blogDao.selectEditorsPick();
	}

	@Override
	public int removeEditorsPick(int beforeANo) {
		return blogDao.removeEditorsPick(beforeANo);
	}

	@Override
	public int addEditorsPick(int aNo) {
		return blogDao.addEditorsPick(aNo);
	}
	
	
}
