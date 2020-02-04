package com.team34.codehappy.mail;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team34.codehappy.member.Member;
import com.team34.codehappy.member.MemberController;

@Controller
public class EmailController {
	@Autowired
	private MemberController mController;
	
	@RequestMapping("findPwdS")
	public String googlemailtest(HttpServletRequest request, Member m, 
									ModelMap mo, String mId) throws Exception{
		// 메일 관련 정보
		String host = "smtp.naver.com";
		final String username = "codehappy34@naver.com"; // 구글 이메일 주소중 @google.com 앞 주소만 기재합니다.
		final String password = "codehappy3030"; // 구글 이메일 비밀번호를 기재합니다.
		int port = 465; // 구글 587 , 네이버 465
		
		// 메일 내용
		String recipient  = mId;
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for(int i = 0; i < 10; i++) {
				int rIndex = rnd.nextInt(3);
				switch(rIndex) {
				case 0 : temp.append((char) ((int) (rnd.nextInt(26)) + 97)); 
				break;
				case 1 : temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                break;
				case 2 : temp.append((rnd.nextInt(10)));
                break;
				}
			}
			
			String AuthenticationKey = temp.toString();
			
			//메일을 발송할 이메일 주소를 기재해 준다.
			String subject = "안녕하세요. codehappy" + mId + "님의 임시 비밀번호 입니다.";
			String body = "귀하의 임시 비밀 번호는" + AuthenticationKey + "입니다. 로그인 후 비밀번호 변경을 통해 변경하여 사용해 주시기 바랍니다.";
			
			Properties props = System.getProperties();
			
			props.put("mail.smtp.host", host); 
		    props.put("mail.smtp.port", port); 
		    props.put("mail.smtp.auth", "true"); 
		    props.put("mail.smtp.ssl.enable", "true");
		    props.put("mail.smtp.ssl.trust", host);
		    
		    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		    	String un = username;
		    	String pw = password;
		    	
		    	protected PasswordAuthentication getPasswordAuthentication() {
		    		mo.addAttribute("msg", "임시비밀번호가 전송되었습니다.");
		    		return new PasswordAuthentication(un,pw);
		    	}
		    });
		    
		    session.setDebug(true);
		    Message mimeMessage = new MimeMessage(session);
		    mimeMessage.setFrom(new InternetAddress("codehappy34@naver.com"));
		    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		    mimeMessage.setSubject(subject);
		    mimeMessage.setText(body);
		    Transport.send(mimeMessage);
		    
		    m.setmId(mId);
		    m.setmPwd(AuthenticationKey);
		    
		    mController.updatePwd2(m);
		    
		    return "member/findPwd";

			
	}

}
