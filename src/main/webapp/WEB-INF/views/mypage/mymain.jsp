<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />

<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>My Profile</h2>
                </header>
                <!-- 프로필, 이름, 설정-->
                <div class="row">
                    <div class="filebox">
                        <div class="col-6 col-12-small">
                            <img src="${contextPath}/resources/images/member/${r.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" class="profile-big">
                            <input type="file" id="upload_file" name="upload_file">
                            <label for="upload_file" class="button small">사진업로드</label>
                        </div>
                    </div>
                    	<!-- <h4 id="float-xs-right"><a href="#">설정</a></h4> -->
                    <div class="nicknamefont">
                        <div class="col-4 col-12-small">
                            <h1>${loginMember.mNick}</h1>
                            <h4>${loginMember.aboutMe}</h4>
                            <a class="button small" href="#aboutMe">자기소개 수정</a>
                        </div>
                        <br>
                        <div class="col-4 col-12-small">
                            <a class="button small" onclick="updatePwd();">비밀번호 변경</a>
                        </div>
                        <br>
                        <div class="col-4 col-12-small">
                            <a class="button small" onclick="deleteMember(${loginMember.mNo});">**회원 탈퇴**</a>
                        </div>
                    </div>
                        <div class="col-6 col-12-small">
                            <a class="button small" href="#modifynick">닉네임 수정</a>
                        </div>
                </div>

                <script>
                    function deleteMember(mNo) {
                        if(confirm('삭제하시겠습니까?')) {
                            location.href="${contextPath}/member/" + mNo;
                        }
                    }

                </script>
                
                <br>

                <div class="row myactivity">
                    <div class="col-4 col-12-medium mypoint">
                        <h4>My 게시글 더 보기</h4>
                        <tbody>
                            <c:if test="${fn:length(bList) eq 0}">작성한 게시글이 없습니다.</c:if>
                            <c:set var="offset" value="1"/>
                            <c:forEach var="b" items="${bList}" begin="0" end="4">
                            <tr class="board-list" value="${b.aNo}">
                                <td>
                                    <input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader} + ${b.replyDate}<br>
                                </td>
                                <td>
                                    <fmt:parseNumber value="${b.writeDate.time}" integerOnly="true" var="writeDate"/>
                                    <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                    <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
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
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </div>
                    <div class="col-4 col-12-medium myactivity">
                        <h4>My 댓글 활동</h4>
                         <tbody>
                             <c:if test="${fn:length(rList) eq 0}">작성한 댓글 내용이 없습니다.</c:if>
                             <c:set var="offset" value="1"/>
                             <c:forEach var="r" items="${rList}" begin="0" end="4">
                                <tr class="reply-list" value="${r.rNo}">
                                    <td>
                                        <input type="hidden" name="rNo" value="${r.rNo}">${r.rContent}<br>
                                    </td>
                                    <td>
                                        <fmt:parseNumber value="${r.writeDate.time}" integerOnly="true" var="writeDate"/>
                                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                        <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
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
                                    </td>
                                </tr>
                             </c:forEach>
                         </tbody>
                    </div>
                    <div class="col-3 col-12-medium myactivity">
                        <h4>My 찜 목록</h4>
                        <tbody>
                            <c:if test="${fn:length(bList) eq 0}">찜한 게시글이 없습니다.</c:if>
                            <c:set var="offset" value="1"/>
                            <c:forEach var="b" items="${bList}" begin="0" end="4">
                                <tr class="board-list" value="${b.aNo}">
                                    <td>
                                        <input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader} + ${b.star}<br>
                                    </td>
                                    <td>
                                        <fmt:parseNumber value="${b.writeDate.time}" integerOnly="true" var="writeDate"/>
                                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                        <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
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
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </div>
                </div>
                <br>
                    <!-- 비밀번호 재설정 윈도우 창 띄우기!! -->
                    <script>
                        function updatePwd(){
                            window.open('updatePwd','비밀번호 재설정','width=550, height=400, left=300, top=150');
                            
                        }
                    </script>

            </section>
            


