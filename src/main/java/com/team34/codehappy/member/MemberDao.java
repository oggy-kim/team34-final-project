package com.team34.codehappy.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team34.codehappy.board.Board;
import com.team34.codehappy.board.Reply;

@Repository("mDao")
public class MemberDao {
   @Autowired
   private SqlSessionTemplate sqlSession;
   
   public Member selectMember(Member m) {
      return (Member)sqlSession.selectOne("MemberMapper.selectOne", m);
   }

   public int insertMember(Member m) {
      return sqlSession.insert("MemberMapper.insertMember", m);
   }

	public int updateNick(Member m) {
		return sqlSession.update("MemberMapper.updateNick", m);
	}


   
   

}