package com.team34.codehappy.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao bDao;

	@Override
	public int getListCount() {
		int listCount = bDao.getListCount();
		
		return listCount;
	}

	@Override
	public List<Board> selectList() {
		List<Board> list = bDao.selectList();
		return list;
	}

	@Override
	public List<Board> selectList(String type) {
		List<Board> list = bDao.selectList(type);
		return list;
	}

	@Override
	public Board selectArticle(int aNo, boolean flag) {
		if(!flag) {
			bDao.addViewCount(aNo);
		}
		return bDao.selectArticle(aNo, flag);
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
}
