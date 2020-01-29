<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Codehappy</title>
<style>
	.guide{
      display:none;
      font-size:15px;
   }
   
   .ok{
      color:green;
   }
   
   .error{
      color:red;
   }

   .pwdHiddenP {
	   display: none;
	   font-size:15px;
   }
   
</style>
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
						<input type="email" name="mId" id="mId" placeholder="이메일 *" required="">
						<!-- 아이디 사용가능 & 불가능 Start -->
						<p class="guide ok">이 이메일 주소는 사용 가능합니다.</p>
						<p class="guide error">이 이메일 주소는  사용할 수 없습니다.</p>
						<input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value="0">
						<!-- 아이디 사용가능 & 불가능 End -->
					</div>
					<div class="clear"></div>
					<div class="agile-password">
						<p>비밀번호 *</p>
						<input type="password" name="mPwd"  id="mPwd" placeholder="비밀번호 *" required="" >
						<!-- 비밀번호 유효성검사 -->
						<div class="pwdHidden">
							<div class="pwdHiddenP">
								<p class="pwdValid4">6자 이상 </p>
								<p class="pwdValid1">영문소문자 </p>
								<p class="pwdValid2">숫자포함 </p>
								<p class="pwdValid3">특수문자포함 </p>
							</div>
						</div>
					</div>
					<div class="clear"></div>
					<div class="agile-password">
						<p>비밀번호 확인 *</p>
						<input type="password" name="mPwd2" id="mPwd2" placeholder="비밀번호 확인 *" required="" >
						<!-- 비밀번호 확인 Check -->
						<div class="pwdHidden">
							<div class="pwdHiddenP">
								<p id="pwdidentityP1">일치합니다</p>
								<p id="pwdidentityP2">불일치합니다</p>
							</div>
						</div>
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
	
	<script>
		$(function(){
			$("#mId").on("keyup", function(){
				var mId = $(this).val().trim();
				
				if(mId.length < 4){
					$(".guide").hide(); // p 태그 숨기기
					$("idDupilcateCheck").val(0); // 중복 여부 확인 값 리셋

					return;
				}

				$.ajax({
					url:"dupid",
					data:{mId:mId},
					success:function(data){
						if(data.isUsable == true){
							$(".error").hide();
							$(".ok").show();
							$("#isDuplicateCheck").val(1);
						} else {
							$(".ok").hide();
							$(".error").show();
							$("#isDuplicateCheck").val(0);
						}
					},
					error:function(){
						console.log("ajax 통신 실패");
					}
				});
			});
		});
		
		$(function(){
			$("#mPwd").on("keyup", function(){
				var mPwd = $(this).val().trim();
				$('.pwdHiddenP').attr('style','display:flex');
				if($('#mPwd').val().length < 6){
					$('.pwdValid4').attr('style','display:inline-block').css('color','red');
					if($('#mPwd').val().length <= 0){
						$('.pwdValid1').attr('style','display:none');
						$('.pwdValid2').attr('style','display:none');
						$('.pwdValid3').attr('style','display:none');
						$('.pwdValid4').attr('style','display:none');
						
						return false;
					}
				} else {
						$('.pwdValid4').attr('style','display:inline-block').css('color','green');
				}

					if(/[a-z]/.test($('#mPwd').val())){
						$('.pwdValid1').attr('style','display:inline-block').css('color','green');
				}else{
						$('.pwdValid1').attr('style','display:inline-block').css('color','red');
				}
					if(/[0-9]/.test($('#mPwd').val())){
              			$('.pwdValid2').attr('style','display:inline-block').css('color','green');
           		}else{
              			$('.pwdValid2').attr('style','display:inline-block').css('color','red');
                }
					if(/[~!@#$%^&*()_+|<>?:{};=-]/.test($('#mPwd').val())){
               			$('.pwdValid3').attr('style','display:inline-block').css('color','green');
           		}else{
              			$('.pwdValid3').attr('style','display:inline-block').css('color','red');
              	return false;
				}
			});
		});

		$(function(){
			$("#mPwd2").on("keyup", function(){
				var mPwd2 = $(this).val().trim();
				$('.pwdHiddenP').attr('style','display:flex');
				if($('#mPwd2').val().length<=0){
					$('#pwdidentityP1').attr('style','display:none');
					$('#pwdidentityP2').attr('style','display:none')
				}
				else if($('#mPwd').val() == $('#mPwd2').val()){
					$('#pwdidentityP1').attr('style','display:block').css('color','green');
					$('#pwdidentityP2').attr('style','display:none');
				} else {
					$('#pwdidentityP2').attr('style','display:block').css('color','red');
					$('#pwdidentityP1').attr('style','display:none');
				}
			});
		});
			
		function validate(){
			if($("#idDuplicateCheck").val() == 0){
				alert('사용 가능한 이메일을 입력해주세요')
				$("#mId").focus();
				return false;
			}
			return true;
		}
	</script>
	
</body>
</html>