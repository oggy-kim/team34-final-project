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
            title_el.innerHTML = "CODEHAPPY - Board";
            title_header.innerHTML = "CODEHAPPY 게시판입니다.";
        </script>
<section>
    <header class="major">
        <h2>게시판 - ${bName}</h2>
    </header>
    <div class="col-6 col-12-small">
        <ul class="actions stacked">
            <li><a href="${contextPath}/board/post" class="button primary">글쓰기</a> &nbsp; <strong>${countList}개</strong>의 글이 있습니다.</li>
            <c:if test="${loginMember eq null}">
                <script>
                    const needLogin = document.querySelector('.button.primary');
                    needLogin.addEventListener('click', function(e) {
                        e.preventDefault();
                        if(confirm("글쓰기는 로그인한 회원만 가능합니다. 로그인하시겠습니까?")) {
                            location.href="${contextPath}/login";
                        };
                    }, false);
                </script>
            </c:if>
        </ul>
    </div>
    <div class="table-wrapper">
        <table class="board-wrapper">
            <!-- <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead> -->
            <tbody>
                <c:if test="${fn:length(list) eq 0}">해당 주제의 게시글이 없습니다.</c:if>
                <c:set var="offset" value="1"/>
                <c:forEach var="b" items="${list}" begin="${(pageInfo - 1) * boardLimit}" end="${pageInfo * boardLimit}">
                <tr class="board-list" value="${b.aNo}">
                    <td>
                        <img class="profile-small" src="${contextPath}/resources/images/member/${b.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'">
                    <td><input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader}<br>
                        <c:set var="aTag" value="${b.aTag}"/>
                        <c:forEach var="t" items="${fn:split(aTag, ',')}">
                            <a href="/?tag=${t}" class="button small">${t}</a>
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
                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>&nbsp; ${b.star}</td>
                </tr>
                </c:forEach>
            </tbody>
            <c:set var="offset" value="${offset + 1}"/>
        </table>
        <div class="col-6 col-12-small">
        <ul class="actions stacked">
            <c:if test="${boardLimit < countList}">
                <li><a onclick="javascript:seeMore('${type}', 15);" class="button primary fit">더 보기</a></li>
            </c:if>
            <script src="resources/js/fetch.js"></script>
            <script>
                function prettyDate(time){
                    var date = new Date((time || "").replace(/-/g,"/").replace(/[TZ]/g," ").split(".")[0]),
                    diff = (((new Date()).getTime() - date.getTime()) / 1000);
                    diff = diff - 33000;
                    if(diff < 0) diff = 0;
                    day_diff = Math.floor(diff / 86400);
                    if ( isNaN(day_diff) || day_diff < 0 )
                    return;

                    return day_diff == 0 && (
                    diff < 60 && "방금 전" ||
                    diff < 120 && "1분 전" ||
                    diff < 3600 && Math.floor( diff / 60 ) + "분 전" ||
                    // diff < 7200 && "1 시간 전" ||
                    diff < 86400 && Math.floor( diff / 3600 ) + "시간 전") ||
                    // day_diff == 1 && "어제" ||
                    day_diff < 7 && day_diff + " 일전" ||
                    day_diff < 31 && Math.floor( day_diff / 7 ) + "주 전" ||
                    day_diff < 360 && Math.floor( day_diff / 30 ) + "개월 전" ||
                    day_diff >= 360 && (Math.floor( day_diff / 360 )==0?1:Math.floor( day_diff / 360 )) + "년 전"
                }

                let pageInfo = 1;
                
                const list = document.querySelector(".board-wrapper tbody");
                function seeMore(boardType, limit) {
                    console.log("boardType : " + boardType);
                    console.log("limit : " + limit);
                    console.log("info : " + pageInfo);
                    fetch('${contextPath}/board/fetch/?type=' + boardType + '&page=' + pageInfo + '&limit=' + limit)
                    .then((res) => {
                        if(res.status == 200 || res.status == 201) {
                            console.log(res.status);
                            console.log(res);
                            console.log("통신성공");
                            return res.json();
                        } else {
                            console.log(res.status);
                        }
                    }).then((articles) => {
                            console.log(articles);
                            articles.map((article) => {
                                const changeDate = prettyDate(article.changeDate);
                                let tagList = "";
                                const tagsForEach = article.aTag.split(',').forEach(tag => {
                                    tagList += `<a href="/?tag=\${tag}" class="button small">\${tag}</a> &nbsp;`;
                                });
                                const dateType = article.replyDate === undefined ? "새글" : "댓글";
                                const output = `
                                <tr class="board-list" value="\${article.aNo}">
                                    <td>
                                    <img class="profile-small" src="${contextPath}/resources/images/member/\${article.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"></td>
                                    <td><input type="hidden" name="aNo" value="\${article.aNo}">\${article.bHeader}<br>
                                    \${tagList}</td>
                                    <td> \${changeDate} \${dateType}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; \${article.reply}</td>
                                    <td> \${article.star}</td>
                                    </tr>
                                    `;
                                list.innerHTML += output;
                        });
                        pageInfo++;
                        if(pageInfo * limit >= ${countList}) {
                        const seeMoreBtn = document.querySelector('.button.primary.fit');
                        seeMoreBtn.parentNode.removeChild(seeMoreBtn);
                    };
                    })
                    .catch((e) => console.log(e));
                }
            </script>
            
        </ul>
        </div>
    </div>
    <script>
        const board = document.querySelector('.board-wrapper')
        board.onclick = function(e) {
            // location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
            if(e.target.className === "profile-small") {
                location.href = "${contextPath}/board/" + e.target.parentElement.parentElement.getAttribute('value');
            } else {
                location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
            }
        }
    </script> 
</section>