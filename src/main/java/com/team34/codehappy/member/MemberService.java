package com.team34.codehappy.member;


import com.team34.codehappy.member.Member;

public interface MemberService {
   // 회원 로그인
   public Member loginMember(Member m);

   // 회원 가입
   // public int insertMember(Member m) throws Exception;
   
   // 회원 가입
   public void insertMember(Member m) throws Exception;

   // 회원 레벨 업데이트
   public void updateMlevel(Member m)throws Exception;

   // 닉네임 수정
   public int updateNick(Member m);
   
   // 자기소개 수정
   // public int updateAboutme(Member m);

   // 아이디 중복확인
   public int checkIdDup(String mId);

   // 닉네임 중복 확인
   public int checkNickDup(String mNick);
   
   // 회원탈퇴
   public int deleteMember(int mNo);

   // 회원 비밀번호 변경
   public int updatePwd(Member m);

   // 임시 비밀번호 변경
   public int updatePwd2(Member m);

  
}