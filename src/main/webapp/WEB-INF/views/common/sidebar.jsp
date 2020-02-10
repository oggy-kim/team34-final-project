<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<!-- Sidebar -->
<div id="sidebar">
    <div class="inner">
        <!-- Search -->
            <section id="search" class="alt">
                <form method="GET" action="${contextPath}/search/">
                    <input type="text" name="q" id="query" placeholder="Search" />
                </form>
            </section>

        <!-- Menu -->
            <nav id="menu">
                <header class="major">
                    <a href="${contextPath}"><img src="${contextPath}/resources/images/common/sitelogo.png" width="80%"></a>
                </header>
                <ul>
                    <li>
                        <span class="opener">게시판</span>
                        <ul>
                            <li><a href="${contextPath}/board">글 모아보기</a></li>
                            <li><a href="${contextPath}/board/?type=frontend">프론트엔드</a></li>
                            <li><a href="${contextPath}/board/?type=backend">백엔드</a></li>
                            <li><a href="${contextPath}/board/?type=others">그외 프로그래밍</a></li>
                            <li><a href="${contextPath}/board/?type=freetalk">프리톡</a></li>
                        </ul>
                    </li>
                    <li>
                        <span class="opener">블로그</span>
                        <ul>
                            <li><a href="${contextPath}/blog/main">블로그 메인</a></li>
                            <li><a href="${contextPath}/blog/?type=all">블로그 모아보기</a></li>
                            <li><a href="${contextPath}/blog/?type=frontend">프론트엔드</a></li>
                            <li><a href="${contextPath}/blog/?type=backend">백엔드</a></li>
                            <li><a href="${contextPath}/blog/?type=others">그외 프로그래밍</a></li>
                            <li><a href="${contextPath}/blog/?type=freetalk">프리톡</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>

        <!-- Section -->
            <section>
                <header class="major">
                    <a href="${contextPath}/mypage/${loginMember.mNo}"><h2><img src="${contextPath}/resources/images/member/${loginMember.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" class="profile-xsmall"> About Me &#x1F913;</h2></a>
                </header>
                <div class="mini-posts">
                    <article>
                        <p>
                            가입한지
                            <fmt:parseNumber value="${loginMember.joinDate.time}" integerOnly="true" var="joinDate"/>
                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                            <c:set var="totalDate" value="${nowDate / 1000 - joinDate / 1000}"/>
                            <fmt:parseNumber var="dayday" integerOnly="true" value="${totalDate / (60*60*24) + 1 }"/>
                            ${dayday}일째, <br> {코딩포인트} : <strong>${loginMember.mPoint} 점</strong> (상위 ${loginMember.pointRanking} %)</p>
                    </article>
                    <article>
                        <p>내 게시글에 대한 댓글이 
                            <c:choose>
                                <c:when test="${loginMember.recentReply eq null}">
                                    없습니다.
                                </c:when>
                                <c:otherwise>

                               
                            <fmt:parseNumber value="${loginMember.recentReply.time}" integerOnly="true" var="recentReply"/>
                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                            <c:set var="diff" value="${nowDate / 1000 - recentReply / 1000}"/>
                            <c:choose>
                                <c:when test="${diff lt 120}">
                                     방금 전 달렸습니다.
                                </c:when>
                                <c:when test="${diff lt (60*60)}">
                                    <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                     ${minute} 분 전에 있습니다.
                                </c:when>
                                <c:when test="${diff lt (60*60*24)}">
                                    <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                     ${hour} 시간 전에 있습니다.
                                </c:when>
                                <c:when test="${diff lt (60*60*24*30)}">
                                    <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                     ${day} 일 전에 있습니다.
                                </c:when>
                                <c:when test="${diff lt (60*60*24*365)}">
                                    <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                    ${month} 달 전에 있습니다.
                                </c:when>
                                <c:otherwise>
                                    <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                    ${year} 년 전에 있습니다.
                                </c:otherwise>
                            </c:choose>
                            </c:otherwise>
                        </c:choose>
                        </p>
                    </article>
                </div>
                <c:if test="${loginMember eq null}">
                    <script>
                        const aboutMeDiv = document.querySelector('.mini-posts');
                        aboutMeDiv.style = "filter:blur(3px);pointer-events:none";
                    </script>
                    <h5 align="center">로그인이 필요합니다.</h5>
                </c:if>
            </section>

        <!-- Section -->
            <section>
                <header class="major">
                    <h2>&#x260E; &nbsp;About Codehappy</h2>
                </header>
                <p>개발자 양성과정 Final Project 관련 개발 커뮤니티입니다. 상세 문의사항 및 에러사항은 아래 연락처로 문의 바랍니다.</p>
                <ul class="contact">
                    <li class="icon solid fa-envelope">김옥철 : <a href="mailto:oksamha@gmail.com">oksamha@gmail.com</a></li>
                    <li class="icon solid fa-envelope">윤희석 : <a href="mailto:heesuk1181@naver.com">heesuk1181@naver.com</a></li>
                    <li class="icon solid fa-home">Github Link : 
                        <a href="https://github.com/oggy-kim/team34-final-project"><img src="${contextPath}/resources/images/common/github.png" width="20px"></a>
                    </li>
                    <!-- <c:if test="${loginMember.levelName eq '주관리자'}">
                        <li><a href="${contextPath}/admin">🔑</a></li>
                    </c:if> -->
                </ul>
            </section>

        <!-- Footer -->
            <footer id="footer">
                <p class="copyright">&copy; http://Codehappy.site . All rights reserved. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
                본 사이트는 IE 외의 모든 브라우저를 지원합니다.
                <br>
                Internet Explorer로 접속하신 경우 홈페이지의 기능을 활용하실 수 없습니다. Chrome, Safari, Firefox, Edge 등 브라우저로 접속해주세요.
            </footer>
    </div>
</div>