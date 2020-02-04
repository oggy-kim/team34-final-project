<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
 import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<script>
        let title_el = document.querySelector("title");
        let title_header = document.querySelector("#header strong");
        
        if(title_el && title_header)
            title_el.innerHTML = "CODEHAPPY - ${searchItem} 검색결과";
            title_header.innerHTML = "CODEHAPPY 검색 🕵️‍♂️🔍";
        </script>
<section>
    <header class="major">
        <h2>검색결과 - ${searchItem}</h2>
    </header>
        <h3>게시판 (${fn:length(articleSearchResult)} 개 검색결과)</h3> 
    <div class="table-wrapper">
        <table class="board-wrapper" id="board">
            <tbody>
                <c:if test="${fn:length(articleSearchResult) eq 0}">해당 검색어에 대한 검색결과가 없습니다.</c:if>
                <c:forEach var="b" items="${articleSearchResult}" begin="0" end="9">
                <tr class="board-list" value="${b.aNo}">
                    <td>
                        <img class="profile-small" src="${contextPath}/resources/images/member/${b.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'">
                    </td>
                    <td><input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader}<br>
                        <c:set var="aTag" value="${b.aTag}"/>
                        <c:forEach var="t" items="${fn:split(aTag, ',')}">
                            <a href="${contextPath}/search/?aTag=${t}" class="button small">${t}</a>
                        </c:forEach>
                    </td>
                    <td>
                        <fmt:parseNumber value="${b.changeDate.time}" integerOnly="true" var="changeDate"/>
                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                        <c:set var="diff" value="${nowDate / 1000 - changeDate / 1000}"/>
                        <c:choose>
                            <c:when test="${diff lt 120}">
                                방금 전
                            </c:when>
                            <c:when test="${diff lt (60*60)}">
                                <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                ${minute}분 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24)}">
                                <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                ${hour}시간 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*7)}">
                                <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                ${day}일 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*30)}">
                                <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                ${week}주 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*365)}">
                                <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                ${month}달 전
                            </c:when>
                            <c:otherwise>
                                <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                ${year}년 전
                            </c:otherwise>
                        </c:choose>
                    
                        <c:choose>
                            <c:when test="${b.replyDate ne null}">
                                댓글
                            </c:when>
                            <c:otherwise>
                                새글
                            </c:otherwise>
                        </c:choose>
                    </td>    
                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; ${b.reply}</td>
                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24" fill="#626262"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/></svg>${b.like}</td>
                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>&nbsp; ${b.star}</td>
                </tr>
                </c:forEach>

            </tbody>
        </table>
        <c:if test="${fn:length(articleSearchResult) gt 10}">
            <a class="button primary" href="${contextPath}/searchdetail/?${searchType}=${searchItem}&aType=1">검색결과 자세히</a>
        </c:if>

        <hr>
        <h3>블로그 (${fn:length(blogSearchResult)} 개 검색결과)</h3> 
    <div class="table-wrapper">
        <table class="board-wrapper" id="blog">
            <tbody>
                <c:if test="${fn:length(blogSearchResult) eq 0}">해당 검색어에 대한 검색결과가 없습니다.</c:if>
                <c:forEach var="b" items="${blogSearchResult}" begin="0" end="9">
                <tr class="board-list" value="${b.aNo}">
                    <td>
                        <img class="profile-small" src="${contextPath}/resources/images/member/${b.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'">
                    </td>
                    <td><input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader}<br>
                        <c:set var="aTag" value="${b.aTag}"/>
                        <c:forEach var="t" items="${fn:split(aTag, ',')}">
                            <a href="${contextPath}/search/?aTag=${t}" class="button small">${t}</a>
                        </c:forEach>
                    </td>
                    <td>
                        <fmt:parseNumber value="${b.changeDate.time}" integerOnly="true" var="changeDate"/>
                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                        <c:set var="diff" value="${nowDate / 1000 - changeDate / 1000}"/>
                        <c:choose>
                            <c:when test="${diff lt 120}">
                                방금 전
                            </c:when>
                            <c:when test="${diff lt (60*60)}">
                                <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                ${minute}분 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24)}">
                                <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                ${hour}시간 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*7)}">
                                <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                ${day}일 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*30)}">
                                <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                ${week}주 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*365)}">
                                <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                ${month}달 전
                            </c:when>
                            <c:otherwise>
                                <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                ${year}년 전
                            </c:otherwise>
                        </c:choose>
                    
                        <c:choose>
                            <c:when test="${b.replyDate ne null}">
                                댓글
                            </c:when>
                            <c:otherwise>
                                새글
                            </c:otherwise>
                        </c:choose>
                    </td>    
                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; ${b.reply}</td>
                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24" fill="#626262"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/></svg>${b.like}</td>
                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>&nbsp; ${b.star}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${fn:length(blogSearchResult) gt 10}">
            <a class="button primary" href="${contextPath}/searchdetail/?${searchType}=${searchItem}&aType=2">검색결과 자세히</a>
        </c:if>
        <script>
            const board = document.querySelector('.table-wrapper')
            board.onclick = function(e) {
                if(e.target.parentElement.parentElement.parentElement.id === 'board') {
                    if(e.target.className === "profile-small") {
                        location.href = "${contextPath}/board/" + e.target.parentElement.parentElement.getAttribute('value');
                    } else {
                        location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
                    }
                } else if(e.target.parentElement.parentElement.parentElement.id === 'blog') {
                    if(e.target.className === "profile-small") {
                        location.href = "${contextPath}/blog/" + e.target.parentElement.parentElement.getAttribute('value');
                    } else {
                        location.href = "${contextPath}/blog/" + e.target.parentElement.getAttribute('value');
                    }
                }
            }
        </script>
</section>