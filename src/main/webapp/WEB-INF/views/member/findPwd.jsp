<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      .findmPwd-input{
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
   </style>
</head>
<body>
    <script>
        <c:if test="${ !empty msg }">
        	alert('${msg}');
        <c:remove var="msg"/>
        </c:if>
    </script>
 <div id="headTitle">
      <h2 id="head">비밀번호 찾기</h2>
</div>
   <form action="findPwdS" method="POST" onsubmit="return findValidate()">
   <div id="total">
      <input type="email" id="mId" name="mId" placeholder="이메일  주소를 입력해주세요." class="findmPwd-input">
      <div id="button-div">
        <br>
         <div id="button-margin">
            <button id="findPwdbtn" type="submit">비밀번호찾기</button>
            <button id="cancel" onclick="self.close()" >취소</button>
         </div>
      </div>
   </div>
   </form>   
      
</body>
</html>