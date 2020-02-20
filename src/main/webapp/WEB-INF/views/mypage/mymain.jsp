<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:useBean id="now" class="java.util.Date" />

<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>My Profile</h2>
                </header>
                <!-- 프로필, 이름, 설정-->
                <div class="row">
                    <label class="label" data-toggle="tooltip" title="프로필사진 변경">
                        <img class="profile-big" id="avatar" src="${contextPath}/resources/images/member/${myPageInfo.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" alt="avatar">
                        <c:if test="${myPageInfo.mNo eq loginMember.mNo}">
                        <input type="file" class="sr-only" id="input" name="image" accept="image/*">
                        </c:if>
                    </label>
                    <c:if test="${myPageInfo.mNo eq loginMember.mNo}">
                    <div class="alert" role="alert"></div>
                    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="modalLabel">이미지 사이즈를 조정해주세요.</h3>
                        </div>
                        <div class="modal-body">
                            <div class="img-container">
                            <img id="image" src="https://avatars0.githubusercontent.com/u/3456749">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="button secondary" data-dismiss="modal">취소</button>
                            <button type="button" class="button primary" id="crop">등록</button>
                        </div>
                        </div>
                    </div>
                    </div>
                    <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                    <script type="text/javascript" src="${contextPath}/resources/js/cropper.js"></script>

                    </c:if>
                    <div class="nicknamefont">
                        <div class="col-6 col-12-small">
                            <h1>${myPageInfo.mNick}</h1> 
                            <h4>${myPageInfo.aboutMe}</h4>
                            가입한지
                            <fmt:parseNumber value="${myPageInfo.joinDate.time}" integerOnly="true" var="joinDate"/>
                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                            <c:set var="totalDate" value="${nowDate / 1000 - joinDate / 1000}"/>
                            <fmt:parseNumber var="dayday" integerOnly="true" value="${totalDate / (60*60*24) + 1 }"/>
                            ${dayday}일째, {코딩포인트} : <strong>${myPageInfo.mPoint} 점</strong> (상위 ${myPageInfo.pointRanking} %)
                            <br>
                            <c:if test="${myPageInfo.mNo eq loginMember.mNo}">
                            <a class="button small" href="#modifynick">닉네임 수정</a> <a class="button small" href="#aboutMe">자기소개 수정</a>
                            </c:if>
                        </div>
                    </div>

                </div>                
                <br>
                <header class="major">
                    <h3>${myPageInfo.mNick} 님의 활동내역</h3>
                </header>
                <div class="row myactivity">
                    <div class="col-4 col-12-medium mylist">
                        <h4>게시글(총 ${fn:length(bList)}개)</h4>
                        <div class="table-wrapper">
                            <table>
                            <thead>
                                <tr>
                                    <th style="width:50%;">제목</th>
                                    <th>작성</th>
                                    <th>댓글</th>
                                    <th>조회</th>
                                </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${bList}" begin="0" end="4">
                            <tr class="board-list" value="${b.aNo}">
                                <td>
                                    <input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader} 
                                </td>
                                <td>
                                    <fmt:parseNumber value="${b.writeDate.time}" integerOnly="true" var="writeDate"/>
                                    <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                    <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                    <c:choose>
                                        <c:when test="${diff lt 120}">방금 전
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
                                <c:choose>
                                    <c:when test="${b.replyDate ne null}">
                                        <td>
                                            <fmt:parseNumber value="${b.replyDate.time}" integerOnly="true" var="writeDate"/>
                                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                            <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                            <c:choose>
                                                <c:when test="${diff lt 120}">방금 전
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
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            -
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                                <td>
                                    ${b.view}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        </table>
                        </div>
                        <!-- <a class="button small" href="${contextPath}/myarticle/${myPageInfo.mNo}">더보기</a> -->
                    </div>

                    <!-- 로그인한 사용자 당사자만 자신의 찜글 볼 수 있도록 -->
                    <c:if test="${myPageInfo.mNo eq loginMember.mNo}">
                    <div class="col-3 col-12-medium mylist">
                        <h4>찜목록(총 ${fn:length(sList)}개)</h4>
                        <div class="table-wrapper">
                        <table>
                        <thead>
                            <tr>
                                <th style="width:70%;">제목</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                                <c:set var="offset" value="1"/>
                                <c:forEach var="s" items="${sList}" begin="0" end="4">
                                    <tr class="board-list" value="${s.aNo}">
                                        <td>
                                            <input type="hidden" name="aNo" value="${s.aNo}">${s.bHeader}
                                        </td>
                                        <td>
                                            <fmt:parseNumber value="${s.writeDate.time}" integerOnly="true" var="writeDate"/>
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
                        </table>
                    </div>
                    <!-- <a class="button small" href="${contextPath}/starredArticle/${loginMember.mNo}" >내 찜리스트 모두보기</a> -->
                </div>
            </c:if>
            <div class="col-4 col-12-medium mylist">
                <h4>댓글(총 ${fn:length(rList)}개)</h4>
                    <div class="table-wrapper">
                        <table>
                        <thead>
                            <tr>
                                <th style="width:60%;">제목</th>
                                <th>작성일</th>
                                <th>좋아요</th>
                            </tr>
                        </thead>
                         <tbody>
                             <c:set var="offset" value="1"/>
                             <c:forEach var="r" items="${rList}" begin="0" end="4">
                                <tr class="reply-list" value="${r.aNo}">
                                    <td>
                                        <input type="hidden" name="rNo" value="${r.aNo}">${r.rContent} 
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
                                    <td>
                                        ${r.like}
                                    </td>
                                </tr>
                             </c:forEach>
                         </tbody>
                        </table>
                    </div>
                    </div>
                </div>
                <br>
                <c:if test="${myPageInfo.mNo eq loginMember.mNo}">
                <header class="major">
                    <h3>개인정보 수정</h3>
                </header>
                    <a class="button small" onclick="updatePwd();">비밀번호 변경</a>
                    <a class="button primary small" onclick="deleteMember(${loginMember.mNo});">**회원 탈퇴**</a>
                </c:if>
            <script>
                function deleteMember(mNo) {
                    if(confirm('한번 탈퇴하시면 재가입을 위해 관리자에게 별도로 연락주셔야 합니다. 그래도 탈퇴하시겠습니까?')) {
                        location.href="${contextPath}/member/" + mNo;
                    }
                }
                function updatePwd(){
                    window.open('updatePwd','비밀번호 재설정','width=550, height=400, left=300, top=150');
                    
                }

                const myactivity = document.querySelector('.myactivity');
                myactivity.addEventListener('click', (e) => {
                    if(e.target.parentElement.className === 'board-list' || e.target.parentElement.className === 'reply-list') {
                        const aNo = e.target.parentElement.getAttribute('value');
                        location.href="${contextPath}/board/" + aNo;
                    }
                })
            </script>

            </section>
            


