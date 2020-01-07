<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Codehappy</title>
<!-- Meta tag Keywords -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<meta name="keywords" content=" volunteer enrollment form Widget a Flat Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Meta tag Keywords -->
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/memberJoin/css/style.css" type="text/css" media="all" /><!-- Style-CSS -->
<link href="//fonts.googleapis.com/css?family=Heebo:300" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Exo" rel="stylesheet">
</head>
<body>
	<section class="agile-volt">
		<div class="agile-voltheader">
			<h1>Code <label>happy</label>!!</h1>
		</div>
		<div class="agile-voltsub">
			<h2>계정 만들기</h2>
				<form action="minsert" method="post" id="joinForm">
					<div class="nick-name">
						<p>닉네임 *</p>
						<input type="text" name="mNick" placeholder="닉네임 *" required="" autofocus>
					</div>
					<div class="clear"></div>
					<div class="agile-email">
						<p>이메일 *</p>
						<input type="email" name="mId" placeholder="이메일 *" required="">
					</div>
					<div class="clear"></div>
					<div class="agile-password">
						<p>비밀번호 *</p>
						<input type="password" name="mPwd" placeholder="비밀번호 *" required="" >
					</div>
					<div class="clear"></div>
					<div class="agile-password">
						<p>비밀번호 확인 *</p>
						<input type="password" name="mPwd2" placeholder="비밀번호 확인 *" required="" >
					</div>
					<div class="clear"></div>
					<div class="agile-work">
						<p>관심있는 프로그램 언어 *</p>
							<div class="agile-days">
								<span class="Java">
									<input type="checkbox" name="myTag" value="Java">Java<br>	
								</span>
								<span class="HTML">
									<input type="checkbox" name="myTag" value="HTML">HTML<br>					
								</span>
								<span class="JSP">
									<input type="checkbox" name="myTag" value="JSP">JSP<br>
								</span>
								<span class="Spring">
									<input type="checkbox" name="myTag" value="Spring">Spring<br>
								</span>
								<span class="C">
									<input type="checkbox" name="myTag" value="C">C<br>
								</span>
								<span class="Django">
									<input type="checkbox" name="myTag" value="Django">Django<br>
								</span>
								<span class="Android">
									<input type="checkbox" name="myTag" value="Android">Android<br>
								</span>
								<span class="Python">
									<input type="checkbox" name="myTag" value="Python">Python<br>
								</span>
								<span class="Python">
									<input type="checkbox" name="myTag" value="기타">기타<br>
								</span>
							</div>
					</div>
					<div class="clear"></div>
					<input type="submit" value="가입하기" />
				</form>
		</div>
	</section>
</body>
</html>