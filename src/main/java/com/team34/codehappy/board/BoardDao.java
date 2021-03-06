package com.team34.codehappy.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team34.codehappy.board.*;
import com.team34.codehappy.member.Member;

@Repository("bDao")
public class BoardDao {
	@Autowired
	SqlSessionTemplate sqlSession;

	public int getListCount() {
		return sqlSession.selectOne("BoardMapper.getListCount");
	}
	

	public int getListCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("BoardMapper.getListCount", map);
	}
	
	
	public List<Board> selectList(HashMap<String, Object> map) {
		int offset = ((int)(map.get("currentPage")) - 1) * (int)(map.get("boardLimit"));
		RowBounds rowBounds = new RowBounds(offset, (int)(map.get("boardLimit")));
		
		List<Board> list = sqlSession.selectList("BoardMapper.selectList", map, rowBounds);
		return list;
	}

	public int addViewCount(int aNo) {
		return sqlSession.update("BoardMapper.updateCount", aNo);
	}

	public Board selectArticle(int aNo) {
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

	public int insertBoard(Board b) {
		return sqlSession.insert("BoardMapper.insertBoard", b);
	}


	public int getStarCountByArticle(HashMap<String, Integer> starMap) {
		return sqlSession.selectOne("BoardMapper.getStarCountByArticle", starMap);
	}


	public int addArticleStar(HashMap<String, Integer> starMap) {
		return sqlSession.insert("BoardMapper.addArticleStar", starMap);
	}


	public int removeArticleStar(HashMap<String, Integer> starMap) {
		return sqlSession.delete("BoardMapper.removeArticleStar", starMap);
	}

	public List<Board> selectArticleByUser(int mNo) {
		return sqlSession.selectList("BoardMapper.selectBoardList", mNo);
	}
  
	public List<Reply> selectReplyByUser(int mNo) {
		return sqlSession.selectList("ReplyMapper.selectReplyList", mNo);
	}
	
	public int addReplyLike(Integer rNo) {
		return sqlSession.update("BoardMapper.addReplyLike", rNo);
	}

	public List<Board> searchList(HashMap<String, Object> map) {
		return sqlSession.selectList("BoardMapper.searchList", map);
	}


	public int modifyBoard(Board b) {
		return sqlSession.update("BoardMapper.modifyBoard", b);
	}


	public int deleteBoard(int aNo) {
		return sqlSession.update("BoardMapper.deleteBoard", aNo);
	}


	public Reply selectReplyMember(int rNo) {
		return sqlSession.selectOne("ReplyMapper.selectReplyMember", rNo);
	}


	public int deleteReply(int rNo) {
		return sqlSession.update("ReplyMapper.deleteReply", rNo);
	}


	public List<Board> selectStarArticleByUser(int mNo) {
		return sqlSession.selectList("BoardMapper.selectStarArticleByUser", mNo);
	}



}
