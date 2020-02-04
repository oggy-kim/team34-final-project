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
        title_el.innerHTML = "CODEHAPPY - Blog";
        title_header.innerHTML = "CODEHAPPY 블로그";
</script>
<section>
    <header class="major">
        <h2>블로그 - ${bName}</h2>
    </header>
    <div class="col-6 col-12-small">
        <ul class="actions stacked">
            <li><a href="${contextPath}/blog/post" class="button primary">글쓰기</a> &nbsp; <strong>${countList}개</strong>의 글이 있습니다.</li>
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
            <tbody>
                <c:if test="${fn:length(list) eq 0}">해당 주제의 게시글이 없습니다.</c:if>
                <c:set var="offset" value="1"/>
                <c:forEach var="b" items="${list}" begin="${(pageInfo - 1) * boardLimit}" end="${pageInfo * boardLimit}">
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
            <script src="${contextPath}/resources/js/fetch.js"></script>
            <script>
                let pageInfo = 1;
                
                const list = document.querySelector(".board-wrapper tbody");
                function seeMore(boardType, limit) {
                    fetch('${contextPath}/blog/fetch/?type=' + boardType + '&page=' + pageInfo + '&limit=' + limit)
                    .then((res) => {
                        if(res.ok) {
                            return res.json();
                        } else {
                            console.log(res.status);
                        }
                    }).then((blogs) => {
                            blogs.map((blog) => {
                                const changeDate = prettyDate(blog.changeDate);
                                let tagList = "";
                                const tagsForEach = blog.aTag.slice(0, -1).split(',').forEach(tag => {
                                    tagList += `<a href="${contextPath}/search/?aTag=\${tag}" class="button small">\${tag}</a> &nbsp;`;
                                });
                                const dateType = blog.replyDate === undefined ? "새글" : "댓글";
                                const output = `
                                <tr class="board-list" value="\${blog.aNo}">
                                    <td>
                                    <img class="profile-small" src="${contextPath}/resources/images/member/\${blog.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"></td>
                                    <td><input type="hidden" name="aNo" value="\${blog.aNo}">\${blog.bHeader}<br>
                                    \${tagList}</td>
                                    <td> \${changeDate} \${dateType}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; \${blog.reply}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>&nbsp; \${blog.star}</td>
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
            if(e.target.className === "profile-small") {
                location.href = "${contextPath}/board/" + e.target.parentElement.parentElement.getAttribute('value');
            } else {
                location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
            }
        }
    </script> 
</section>