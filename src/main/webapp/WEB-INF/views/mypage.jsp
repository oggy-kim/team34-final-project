<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/include.jsp" %>

<div id="body">
<!-- Wrapper -->
<div id="wrapper">
        <!-- Main -->
        <div id="main">
                <div class="inner">
                    <c:import url="./common/header.jsp"/>
                    <c:import url="./mypage/mymain.jsp"/>
                </div>
        </div>
        <c:import url="./common/sidebar.jsp"/>
        <form action="${contextPath}/mypage/${loginMember.mNo}" method="post">
            <div class="modifyForm" id="modifynick">
                        <div class="popup">
                                <div id="nick-div">
                                        <div id="nick-margin">
                                            <h2 id="nick-h2">닉네임을 등록해주세요.</h2>
                                        </div>
                                    </div>
                            <a class="close" href="#">&times;</a>
                            <br>
                            <div class="content">
                                <input type="text" name="mNick" id="mNick" value="${ loginMember.mNick }">
                            </div>
                            <br>
                            <div class="actionButton">
                                <input type="submit" value="확인">&nbsp;
                                <button type="button" onclick="location.href='${ mymain }'">취소</button>
                            </div>
                        </div>
                    </div>
			</form>
        </div>
</div>

    <!-- Scripts -->
    <script src="resources/js/jquery.min.js"></script>
    <script src="resources/js/browser.min.js"></script>
    <script src="resources/js/breakpoints.min.js"></script>
    <script src="resources/js/util.js"></script>
    <script src="resources/js/main.js"></script>
    <script src="resources/js/fetch.js"></script>
</body>
</html>