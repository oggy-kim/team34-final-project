package com.team34.codehappy.member;

import java.util.HashMap;
import java.util.List;

import com.team34.codehappy.member.Member;

public interface MemberService {
   // 회원 로그인
   public Member loginMember(Member m);
   
   // 회원 가입
   public void insertMember(Member m) throws Exception;

   // 소셜 회원가입
   public void insertMemberViaSocial(Member m);
   
   // 회원 레벨 업데이트
   public void updateMlevel(Member m)throws Exception;

   // 닉네임 정보 수정
   public int updateMemberNick(HashMap<String, Object> map);
   
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

   // 회원 정보불러오기
   public Member selectMemberByMNo(int mNo);

   // 신규 가입회원 정보불러오기
   public Member selectMemberById(String id);

   // 태그 리스트 불러오기
   public List<String> getTagList();

   

}