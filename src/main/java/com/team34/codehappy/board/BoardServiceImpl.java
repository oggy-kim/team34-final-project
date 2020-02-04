package com.team34.codehappy.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team34.codehappy.member.Member;

@Service("bService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao bDao;

	@Override
	public int getListCount() {
		return bDao.getListCount();
	}
	
	@Override
	public int getListCount(String type) {
		return bDao.getListCount(type);
	}
	

	@Override
	public List<Board> selectList(int currentPage, int boardLimit) {
		List<Board> list = bDao.selectList(currentPage, boardLimit);
		return list;
	}

	@Override
	public List<Board> selectList(String type, int currentPage, int boardLimit) {
		List<Board> list = bDao.selectList(type, currentPage, boardLimit);
		return list;
	}

	@Override
	public Board selectArticle(int aNo, boolean flag) {
		if(!flag) {
			bDao.addViewCount(aNo);
		}
		return bDao.selectArticle(aNo);
	}

	@Override
	public List<Reply> selectReplyList(int aNo) {
		return bDao.selectReplyList(aNo);
	}

	@Override
	public int insertReply(Reply r) {
		return bDao.insertReply(r);
	}

	@Override
	public int addLike(int aNo) {
		return bDao.addLike(aNo);
	}

	@Override
	public int insertBoard(Board b) {
		return bDao.insertBoard(b);
	}

	@Override
	public int getStarCountByArticle(HashMap<String, Integer> starMap) {
		return bDao.getStarCountByArticle(starMap);
	}

	@Override
	public int addArticleStar(HashMap<String, Integer> starMap) {
		return bDao.addArticleStar(starMap);
	}

	@Override
	public int removeArticleStar(HashMap<String, Integer> starMap) {
		return bDao.removeArticleStar(starMap);
	}

	@Override
	public int addViewCount(int aNo) {
		return bDao.addViewCount(aNo);
	}

	@Override
	public List<Board> selectArticleByUser(int mNo) {
		return bDao.selectArticleByUser(mNo);
	}

	@Override
	public List<Reply> selectReplyByUser(int mNo) {
		return bDao.selectReplyByUser(mNo);
	}
	@Override
	public int addReplyLike(Integer rNo) {
		return bDao.addReplyLike(rNo);
	}

	@Override
	public List<Board> searchList(HashMap<String, Object> map) {
		return bDao.searchList(map);
	}

	@Override
	public int modifyBoard(Board b) {
		return bDao.modifyBoard(b);
	}

	@Override
	public int deleteBoard(int aNo) {
		return bDao.deleteBoard(aNo);
	}

	@Override
	public Reply selectReplyMember(int rNo) {
		return bDao.selectReplyMember(rNo);
	}

	@Override
	public int deleteReply(int rNo) {
		return bDao.deleteReply(rNo);
	}
}
