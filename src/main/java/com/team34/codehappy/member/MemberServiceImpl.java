package com.team34.codehappy.member;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service("mService")
public class MemberServiceImpl implements MemberService{
   @Autowired
   private MemberDao mDao;
   
   @Autowired
   private JavaMailSender mailSender;
   
   @Override
   public Member loginMember(Member m) {
      return mDao.selectMember(m);
   }

   @Override
   public void insertMember(Member m) throws Exception{
      mDao.insertMember(m);
      
      String authKey = new TempKey().getKey(50, false); 
      
      m.setAuthKey(authKey);
      
      mDao.updateAuthKey(m);
      
      // mail 작성 관련기능
      MailUtils sendMail = new MailUtils(mailSender);
      
      sendMail.setSubject("[Codehappy] 회원가입 이메일 인증");
      sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
              .append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
              .append("<a href='http://localhost:8800/codehappy/emailConfirm?mId=")
              .append(m.getmId())
              .append("&email=")
              .append(m.getmId())
              .append("&authkey=")
              .append(authKey)
              .append("' target='_blenk'>이메일 인증 확인</a>")
              .toString());
      sendMail.setFrom("codehappy34@naver.com", "codehappy[옥철&희석]");
      sendMail.setTo(m.getmId());
      sendMail.send();
      
      
   }

   // 이메일 인증 후 회원 등급 업데이트
   @Override
   public void updateMlevel(Member m) throws Exception{
	   mDao.updateMlevel(m);
   }
	@Override
	public int updateMemberNick(HashMap<String, Object> map) {
		return mDao.updateMemberNick(map);
	}
	
	@Override
	public int checkIdDup(String mId) {
		return mDao.checkIdDup(mId);
	}

	@Override
	public int checkNickDup(String mNick) {
		return mDao.checkNickDup(mNick);
	}

	@Override
	public int deleteMember(int mNo) {
		return mDao.deleteMember(mNo);
	}

	@Override
	public int updatePwd(Member m) {
		return mDao.updatePwd(m);
	}

	
	@Override
	   public int updatePwd2(Member m) {
	      return mDao.updatePwd2(m);
	   }

	@Override
	public Member selectMemberByMNo(int mNo) {
		return mDao.selectMember(mNo);
	}
}