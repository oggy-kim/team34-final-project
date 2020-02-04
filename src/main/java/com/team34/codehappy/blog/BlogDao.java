package com.team34.codehappy.blog;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
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

	public List<Board> selectList(int currentPage, int boardLimit) {
		int offset = (currentPage - 1) * boardLimit;
		RowBounds rowBounds = new RowBounds(offset, boardLimit);
		
		List<Board> list = sqlSession.selectList("BlogMapper.selectList", null, rowBounds);
		return list;
	}

	public List<Board> selectList(String type, int currentPage, int boardLimit) {
		int offset = (currentPage - 1) * boardLimit;
		RowBounds rowBounds = new RowBounds(offset, boardLimit);
		
		List<Board> list = sqlSession.selectList("BlogMapper.selectList", type, rowBounds);
		return list;
	}

	public int getListCount() {
		return sqlSession.selectOne("BlogMapper.getListCount");
	}

	public int getListCount(String type) {
		return sqlSession.selectOne("BlogMapper.getListCount", type);
	}
}
