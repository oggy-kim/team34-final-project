<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Header -->
<header id="header">
    <a class="logo"><strong>CODEHAPPY Main</strong></a>
    <ul class="icons">
        <c:choose>
            <c:when test="${ empty sessionScope.loginMember }">
                <li><a href="${contextPath}/login" class="button">로그인</a></li>
                <li><a href="${contextPath}/enrollView" class="button">회원가입</a></li>
            </c:when>
            <c:otherwise>
                <strong>${loginMember.mId}</strong> 님, &nbsp;
                <li><a href="#" class="button">Mypage</a></li>
                <li><a href="${contextPath}/logout" class="button">로그아웃</a></li>
            </c:otherwise>
        </c:choose>
        <!-- <li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
        <li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
        <li><a href="#" class="icon brands fa-snapchat-ghost"><span class="label">Snapchat</span></a></li>
        <li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
        <li><a href="#" class="icon brands fa-medium-m"><span class="label">Medium</span></a></li> -->
    </ul>
</header>