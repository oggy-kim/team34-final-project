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
        <h2>
            <c:choose>
                <c:when test="${aType eq 1}">
                    게시판
                </c:when>
                <c:otherwise>
                    블로그
                </c:otherwise>
            </c:choose>
            상세 검색결과 - ${searchItem}</h2>
    </header>
    <select id="sortOption" name="sortOption" style="width:15%;">
        <option value="recent" selected>최근 활동 순</option>
        <option value="new">새글 등록 순</option>
        <option value="like">좋아요 많은 순</option>
        <option value="star">찜 많은 순</option>
        <option value="reply">댓글 많은 순</option>
    </select>
    <br><br>

    <script>
        const $sortOption = document.querySelector('#sortOption');
        $sortOption.addEventListener('change', (e) => {
            console.log(e.target.value);
            const url = "${contextPath}/searchdetail/fetch/?${searchType}=${searchItem}&aType=${aType}&sort=" + e.target.value;
            fetchResult(url);
        })
    
    </script>
    

    <div class="table-wrapper">
        <table class="board-wrapper">
            <thead>
                <tr>
                    <th></th>
                    <th>제목</th>
                    <th>최근활동</th>
                    <th>댓글</th>
                    <th>좋아요</th>
                    <th>찜</th>
                </tr>
            </thead>
            <tbody>
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
                        day_diff < 7 && day_diff + "일 전" ||
                        day_diff < 31 && Math.floor( day_diff / 7 ) + "주 전" ||
                        day_diff < 360 && Math.floor( day_diff / 30 ) + "개월 전" ||
                        day_diff >= 360 && (Math.floor( day_diff / 360 )==0?1:Math.floor( day_diff / 360 )) + "년 전"
                    }

                    const list = document.querySelector(".board-wrapper tbody");

                    let page = 1;
                    const offset = 15;

                    function fetchResult(url) {
                    return fetch(url)
                    .then(res => {
                        if(res.ok) {
                            console.log("통신성공!");
                            return res.json();
                        } else {
                            console.log(res);
                        }
                    }).then((results) => {
                        list.innerHTML = "";
                        console.log(results);
                        results.map((result) => {
                            const changeDate = prettyDate(result.changeDate);
                                let tagList = "";
                                const tagsForEach = result.aTag.slice(0, -1).split(',').forEach(tag => {
                                    tagList += `<a href="${contextPath}/search/?aTag=\${tag}" class="button small">\${tag}</a> &nbsp;`;
                                });
                                const dateType = result.replyDate === undefined ? "새글" : "댓글";
                                const output = `
                                <tr class="board-list" value="\${result.aNo}">
                                    <td>
                                    <img class="profile-small" src="${contextPath}/resources/images/member/\${result.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'"></td>
                                    <td><input type="hidden" name="aNo" value="\${result.aNo}">\${result.bHeader}<br>
                                    \${tagList}</td>
                                    <td> \${changeDate} \${dateType}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; \${result.reply}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24" fill="#626262"><path d="M13.91,6.75c-1.17,2.25-4.3,5.31-6.07,6.94c-0.1903,0.1718-0.4797,0.1718-0.67,0C5.39,12.06,2.26,9,1.09,6.75  C-1.48,1.8,5-1.5,7.5,3.45C10-1.5,16.48,1.8,13.91,6.75z"/></svg>\${result.like}</td>
                                    <td><svg xmlns="http://www.w3.org/2000/svg" width="1.13em" height="1.13em" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z" fill="#626262"/></svg>&nbsp; \${result.star}</td>
                                    </tr>
                                    `;
                                list.innerHTML += output;
                        })
                    }).catch(e => {
                        console.log(e);
                    })
                    }
                    fetchResult("${contextPath}/searchdetail/fetch/?${searchType}=${searchItem}&aType=${aType}");
                
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
            </tbody>
        </table>
    </div>

</section>