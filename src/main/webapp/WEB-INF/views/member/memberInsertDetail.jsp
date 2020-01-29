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
			<h2>추가 정보 입력</h2>
				<form action="minsertdetail" method="post" id="insertdetail">
					<div class="nick-name">
						<p>닉네임 *</p>
						<input type="text" name="mNick" placeholder="닉네임 *" value="${ loginMember.mNick }" required="" autofocus>
					</div>
					<div class="clear"></div>
					<div class="agile-password">
						<p>자기소개 *</p>
						<input type="aboutMe" name="aboutMe" placeholder="자기소개 *" required="" >
					</div>
					<div class="clear"></div>
					<input type="submit" value="완료"/>
				</form>
		</div>
	</section>
</body>
</html>