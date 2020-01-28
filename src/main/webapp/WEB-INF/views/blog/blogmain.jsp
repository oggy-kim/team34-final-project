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
            title_header.innerHTML = "CODEHAPPY 블로그✉️";
        </script>

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

<section>
    <header class="major">
        <h2>다른 유저가 읽고있는 글</h2>
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
    </div>
</section>



