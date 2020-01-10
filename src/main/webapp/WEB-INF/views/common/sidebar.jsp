<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Sidebar -->
<div id="sidebar">
    <div class="inner">
        <!-- Search -->
            <section id="search" class="alt">
                <form method="post" action="#">
                    <input type="text" name="query" id="query" placeholder="Search" />
                </form>
            </section>

        <!-- Menu -->
            <nav id="menu">
                <header class="major">
                    <a href="${contextPath}"><img src="${contextPath}/resources/images/common/sitelogo.png" width="80%"></a>
                </header>
                <ul>
                    <li>
                        <span class="opener"><a href="${contextPath}/board">게시판</a></span>
                        <ul>
                            <li><a href="${contextPath}/board/?type=frontend">프론트엔드</a></li>
                            <li><a href="${contextPath}/board/?type=backend">백엔드</a></li>
                            <li><a href="${contextPath}/board/?type=others">그외 프로그래밍</a></li>
                            <li><a href="${contextPath}/board/?type=freetalk">자유게시판</a></li>
                        </ul>
                    </li>
                    <li><a href="${contextPath}/blog">블로그</a></li>
                </ul>
            </nav>

        <!-- Section -->
            <section>
                <header class="major">
                    <h2>&#x1F913; &nbsp;About Me</h2>
                </header>
                <div class="mini-posts">
                    <article>
                        <p>{코드포인트} ${loginMember.mPoint} 점 </p>
                    </article>
                    <article>
                        <p>나의 최근 게시글 업데이트</p>
                        <a href="#" class="image"><img src="images/pic08.jpg" alt="" /></a>
                    </article>
                </div>
                <ul class="actions">
                    <li><a href="#" class="button">More..</a></li>
                </ul>
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
                    <li class="icon solid fa-home">서울시 강남구 <br />
                    테헤란로 어딘가</li>
                </ul>
            </section>

        <!-- Footer -->
            <footer id="footer">
                <p class="copyright">&copy; http://Codehappy.site . All rights reserved. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
            </footer>
    </div>
</div>