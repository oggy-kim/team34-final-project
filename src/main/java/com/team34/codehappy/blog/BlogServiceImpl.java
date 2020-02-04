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
	public List<Board> selectList(int currentPage, int boardLimit) {
		List<Board> list = blogDao.selectList(currentPage, boardLimit);
		return list;
	}

	@Override
	public List<Board> selectList(String type, int currentPage, int boardLimit) {
		List<Board> list = blogDao.selectList(type, currentPage, boardLimit);
		return list;
	}

	@Override
	public int getListCount() {
		return blogDao.getListCount();
	}

	@Override
	public int getListCount(String type) {
		return blogDao.getListCount(type);
	}
	
	
}
