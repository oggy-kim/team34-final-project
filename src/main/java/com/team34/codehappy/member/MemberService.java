package com.team34.codehappy.member;

import com.team34.codehappy.member.Member;

public interface MemberService {
   // 1. 회원 로그인
   public Member loginMember(Member m);

   // 2. 회원 가입
   public int insertMember(Member m);

   // 3. 닉네임 변경
   public int updateNick(Member m);
      
   
}