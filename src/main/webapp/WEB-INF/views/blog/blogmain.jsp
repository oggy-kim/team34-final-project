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
        </section>

<section>
    <header class="major">
        <h2>최근 올라온 글</h2>
    </header>
    <div class="posts">

    <script>
    fetch('${contextPath}/blog/fetch/editorspick')
        .then((res) => {
                if(res.ok) {
                    return res.json();
                } else {
                    console.log(res.status);
                }
            })
        .then((editorsPick) => {
            const banner = document.querySelector('#banner');
            const cuttedContent = textLengthOverCut(removeTags(editorsPick.bContent), 150, "...");

            console.log(banner);
            console.log(cuttedContent);

            const output = `
            <div class="content">
                <header class="major">
                    <h2>블로그 Editor's Pick📝</h2>
                </header>
                <header>
                    <h1>\${editorsPick.bHeader}</h1>
                </header>
                <p>\${cuttedContent}</p>
                <ul class="actions">
                    <li><a href="${contextPath}/blog/\${editorsPick.aNo}" class="button big">더 보기</a></li>
                </ul>
            </div>
            <span class="image object">
                <img src="\${editorsPick.imageUrl}" onerror="this.src='${contextPath}/resources/images/blog/default.png'" />
            </span>`;
            banner.innerHTML = output;
        })
        .catch((e) => {
            console.log(e)
        });



    fetch('${contextPath}/blog/fetch/?atype=2&limit=6')
        .then((res) => {
            if(res.ok) {
                return res.json();
            } else {
                console.log(res.status);
            }
        })
        .then((blogs) => {
            const posts = document.querySelector('.posts');
            blogs.map((blog) => {
                const text = removeTags(blog.bContent);
                const cuttedContent = textLengthOverCut(text, 150, "...");
                const dateInfo = prettyDate(blog.writeDate);
                const output = `
                <article>
                    <a href="${contextPath}/blog/\${blog.aNo}" class="image"><img src="\${blog.imageUrl}" onerror="this.src='${contextPath}/resources/images/blog/default.png'" style="max-height: 250px;" alt="" /></a>
                    <h3>\${blog.bHeader}</h3>
                    \${dateInfo}
                    <p>\${cuttedContent}</p>
                    <ul class="actions">
                        <li><a align="bottom" href="${contextPath}/blog/\${blog.aNo}" class="button">More</a></li>
                    </ul>
                </article>
                `;
                posts.innerHTML += output;
            })
        }).catch((e) => {
            console.log(e)
        }) ;

        function removeTags(content){
            var rex = /(<([^>]+)>)/ig;
            return content.replace(rex, "");
        }


        function textLengthOverCut(txt, len, lastTxt) {
        if (len == "" || len == null) { // 기본값
            len = 30;
        }
        if (lastTxt == "" || lastTxt == null) { // 기본값
            lastTxt = "...";
        }
        if (txt.length > len) {
            txt = txt.substr(0, len) + lastTxt;
        }
        return txt;
    }
    </script>
    </div>
</section>



