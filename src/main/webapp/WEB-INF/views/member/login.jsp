<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>CODEHAPPY - Login</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords"
	content="Slide Login Form template Responsive, Login form web template, Flat Pricing tables, Flat Drop downs Sign up Web Templates, Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />


<!-- Custom Theme files -->
<link href="resources/login/css/style.css" rel="stylesheet"	type="text/css" media="all" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"	rel="stylesheet" media="all" />
<link href="resources/login/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
<!-- //Custom Theme files -->

<!-- web font -->
<link href="//fonts.googleapis.com/css?family=Hind:300,400,500,600,700"	rel="stylesheet">
<link rel="icon" type="image/png" href="${ pageContext.servletContext.contextPath }/resources/images/common/siteicon.png">
</head>
<body>
	<script>
		<c:if test="${!empty msg }">
			alert('${ msg }');
			<c:remove var="msg"/>
		</c:if>
	</script>

	<!-- main -->
	<div class="w3layouts-main">
		<div class="bg-layer">
			<h1>Login page</h1>
			<div class="header-main">
				<div class="main-icon">
					<span class="fa fa-eercast"></span>
				</div>
				<div class="header-left-bottom">
					<form action="login" method="post">
						<div class="icon1">
							<span class="fa fa-user"></span> <input type="email" id="mId"
								name="mId" placeholder="Email Address" required="" />
						</div>
						<div class="icon1">
							<span class="fa fa-lock"></span> <input type="password" id="mPwd"
								name="mPwd" placeholder="Password" required="" />
						</div>
						<div class="login-check">
							<label class="checkbox">
							<input type="checkbox" id="idSaveCheck" name="checkbox" checked="" >
							<i> </i> 아이디 저장하기
							</label>
						</div>
						
						<div class="bottom">
							<button class="btn">로그인</button>
						</div>
						
						<div class="links">
							<p>
								<a href="#" onclick="searchPwd();">패스워드 찾기</a>
							</p>
							<p class="right">
								<a href="enrollView">회원가입</a>
							</p>
							<div class="clear"></div>
						</div>
					</form>
				</div>
				<div class="social">
				<ul>
					<li>Social login using : </li>
					<li><a href="${kakao_url}" class="google">
						<img src="${contextPath}/resources/images/common/kakao_image.jpg" style="border-radius:50%; vertical-align: bottom;">
					</a></li>&nbsp;
					<li><a href="${github_url}" class="github">
						<img src="${contextPath}/resources/images/common/github.png" style="border-radius:50%; vertical-align: bottom;">
					</a></li>
				</ul>
			</div>
			</div>

			<!-- copyright -->
			<div class="copyright">
				<p>
					© 2019 Slide Login Form . All rights reserved | Design by <a
						href="http://w3layouts.com/" target="_blank">W3layouts</a>
				</p>
			</div>
			<!-- //copyright -->
		</div>
	</div>
	<!-- //main -->

	<script>
	function searchPwd(){
		window.open('findPwd1','비밀번호찾기','width=500, height=300, left=300, top=150');
	}
	</script>

	<script>
	$(document).ready(function(){
	 
	 // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	 var key = getCookie("key");
	 $("#mId").val(key); 
	  
	 if($("#mId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		 $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	 }
	  
	 $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		 if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
			 setCookie("key", $("#mId").val(), 7); // 7일 동안 쿠키 보관
		 }else{ // ID 저장하기 체크 해제 시,
			 deleteCookie("key");
		 }
	 });
	  
	 // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	 $("#mId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		 if($("#idSaveCheck").is(":checked")){  /* ID 저장하기를 체크한 상태라면  */
			 setCookie("key", $("#mId").val(), 7); // 7일 동안 쿠키 보관
		 }
	 });
	});
	 
	function setCookie(cookieName, value, exdays){
	 var exdate = new Date();
	 exdate.setDate(exdate.getDate() + exdays);
	 var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	 document.cookie = cookieName + "=" + cookieValue;
	}
	
	function deleteCookie(cookieName){
	 var expireDate = new Date();
	 expireDate.setDate(expireDate.getDate() - 1);
	 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	
	function getCookie(cookieName) {
	 cookieName = cookieName + '=';
	 var cookieData = document.cookie;
	 var start = cookieData.indexOf(cookieName);
	 var cookieValue = '';
	 if(start != -1){
		 start += cookieName.length;
		 var end = cookieData.indexOf(';', start);
		 if(end == -1)end = cookieData.length;
		 cookieValue = cookieData.substring(start, end);
	 }
	 return unescape(cookieValue);
	}
	</script>

</body>
</html>