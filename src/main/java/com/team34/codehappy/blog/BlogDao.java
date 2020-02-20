package com.team34.codehappy.blog;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team34.codehappy.board.Board;

@Repository("blogDao")
public class BlogDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public int insertBlog(Board b) {
		return sqlSession.insert("BoardMapper.insertBoard", b);
	}

	public Board selectEditorsPick() {
		return sqlSession.selectOne("BlogMapper.selectEditorsPick");
	}

	public int removeEditorsPick(int beforeANo) {
		return sqlSession.update("BlogMapper.removeEditorsPick", beforeANo);
	}

	public int addEditorsPick(int aNo) {
		return sqlSession.update("BlogMapper.addEditorsPick", aNo);
	}
}
