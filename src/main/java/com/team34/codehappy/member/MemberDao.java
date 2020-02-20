package com.team34.codehappy.member;


import java.util.HashMap;
import java.util.List;

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

	public int updateMemberNick(HashMap<String, Object> map) {
		return sqlSession.update("MemberMapper.updateMemberNick", map);
	}
	
	public void updateAuthKey(Member m) {
		sqlSession.update("MemberMapper.updateAuthKey", m);
	}
  
	public void updateMlevel(Member m) {
		sqlSession.update("MemberMapper.updateMlevel", m);
	}

	public int checkIdDup(String mId) {
		return sqlSession.selectOne("MemberMapper.idCheck", mId);
	}

	public int checkNickDup(String mNick) {
		return sqlSession.selectOne("MemberMapper.nickCheck", mNick);
	}

	public int deleteMember(int mNo) {
		return sqlSession.update("MemberMapper.deleteMember", mNo);
	}

	public int updatePwd(Member m) {
		return sqlSession.update("MemberMapper.updatePwd", m);
	}

	public int updatePwd2(Member m) {
		return sqlSession.update("MemberMapper.updatePwd2", m);
	}

	public Member selectMember(int mNo) {
		return sqlSession.selectOne("MemberMapper.selectMemberByMNo", mNo);
	}

	public Member selectMember(String id) {
		return sqlSession.selectOne("MemberMapper.selectMemberById", id);
	}

	public List<String> getTagList() {
		return sqlSession.selectList("MemberMapper.getTagList");
	}
}