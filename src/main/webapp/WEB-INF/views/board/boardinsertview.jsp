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
        title_el.innerHTML = "CODEHAPPY - 글쓰기";
        title_header.innerHTML = "CODEHAPPY 글쓰기";
</script>
<section>
    <header class="major">
        <h2>게시판 - 글쓰기</h2>
    </header>
    <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
                <form method="POST">
                    <div class="box">
                        <div class="col-6 col-12-xsmall">
                            <select name="cType" id="demo-category">
                                <option value="">- 카테고리 -</option>
                                <option value="1">프론트엔트</option>
                                <option value="1">백엔드</option>
                                <option value="1">그외 프로그래밍</option>
                                <option value="1">자유게시판</option>
                            </select>
                            <input type="text" name="bHeader" id="demo-name" placeholder="제목" />
                        </div>
                        <br>
                        <textarea name="bContent" id="editor" rows="10" cols="50">
                        </textarea>
                        <script>
                            CKEDITOR.replace( 'editor', {
                                height: 500
                            } );
                        </script>
                        <br>
                        <input type="submit" value="게시" vertical-align="middle">
                </form>

</section>
