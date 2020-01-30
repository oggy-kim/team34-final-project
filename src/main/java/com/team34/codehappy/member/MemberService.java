package com.team34.codehappy.member;

import com.team34.codehappy.member.Member;

public interface MemberService {
   // 1. 회원 로그인
   public Member loginMember(Member m);

   // 2. 회원 가입
   // public int insertMember(Member m) throws Exception;
   
   // 2. 회원 가입
   public void insertMember(Member m) throws Exception;

   // 3. 회원 레벨 업데이트
   public void updateMlevel(Member m)throws Exception;

   // 4. 닉네임 수정
   public int updateNick(Member m);
   
   // 5. 아이디 중복확인
   public int checkIdDup(String mId);

   // 6. 닉네임 중복 확인
   public int checkNickDup(String mNick);
  
}