<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Header -->
<header id="header">
    <div class="logo"><strong>CODEHAPPY Main</strong></div>
        <ul class="icons">
            <c:choose>
                <c:when test="${ empty sessionScope.loginMember }">
                    <li><a href="${contextPath}/login" class="button">로그인</a></li>
                    <li><a href="${contextPath}/enrollView" class="button">회원가입</a></li>
                </c:when>
                <c:otherwise>
                    <strong>${loginMember.mNick}</strong> 님,&nbsp;
                    <li><a class="button small" onclick="gotoChatRoom();">채팅참여</a></li>
                    <li><a href="${contextPath}/mypage/${ loginMember.mNo }" class="button small">Mypage</a></li>
                    <li><a href="${contextPath}/logout" class="button small">로그아웃</a></li>
                </c:otherwise>
            </c:choose>
            <script>
                const gotoChatRoom = () => {
                    const room = prompt('입장할 채팅방 이름을 입력하세요.')
                    const url = `http://localhost:3000/?username=${loginMember.mNick}&userno=${loginMember.mNo}&room=\${room}`;
                    window.open(url, 'CODEHAPPY - 채팅', 'width=520, height=700');
                } 
            </script>
        </ul>
</header>