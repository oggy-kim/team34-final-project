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
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>  ${board.reply} &nbsp;&nbsp;&nbsp; 
            <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>  ${board.star}</p>
    </header>
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
        <div class="article-like-toggle" style="text-align:center"><a onclick="javascript:document.article_info.submit()">
            <svg xmlns="http://www.w3.org/2000/svg" width="2em" height="2em" viewBox="0 0 20 20" fill="#fc2605"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/>
            </svg> <strong>${board.like} </strong> </a>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
            <c:choose>
                <c:when test="${star eq 0}">
                    <a title="나의 찜목록에 추가" class="add-star" onclick="javascript:document.article_star.submit()"><svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#dddddd"/></svg></a>
                </c:when>
                <c:otherwise>
                    <a title="나의 찜목록에서 제거" class="add-star"  onclick="javascript:document.article_star.submit()"><svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#fc2605"/></svg></a>
                </c:otherwise>
            </c:choose>
            <form name="article_info" action="${contextPath}/board/${board.aNo}/like" method="POST">
                <input type="hidden" name="aNo" value="${board.aNo}" />
                <input type="hidden" name="mNo" value="${board.mNo}" />
                <input type="hidden" name="star" value="${star}" />
            </form>
            <form name="article_star" action="${contextPath}/board/${board.aNo}/star" method="POST">
                <input type="hidden" name="star" value="${star}" />
            </form>
        </div>
    <hr class="major" />


    <c:set var="offset" value="5"/>
    <c:set var="page" value="1"/>  
    <!-- Reply Part -->
    <h3>${board.reply}개의 댓글이 있습니다.</h3>
                <c:choose>
                    <c:when test="${fn:length(reply) eq 0}">
                        <div class="reply-area">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="reply-area">
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
                                <div class="reply-content-${r.rNo}">
                                    <c:out value="${r.rContent}" escapeXml="false" />
                                    <form name="reply-info-${r.rNo}" action="${contextPath}/board/${board.aNo}/like" method="POST">
                                        <input type="hidden" name="rNo" value="${r.rNo}">
                                    </form>
                                    <a onclick="javascript:document.reply-info-${r.rNo}.submit()">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="2em" height="2em" viewBox="0 0 20 20" fill="#fc2605"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/>
                                        </svg> <strong>${r.like} </strong> </a> &nbsp; &nbsp;
                                    <a title="댓글 달기" onclick="javascript:openRereplyForm(${r.rNo}, ${r.aNo});"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="2em" height="2em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600">
                                        <path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg></a>
                                        <form name="reReplyBox" action="post/${aNo}/comment" method="POST" style="display: none">
                                            <input type="hidden" name="aNo" value="${r.aNo}">
                                            <input type="hidden" name="refRNo" value="${r.rNo}">
                                            <input type="text" name="rContent" style="width: 80%;">
                                            &nbsp; &nbsp;
                                            <button>댓글 달기</button>
                                        </form>
                                        <c:forEach var="rr" items="${reReply}">
                                    <c:if test="${rr.refRNo eq r.rNo}">
                                        <hr class="reply-content">
                                        <div><a href="${contextPath}/mypage/${rr.mNo}">${rr.mNick}님</a> ${rr.rContent} </div>
                                    </c:if> 
                                </c:forEach>
                                </div>
                        </div>
                                
                            </c:forEach>
                            <script>
                                function openRereplyForm(rNo, aNo){
                                    const reReply = document.querySelector('.reply-content-' + rNo + ' form[name=reReplyBox]');
                                    console.log(reReply);
                                    if(reReply.style.display == 'none' || reReply.style.display == '') {
                                        reReply.style.display = 'flex';
                                    } else {
                                        reReply.style.display = 'none';
                                    }
                                }
                            
                            </script>
                        </div>
                        <ul class="actions">
                            <c:if test="${5 < fn:length(reply)}">
                                <li><a onclick="javascript:seeMore();" class="button big">댓글 ${fn:length(reply) - offset * page }개 더 보기</a></li>
                            </c:if>
                        </ul>
                        </c:otherwise>
                    </c:choose>
                    <script>
                        function seeMore() {
                            const replyBox = document.querySelector('.reply-area');
                            console.log(replyBox);
                            let page = 1;
                            const offset = 5;
                            replyBox.innerHTML += `
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
                                <div class="reply-content-${r.rNo}">
                                    <c:out value="${r.rContent}" escapeXml="false" />
                                    <form name="reply-info-${r.rNo}" action="${contextPath}/board/${board.aNo}/like" method="POST">
                                        <input type="hidden" name="rNo" value="${r.rNo}">
                                    </form>
                                    <a onclick="javascript:document.reply-info-${r.rNo}.submit()">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="2em" height="2em" viewBox="0 0 20 20" fill="#fc2605"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/>
                                        </svg> <strong>${r.like} </strong> </a> &nbsp; &nbsp;
                                    <a title="댓글 달기" onclick="javascript:openRereplyForm(${r.rNo}, ${r.aNo});"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="2em" height="2em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600">
                                        <path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg></a>
                                        <form name="reReplyBox" action="post/${aNo}/comment" method="POST" style="display: none">
                                            <input type="hidden" name="aNo" value="${r.aNo}">
                                            <input type="hidden" name="refRNo" value="${r.rNo}">
                                            <input type="text" name="rContent" style="width: 80%;">
                                            &nbsp; &nbsp;
                                            <button>댓글 달기</button>
                                        </form>
                                        <c:forEach var="rr" items="${reReply}">
                                    <c:if test="${rr.refRNo eq r.rNo}">
                                        <hr class="reply-content">
                                        <div><a href="${contextPath}/mypage/${rr.mNo}">${rr.mNick}님</a> ${rr.rContent} </div>
                                    </c:if> 
                                </c:forEach>
                                </div>
                            </div>
                            </c:forEach>
                            `;
                        }
                    </script>
                    
            <!-- Reply Insert -->
                <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
                <form method="POST" action="post/${aNo}/comment" >
                    <div class="box writeReply">
                        <img src="${contextPath}/resources/images/member/${loginMember.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"class="profile-small">
                        <input type="submit" value="댓글 달기" vertical-align="middle">
                        <br>
                        <textarea name="editor" id="editor" rows="5" cols="50" placeholder="코드해피를 위해 도움이 되는 글을 올려주세요. <p> 규칙에 위배되는 글 작성시 삭제 처리됩니다.">
                        </textarea>
                        <script>
                            CKEDITOR.replace( 'editor', {
                                height: '150px',
                                extraPlugins : 'confighelper'
                            } );
                        </script>
                    </div>
                </form>
                
            
                <!-- 게스트 댓글작성 기능 비활성화 -->
                <c:if test="${loginMember eq null}">
                    <script>
                        const writeReply = document.querySelector('.writeReply');
                        writeReply.style = "filter:blur(4px);pointer-events:none";
                    </script>
                    <h5 align="center">로그인 후 댓글 작성이 가능합니다.</h5>
                </c:if>

</section>