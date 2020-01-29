package com.team34.codehappy.blog;

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
	
	
}
