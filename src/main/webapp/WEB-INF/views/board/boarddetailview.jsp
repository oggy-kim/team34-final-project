<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />

<script>
let title_el = document.querySelector("title");
let title_header = document.querySelector("#header strong");

if(title_el && title_header)
    title_el.innerHTML = "CODEHAPPY - ${board.bHeader}";
    title_header.innerHTML = "${board.bHeader}";
</script>

<section>
    <header class="main">
        <fmt:formatDate var="writeDateDetail" value="${board.writeDate}" pattern="yyyy-MM-dd HH:mm"/>
        <p>등록 : ${writeDateDetail}(     
                        
                        <fmt:parseNumber value="${board.writeDate.time}" integerOnly="true" var="writeDate"/>
                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                        <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                        <c:choose>
                            <c:when test="${diff lt 120}">
                                방금 전
                            </c:when>
                            <c:when test="${diff lt (60*60)}">
                                <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                ${minute} 분 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24)}">
                                <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                ${hour} 시간 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*30)}">
                                <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                ${day} 일 전
                            </c:when>
                            <c:when test="${diff lt (60*60*24*365)}">
                                <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                ${month} 달 전
                            </c:when>
                            <c:otherwise>
                                <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                ${year} 년 전
                            </c:otherwise>
                        </c:choose>) &nbsp;&nbsp;&nbsp; 
            조회수 : ${board.view} &nbsp;&nbsp;&nbsp; 
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> : ${board.reply} &nbsp;&nbsp;&nbsp; 
            <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg> : ${board.star}</p>
    </header>
    <!-- 크기조정 필요 -->
    <table class="profile-info">
        <tr>
            <td><img src="${contextPath}/resources/images/member/${board.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"class="profile-small"></td>
            <td><p>${board.mNick} 님</p>
                <p>포인트 : ${board.mPoint}점</p>
            </td>
            <td>${board.aboutMe}</td>
            </tr>
    </table>

    <!-- Question Contents -->
    <div class="box">
        ${board.bContent}
        
    </div>
        <div style="text-align:center">좋은 글인가요? &nbsp; <a onclick="javascript:document.article_like.submit()" class="button">♡ ${board.like}</a>
            <c:if test="${loginMember ne null}">
                &nbsp; 보관함 담기 &nbsp;
                <a href="#" class="button">⭐️</a></div>
            </c:if>
            <form name="article_like" action="${contextPath}/board/${board.aNo}/like" method="POST">
            <input type="hidden" name="aNo" value="${board.aNo}" />
            <input type="hidden" name="mNo" value="${board.mNo}" />
            </form>
    <hr class="major" />
      
    <!-- Reply Part -->
    <h3>${fn:length(reply)}개의 댓글이 있습니다.</h3>
                <c:choose>
                    <c:when test="${fn:length(reply) eq 0}">
                        <div class="reply-area">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="reply-area">
                        <c:set var="offset" value="5"/>
                        <c:set var="page" value="1"/>
                        <c:forEach var="r" items="${reply}" begin="${offset * (page - 1)}" end="${offset * page - 1}">
                                <div class="box reply">
                            <div class="reply-profile">
                            <table class="reply-profile">
                                <tr>
                                    <td><img src="${contextPath}/resources/images/member/${r.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" class="profile-small"></td>
                                    <td><p>${r.mNick} 님</p>
                                        <p><fmt:parseNumber value="${r.writeDate.time}" integerOnly="true" var="writeDate"/>
                                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                            <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                            <c:choose>
                                                <c:when test="${diff lt 120}">
                                                    방금 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60)}">
                                                    <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                                    ${minute} 분 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24)}">
                                                    <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                                    ${hour} 시간 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24*30)}">
                                                    <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                                    ${day} 일 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24*365)}">
                                                    <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                                    ${month} 달 전
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                                    ${year} 년 전
                                                </c:otherwise>
                                            </c:choose></p>
                                </tr>
                                <tr>
                                    <td colspan="2"><br>${r.aboutMe}</td>
                                </tr>
                                </table>
                            </div>
                                <div class="reply-content">
                                    <c:out value="${r.rContent}" escapeXml="false" />
                                    <a href="#" class="button small">♡ ${r.like}</a>
                                </div>
                                </div>
                            </c:forEach>
                        </div>
                        <ul class="actions">
                            <c:if test="${5 < fn:length(reply)}">
                                <li><a onclick="javascript:seeMore();" class="button big">댓글 ${fn:length(reply) - offset * page }개 더 보기</a></li>
                            </c:if>
                        </ul>
                        </c:otherwise>
                    </c:choose>

                    
            <!-- Reply Insert -->
                <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
                <form method="POST" action="post/${aNo}/comment">
                    <div class="box writeReply">
                        <img src="${contextPath}/resources/images/member/${loginMember.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"class="profile-small">
                        <input type="submit" value="댓글 달기" vertical-align="middle">
                        <br>
                        <textarea name="editor" id="editor" rows="5" cols="50">
                        </textarea>
                        <script>
                            CKEDITOR.replace( 'editor' );
                        </script>
                </form>
            </div>
                <!-- 게스트 댓글작성 기능 비활성화 -->
                <c:if test="${loginMember eq null}">
                    <script>
                        const writeReply = document.querySelector('.writeReply');
                        writeReply.style = "filter:blur(4px);pointer-events:none";
                    </script>
                    <h5 align="center">로그인 후 댓글 작성이 가능합니다.</h5>
                </c:if>

</section>