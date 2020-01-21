package com.team34.codehappy.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.Reply;

@Service("mService")
public class MemberServiceImpl implements MemberService{
   @Autowired
   private MemberDao mDao;
   
   @Override
   public Member loginMember(Member m) {
      return mDao.selectMember(m);
   }

   @Override
   public int insertMember(Member m) {
      return mDao.insertMember(m);
   }

	@Override
	public int updateNick(Member m) {
		return mDao.updateNick(m);
	}


}