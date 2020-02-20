<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<script>
    let title_el = document.querySelector("title");
    let title_header = document.querySelector("#header strong");
    
    if(title_el && title_header)
        title_el.innerHTML = "CODEHAPPY - Main";
        title_header.innerHTML = "CODEHAPPY Main💡🐷";
</script>
<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>게시판 HOT TOPIC 🔥</h2>
                </header>
                <div class="table-wrapper">
                    <table class="board-wrapper">
                        <thead>
                            <tr>
                                <th>제목</th>
                                <th>댓글</th>
                                <th>좋아요</th>
                                <th>최근활동</th>
                                <th>게시일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <div hidden id="spinner"></div>
                            <script src="${contextPath}/resources/js/fetch.js"></script>
                            <script>
                                const spinner = document.getElementById("spinner");
                                const list = document.querySelector(".board-wrapper tbody");
                                spinner.removeAttribute('hidden');
                                fetch("${contextPath}/board/fetch/?atype=1&limit=5")
                                    .then((res) => {
                                        if(res.ok) {
                                            return res.json();
                                        } else {
                                            console.log(res.status);
                                        }
                                    })
                                    .then((articles) => {
                                            articles.map((article) => {
                                                const changeDate = prettyDate(article.changeDate);
                                                const writeDate = prettyDate(article.writeDate);
                                                let tagList = "";
                                                const tagsForEach = article.aTag.slice(0, -1).split(',').forEach(tag => {
                                                    tagList += `<a href="${contextPath}/search?aTag=\${tag}" class="button small">\${tag}</a> &nbsp;`;
                                                });
                                                spinner.setAttribute('hidden', '');
                                                const output = `
                                                <tr class="board-list" value="\${article.aNo}">
                                                    <td><input type="hidden" name="aNo" value="\${article.aNo}">\${article.bHeader}<br>
                                                    \${tagList}</td>
                                                    <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg>&nbsp; \${article.reply}</td>
                                                    <td>♥ \${article.like}</td>
                                                    <td> \${changeDate} </td>
                                                    <td> \${writeDate}</td>
                                                    </tr>
                                                    `;
                                                list.innerHTML += output;
                                        });
                                    })
                                    .catch(e => console.log(e));

                               
                                const board = document.querySelector('.board-wrapper')
                                board.onclick = function(e) {
                                    if(e.target.tagName !== 'TH') {
                                        console.log(e.target.parentElement.getAttribute('value'));
                                        location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
                                    }
                                }
                            </script>
                        </tbody>
                    </table>
                    <ul class="actions">
                        <li><a href="board" class="button primary">전체 글 보기</a></li>
                    </ul>
                </div>
            </section>
            <!-- 블로그 메인 -->
            <c:import url="./blog/blogmain.jsp"/>