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
        <h2>블로그 - 글쓰기</h2>
    </header>
    <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
                <form id="insertForm" method="POST" onsubmit="return writeValidate();">
                    <div class="box">
                        <div class="col-6 col-12-xsmall">
                            <select name="cType" id="demo-category">
                                <option value="">- 카테고리 -</option>
                                <option value="1">프론트엔트</option>
                                <option value="2">백엔드</option>
                                <option value="3">그외 프로그래밍</option>
                                <option value="4">자유게시판</option>
                            </select>
                            <input type="text" name="bHeader" id="demo-name" placeholder="제목(10자이상 입력)  ex) Javascript와 Java는 어떻게 다른가요?" />
                        </div>
                        <br>
                        <textarea name="bContent" id="editor2" rows="10" cols="50" placeholder="코드해피를 위해 도움이 되는 글을 올려주세요. <p> 규칙에 위배되는 글 작성시 삭제 처리됩니다. ">
                        </textarea>
                        <script>
                            CKEDITOR.replace( 'editor2', {
                                height: 500,
                                filebrowserUploadUrl: '${contextPath}/blog/imageUpload.do'
                            });
                        </script>
                        <br>
                        <h3>태그</h3><p>입력 후 <code>,</code> 눌러서 태그 추가 / 태그 클릭 시 삭제 가능 / 질문과 관련된 <strong>1개 ~ 3개 태그까지 </strong>선택 가능합니다.</p> 
                        
                        <div class="box" id="tagBox" vertical-align="middle">
                        <input type="text" id="inputTagBox" onkeyup="addTagFunction();" style="width:100px; float: left;"><span></span> &nbsp;
                        <script>
                            let aTag = [];
                            function addTagFunction() {
                            let inputTagBox = document.querySelector("#inputTagBox");
                            let tagBox = document.querySelector("#tagBox");
                            if(event.keyCode == 188) {
                                if(inputTagBox.value.slice(-2) === ',') {
                                    alert("쉼표는 여러번 들어갈 수 없습니다.");
                                    inputTagBox.value = "";
                                    inputTagBox.focus();
                                    return;
                                }
                                if(inputTagBox.value === "") {
                                    alert("빈 태그는 입력하실 수 없습니다.");
                                    inputTagBox.value = "";
                                    inputTagBox.focus();
                                    return;
                                }
                                if(aTag.length >= 3) {
                                    alert('태그는 최대 3개까지만 입력 가능합니다.');
                                    inputTagBox.value = "";
                                    inputTagBox.focus();
                                    return;
                                }
                                if(inputTagBox.value.length > 20) {
                                    alert("20자 이상의 태그는 입력하실 수 없습니다.");
                                    inputTagBox.value = "";
                                    inputTagBox.focus();
                                    return;
                                }
                                tagBox.innerHTML += "<span id='selectedTag' class='button secondary' onclick='removeTagFunction();' id='tagList'>" + inputTagBox.value.slice(0, -1) + "</span> &nbsp;";
                                aTag.push(inputTagBox.value.slice(0, -1));
                                document.querySelector('input[name$=aTag]').value = aTag.join(',') + ',';
                                console.log(aTag);
                                }
                            }
                            function removeTagFunction() {
                                    aTag.splice(aTag.indexOf(event.target.innerHTML), 1);
                                    document.querySelector('input[name$=aTag]').value = aTag.join(',');
                                    event.target.remove();
                            }
                        </script>
                        <input type="hidden" name="aTag" value="">
                        </div>
                        <c:choose>
                            <c:when test="${board ne null}">
                                <script>
                                    const category = document.querySelector('#demo-category');
                                    const name = document.querySelector('#demo-name');
                                    const content = document.querySelector('#editor2');
                                    const tagbox = document.querySelector('#tagBox');
                                    name.value = "${board.bHeader}";
                                    category.value = ${board.cType};
                                    content.value = `<c:out value="${board.bContent}" escapeXml="false"/>`;
                                    <c:set var="aTag" value="${board.aTag}"/>
                                    <c:forEach var="t" items="${fn:split(aTag, ',')}">
                                        tagbox.innerHTML += "<span id='selectedTag' class='button secondary' onclick='removeTagFunction();' id='tagList'>${t}</span>&nbsp;";
                                    </c:forEach>

                                    const tagList = document.querySelectorAll('#tagBox > #selectedTag');
                                    tagList.forEach((tag) => {
                                        aTag.push(tag.innerText);
                                    })
                                    document.querySelector('input[name$=aTag]').value = aTag.join(',') + ',';
                                </script>
                                <input type="submit" value="글 수정" class="button primary" vertical-align="middle">
                                <a class="button primary" vertical-align="middle" onclick="deleteBoard();">글 삭제</a>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="게시" class="button primary" vertical-align="middle">
                            </c:otherwise> 
                    </c:choose>
                </form>

                <script>
                    function deleteBoard() {
                        if(confirm('한번 삭제한 글은 다시 확인할 수 없습니다. 삭제하시겠습니까?')) {
                            location.href="${contextPath}/blog/${aNo}/delete.do";
                        }
                    }
                </script>

                
                <script>
                    function writeValidate() {
                        if(!document.querySelector('#selectedTag')) {
                            alert('최소 1개 이상의 태그를 선택해주세요.');
                            document.querySelector('#inputTagBox').focus();
                            return false;
                        }
                        if(document.querySelector('#demo-category').value === "") {
                            alert('글의 카테고리를 선택해주세요.');
                            document.querySelector('#demo-category').focus();
                            return false;
                        }
                        if(document.querySelector('#demo-name').value.length <= 10) {
                            alert('10자 이상의 제목을 입력해주세요.');
                            document.querySelector('#demo-name').focus();
                            return false;
                        }
                        if(document.querySelector('#demo-name').value.length > 50) {
                            alert('50자 이하의 제목을 입력해주세요.');
                            document.querySelector('#demo-name').focus();
                            return false;
                        }
                        return true;
                    }
                </script>
</section>
