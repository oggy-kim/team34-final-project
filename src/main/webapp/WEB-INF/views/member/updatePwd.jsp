<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String msg = (String)session.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>codehappy</title>
   <style>
      body{
      	background-color:#2a54a1;
      }
      .updatemPwd-input{
	      margin:auto;
	      margin-top:2%;
	      display:block;
	      overflow: hidden;
	      cursor: pointer;
	      text-align: center;
	      white-space: nowrap;
	      color: #2b6cae;
	      outline: none;
	      border-radius: 0.5em;
	      border: 1px solid #efefef;
	      width:50%;
	      height:30px;
      }
      #head{
         color:#fff;
      }
      input::placeholder {
        color: #2b6cae; 
      }
      #headTitle {
      margin:auto;
      text-align : center;
      padding-top: 10px;
      border-bottom: 1px solid #E2E2E2;
      }
      button{
      width:100%;
      background-color: #fff;
      border:1px solid #efefef;
      border-radius:0.5em;
      height:30px;
      color:#2b6cae;
      
      }
      button:hover{
      background-color:#99ccff;
      color:#fff;
      }
      #button-div{
      width:100%;
      }
      #button-margin{
         margin:auto;
         width:40%;
      }
      #findPwd{
         margin-top:5%;
      }
      #cancel{
         margin-top:3%;
      }

      #pwdHiddenP {
         display: none;
         width: 51%;
         margin-left: 25%;
      }

      #pwdOk {
         display: none;
         margin: auto;
         margin-left: 43%;
      }
      
      #pwdNo {
         display: none;
         margin: auto;
         margin-left: 43%;
      }

      #pwdidentityP1 {
         display: none;
         margin-left: 43%;
      }
      
      #pwdidentityP2 {
         display: none;
         margin-left: 43%;
      }

   </style>
</head>
<body>
    <!-- <script>
        <c:if test="${ !empty msg }">
        	alert('${msg}');
        <c:remove var="msg"/>
        </c:if>
    </script> -->

    <script>
        var msg = "<%= msg %>";
        
        $(function(){
            if(msg != "null"){
                alert(msg);
            }	
            if(msg == "비밀번호가 변경되었습니다."){
                window.close();
            }
        });
    </script>


 <div id="headTitle">
      <h2 id="head">비밀번호 재설정</h2>
