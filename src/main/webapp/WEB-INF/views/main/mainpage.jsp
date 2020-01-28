<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>HOT TOPIC 🔥</h2>
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
                                const spinner = document.getElementById("spinner");
                                const list = document.querySelector(".board-wrapper tbody");
                                spinner.removeAttribute('hidden');
                                fetch("${contextPath}/board/fetch/?limit=5")
                                    .then((res) => {
                                        if(res.status == 200 || res.status == 201) {
                                            console.log(res.status);
                                            console.log(res);
                                            console.log("통신성공");
                                            return res.json();
                                        } else {
                                            console.log(res.status);
                                        }
                                    })
                                    .then((articles) => {
                                            console.log(articles);
                                            articles.map((article) => {
                                                const changeDate = prettyDate(article.changeDate);
                                                const writeDate = prettyDate(article.writeDate);
                                                let tagList = "";
                                                const tagsForEach = article.aTag.split(',').forEach(tag => {
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
                                    console.log(e.target.parentElement.getAttribute('value'));
                                    location.href = "${contextPath}/board/" + e.target.parentElement.getAttribute('value');
                                }
                            </script>




                            <!-- <tr class="board-list main">
                                <td>
                                    자바는 저에게 왜이럴까요?<br />
                                    <a href="#" class="button small">JAVA</a>
                                </td>
                                <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> 15</td>
                                <td>1분 전</td>
                                <td>10일 전</td>
                            </tr>
                            <tr>
                                <td>
                                    MYSQL와 MariaDB의 차이점에 대하여<br />
                                    <a href="#" class="button small">MariaDB</a>
                                    <a href="#" class="button small">MYSQL</a>
                                    <a href="#" class="button small">DB</a>
                                </td>
                                <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> 15</td>
                                <td>1분 전</td>
                                <td>10일 전</td>
                            </tr>                            
                            <tr>
                                <td>
                                    오늘 차였습니다.<br />
                                    <a href="#" class="button small">FREE</a>
                                </td>
                                <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> 15</td>
                                <td>1분 전</td>
                                <td>10일 전</td>
                            </tr>                            
                            <tr>
                                <td>
                                    파이썬은 2.0과 3.0의 차이가 있나요?<br />
                                    <a href="#" class="button small">PYTHON</a>
                                </td>
                                <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> 15</td>
                                <td>1분 전</td>
                                <td>10일 전</td>
                            </tr>                            
                            <tr>
                                <td>
                                    자바스트립트는 저에게 왜이럴까요????????<br />
                                    <a href="#" class="button small">JAVASCRIPT</a>
                                </td>
                                <td><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="1.13em" height="1em" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1792 1600"><path d="M1792 1056q0 166-127 451q-3 7-10.5 24t-13.5 30t-13 22q-12 17-28 17q-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123q0-101-17.5-181t-48.5-138.5t-80-101t-105.5-69.5t-133-42.5t-154-21.5t-175.5-6H640v256q0 26-19 45t-45 19t-45-19L19 621Q0 602 0 576t19-45L531 19q19-19 45-19t45 19t19 45v256h224q713 0 875 403q53 134 53 333z" fill="#626262"/></svg> 15</td>
                                <td>1분 전</td>
                                <td>10일 전</td>
                            </tr> -->
                        </tbody>
                    </table>
                    <ul class="actions">
                        <li><a href="board" class="button big">더 보기</a></li>
                    </ul>
                </div>
            </section>

            <!-- Editor's Pick -->
            <section id="banner">
                <div class="content">
                    <header class="major">
                        <h2>Editor's Pick</h2>
                    </header>
                    <header>
                        <h1>우리가 자바를 자바야 하는 이유</h1>
                        <p>자바는 우리 삶에 매우 중요하다</p>
                    </header>
                    <p>우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유우리가 자바를 자바야 하는 이유</p>
                    <ul class="actions">
                        <li><a href="#" class="button big">더 보기</a></li>
                    </ul>
                </div>
                <span class="image object">
                    <img src="resources/images/mainpage/editorspick.jpg" alt="" />
                </span>
            </section>


        <!-- Section -->
        <section>
            <header class="major">
                <h2>Erat lacinia</h2>
            </header>
            <div class="features">
                <article>
                    <span class="icon fa-gem"></span>
                    <div class="content">
                        <h3>Portitor ullamcorper</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                    </div>
                </article>
                <article>
                    <span class="icon solid fa-paper-plane"></span>
                    <div class="content">
                        <h3>Sapien veroeros</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                    </div>
                </article>
                <article>
                    <span class="icon solid fa-rocket"></span>
                    <div class="content">
                        <h3>Quam lorem ipsum</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                    </div>
                </article>
                <article>
                    <span class="icon solid fa-signal"></span>
                    <div class="content">
                        <h3>Sed magna finibus</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                    </div>
                </article>
            </div>
        </section>
        <!-- Section -->
            <section>
                <header class="major">
                    <h2>Ipsum sed dolor</h2>
                </header>
                <div class="posts">
                    <article>
                        <a href="#" class="image"><img src="images/pic01.jpg" alt="" /></a>
                        <h3>Interdum aenean</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                    <article>
                        <a href="#" class="image"><img src="images/pic02.jpg" alt="" /></a>
                        <h3>Nulla amet dolore</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                    <article>
                        <a href="#" class="image"><img src="images/pic03.jpg" alt="" /></a>
                        <h3>Tempus ullamcorper</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                    <article>
                        <a href="#" class="image"><img src="images/pic04.jpg" alt="" /></a>
                        <h3>Sed etiam facilis</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                    <article>
                        <a href="#" class="image"><img src="images/pic05.jpg" alt="" /></a>
                        <h3>Feugiat lorem aenean</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                    <article>
                        <a href="#" class="image"><img src="images/pic06.jpg" alt="" /></a>
                        <h3>Amet varius aliquam</h3>
                        <p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
                        <ul class="actions">
                            <li><a href="#" class="button">More</a></li>
                        </ul>
                    </article>
                </div>
            </section>