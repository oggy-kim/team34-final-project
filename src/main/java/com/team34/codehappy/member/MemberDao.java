package com.team34.codehappy.member;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("mDao")
public class MemberDao {
   @Autowired
   private SqlSessionTemplate sqlSession;
   
   public Member selectMember(Member m) {
      return (Member)sqlSession.selectOne("MemberMapper.selectOne", m);
   }

//   public int insertMember(Member m) {
//      return sqlSession.insert("MemberMapper.insertMember", m);
//   }
   
   public void insertMember(Member m) {
	    sqlSession.insert("MemberMapper.insertMember", m);
   }

	public int updateNick(Member m) {
		return sqlSession.update("MemberMapper.updateNick", m);
	}

	public void updateAuthKey(Member m) {
		sqlSession.update("MemberMapper.updateAuthKey", m);
	}

	public void updateMlevel(Member m) {
		sqlSession.update("MemberMapper.updateMlevel", m);
	}

//	public int checkIdDup(String id) {
//		return sqlSession.selectOne("MemberMapper.idCheck", id);
//	}

	
	

}