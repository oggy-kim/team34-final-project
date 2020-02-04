<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>CODEHAPPY - Login</title>
<script src="https://kit.fontawesome.com/0d0e2ec841.js"	crossorigin="anonymous"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords"
	content="Slide Login Form template Responsive, Login form web template, Flat Pricing tables, Flat Drop downs Sign up Web Templates, Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

<script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
		}
	</script>


<!-- Custom Theme files -->
<link href="resources/login/css/style.css" rel="stylesheet"	type="text/css" media="all" />
<link href="resources/login/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"	rel="stylesheet" media="all" />
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
			<h1>Login Form</h1>
			<div class="header-main">
				<div class="main-icon">
					<span class="fa fa-circle-o-notch"></span>
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
						<div class="social">
							<ul>
								<li>Social login using :</li>
								<li class="sc-iRbamj eFTwYY">
									<button type="button" class="btn social">
										<svg enable-background="new 0 0 100 100" height="20px"
											id="Layer_1" version="1.1" viewBox="0 0 512 512" width="20px"
											xml:space="preserve" xmlns="http://www.w3.org/2000/svg"
											xmlns:xlink="http://www.w3.org/1999/xlink">
											<g>
											<circle cx="255.999" cy="256" r="246.455" />
											</g>
											<g>
											<path
												d="M55.486,231.011h28.315c0,0,25.719,38.858,26.483,39.905c0.769,1.041,0.861,0,0.861,0   c-1.184-6.02-2.473-8.717-2.473-18.328v-21.577h28.205v71.977h-28.205c0,0-25.189-36.781-25.952-37.801   c-0.759-1.018-0.862,0-0.862,0c0.971,4.969,1.832,5.795,1.832,14.416v23.385H55.484L55.486,231.011L55.486,231.011z"
												fill="#FFFFFF" />
											<path
												d="M181.342,276.93l3.85-14.607c0.829-2.959,1.4-7.21,1.4-7.21c0.122-0.653,1.025-0.653,1.18,0.032   c0.185,1.002,0.635,4.063,1.496,7.114l3.924,14.672H181.342z M176.064,294.018h22.299l2.688,8.969h31.222l-28.962-71.975h-32.623   l-28.211,71.977h31.228L176.064,294.018z"
												fill="#FFFFFF" />
											<path
												d="M306.575,231.011l-31.436,71.977h-24.981l-31.438-71.977h30.792l10.769,32.743   c1.184,3.531,2.044,11.287,2.044,11.287c0.203,0.611,0.924,0.57,1.041,0c0,0,0.861-7.756,2.048-11.287l10.368-32.743H306.575z"
												fill="#FFFFFF" />
											<path
												d="M312.71,231.011h54.595v19.669H342.43v6.869h22.721v18.709H342.43v7.066h25.733v19.664H312.71V231.011   L312.71,231.011z"
												fill="#FFFFFF" />
											<path
												d="M409.026,250.68h2.267c5.059,0,9.47,0.661,9.47,6.202c0,5.342-4.845,6.015-9.692,6.015h-2.044V250.68z    M380.175,302.992h28.851v-23.106c0,0,0.188-0.82,0.738,0l12.725,23.104h34.027l-17.662-23.393c-1.62-2.096-4.344-3.895-4.953-4.29   c-0.607-0.405,0-0.581,0-0.581c10.979-3.244,15.72-7.821,15.72-18.708c0-18.136-15.509-25.01-33.81-25.01h-35.636V302.992   L380.175,302.992z"
												fill="#FFFFFF" />
											</g>
											</svg>
										<div>네이버로 로그인하기</div>

										<li class="sc-iRbamj eFTwYY">
											<button type="button" class="btn social">
												<svg xmlns="http://www.w3.org/2000/svg" width="20px"
													height="20px" viewBox="0 0 48 48">
											<path fill="#EA4335"
														d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
											<path fill="#4285F4"
														d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
											<path fill="#FBBC05"
														d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
											<path fill="#34A853"
														d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
											<path fill="none" d="M0 0h48v48H0z"></path>
											</svg>
												<div>구글로 로그인하기</div>
											</button>
										</li>
							</ul>
						</div>
					</form>
				</div>
				<!-- <div class="social">
				<ul>
					<li>Social login using : </li>
					<li><a href="#" class="google"><span class="fa fa-google-plus"></span></a></li>&nbsp;
					<li><a href="#" class="github"><span class="fa fa-github"></span></a></li>
				</ul>
			</div> -->
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
		 if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
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