</div>
   <form action="updatePwd" id="updateForm" method="POST" onsubmit="return checkPwd()"><!-- onsubmit="return checkPwd()" -->
   <div id="total">
      <label for="curPwd" class="col-form-label"></label>
      <input type="password" name="mPwd"  id="mPwd" placeholder="현재 비밀번호 *" class="updatemPwd-input" onkeyup="pwdCheck()" required>
      <p id="pwdOk">일치합니다</p>
      <p id="pwdNo">불일치합니다</p>
      <input type="hidden" name="passwordCheck" id="passwordCheck" value="0">
      <label for="mdfPwd" class="col-form-label"></label>
      <input type="password" name="newmPwd"  id="newmPwd" placeholder="변경할 비밀번호 *" class="updatemPwd-input" onkeyup="pwdvalid()" required>
      <div id="pwdHidden">
        <div id="pwdHiddenP">
            <p id="pwdValid4">6자 이상</p><p id="pwdValid1">영문소문자</p><p id="pwdValid2">숫자포함</p><p id="pwdValid3">특수문자포함</p>
        </div>
      </div>
      <label for="chkPwd" class="col-form-label"></label>
      <input type="password" name="newmPwd2"  id="newmPwd2" placeholder="변경할 비밀번호 재입력 *" class="updatemPwd-input" onkeyup="pwdidentitycheck()" required>
      <p id="pwdidentityP1">일치합니다</p>
      <p id="pwdidentityP2">불일치합니다</p>

      <div id="button-div">
        <br>
         <div id="button-margin">
            <button id="submitBtn" type="submit">확인</button>
            <button id="cancel" onclick="self.close()" >취소</button>
         </div>
      </div>
   </div>
   </form>   
      
    <script>
        var flag = true;

        $("#submitBtn").on("click", function(){
            if(flag){
                $("#updateForm").submit();
            } else {
                alert("잘못된 정보입니다.");
            }
        });

        function pwdCheck(){
            var mPwd = $("#mPwd").val().trim();
            console.log(mPwd);
            
            if(mPwd.length <=0){
                $("#pwdNo").attr("style", "display:none");
                $("#pwdOk").attr("style", "display:none");
                return false;
            }

            $.ajax({
                url:"pwdCheck",
                dataType:"json",
                data:{mPwd:mPwd},
                success:function(data){
                    if(data.result == true){
                        $("#pwdOk").attr("style", "display:inline-block").css("color", "green");
                        $("#pwdNo").attr("style", "display:none");
                    
                        flag = true;
                    } else {
                        $("#pwdOk").attr("style", "display:none");
                        $("#pwdNo").attr("style", "display:inline-block").css("color", "red");

                        flag = false;
                    }
                    
                },
                error:function(e){
                    console.log(e);
                }
            })
        }

        function pwdvalid(){
            console.log("pwdvalid 작동중");
            var flag = true;
        
        if($("#newmPwd").val().length < 6){
            $("#pwdValid4").attr("style", "display:inline-block").css("color", "red");
            $("#pwdHiddenP").attr("style", "display:flex");
  
        } else {
            $("#pwdValid4").attr('style', 'display:inline-block').css('color', 'green');
        }
        

        if(/[a-z]/.test($("#newmPwd").val())){
            $("#pwdValid1").attr("style", "display:inline-block").css("color", "green");

            flag = true;
        } else {
            $("#pwdValid1").attr("style", "display:inline-block").css("color", "red");

            flag = false;
        }

        if(/[0-9]/.test($('#newmPwd').val())){
            $("#pwdValid2").attr("style", "display:inline-block").css("color", "green");

            flag = true;
        } else {
            $("#pwdValid2").attr("style", "display:inline-block").css("color", "red");
              
            flag = false;
        }

        if(/[~!@#$%^&*()_+|<>?:{};=-]/.test($('#newmPwd').val())){
            $("#pwdValid3").attr("style", "display:inline-block").css("color", "green");
              
            flag = true;
        } else {
            $("#pwdValid3").attr("style", "display:inline-block").css("color", "red");
              
            flag = false;
        }

        if($("#newmPwd").val().length <= 0) {
                console.log(($("#newmPwd").val().length));
                $('#pwdValid1').attr('style','display:none');
                $('#pwdValid2').attr('style','display:none');
                $('#pwdValid3').attr('style','display:none');
                $('#pwdValid4').attr('style','display:none');

                flag = false;

              }
    }

    function pwdidentitycheck(){
        console.log("pwdidentity 작동중");
        if($('#newmPwd2').val().length<=0){
            $('#pwdidentityP1').attr('style','display:none');
            $('#pwdidentityP2').attr('style','display:none');

            flag = false;
        } else if($('#newmPwd').val() == $('#newmPwd2').val()){
            $('#pwdidentityP1').attr('style','display:block').css('color','green');
            $('#pwdidentityP2').attr('style','display:none');

            flag = true;
        } else { 
            $('#pwdidentityP2').attr('style','display:block').css('color','red');
            $('#pwdidentityP1').attr('style','display:none');

            flag = false;
        }
    }

    function checkPwd(){
        if(/[A-Z]+/.test($('#newmPwd').val())){
			alert("비밀번호 영대문자는 제외해주세요.");
			$('#mPwd').focus();
			return false;
		}

        if(/[a-z]+/.test($('#newmPwd').val())){

        } else {
            alert("비밀번호 영소문자를 포함해주세요.");
            $('#newmPwd').focus();
            return false;
        }

        if(/[0-9]+/.test($('#newmPwd').val())){

        } else {
            alert("비밀번호에 숫자를 포함해 주세요.");
            $('#newmPwd').focus();
            return false;
        }

        if(/[~!@#$%^&*()_+|<>?:{}]+/.test($('#newmPwd').val())){

        } else {
            alert("비밀번호 특수 문자 포함해 주세요");
            $('#newmPwd').focus();
            return false;
        }

        if($('#newmPwd').val().length<6){
			alert("비밀번호는 6글자 이상입니다!!");
			$('#newmPwd').focus();
			return false;
		}

        if($('#newmPwd').val() != $('#newmPwd2').val()){
			alert("비밀번호가 일치하지 않습니다.")
			$('#newmPwd2').focus();
			return false;
		}
    }
    </script>
</body>
</html>