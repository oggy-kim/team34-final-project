package com.team34.codehappy.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team34.codehappy.board.*;

@Repository("bDao")
public class BoardDao {
	@Autowired
	SqlSessionTemplate sqlSession;

	public int getListCount() {
		int result = sqlSession.selectOne("BoardMapper.getListCount");
		
		System.out.println(result);
		
		return result;
	}

	public List<Board> selectList() {
		List<Board> list = sqlSession.selectList("BoardMapper.selectList");
		return list;
	}

	public List<Board> selectList(String type) {
		List<Board> list = sqlSession.selectList("BoardMapper.selectList", type);
		return list;
	}

	public int addViewCount(int aNo) {
		return sqlSession.update("BoardMapper.updateCount", aNo);
	}

	public Board selectArticle(int aNo, boolean flag) {
		return sqlSession.selectOne("BoardMapper.selectArticle", aNo);
	}

	public List<Reply> selectReplyList(int aNo) {
		return sqlSession.selectList("ReplyMapper.selectList", aNo);
	}

	public int insertReply(Reply r) {
		return sqlSession.insert("ReplyMapper.insertReply", r);
	}

	public int addLike(int aNo) {
		return sqlSession.update("BoardMapper.addLike", aNo);
	}
}
