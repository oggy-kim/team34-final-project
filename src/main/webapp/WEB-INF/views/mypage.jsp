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
                    <style>
                        p {
                            margin: 20px 0px;
                        }
                    </style>
                    <c:import url="./mypage/mymain.jsp"/>
                </div>
        </div>
        <c:import url="./common/sidebar.jsp"/>
        <form action="${contextPath}/mypage/${loginMember.mNo}" method="post">
            <input id="test_mid" name="mId" value="${loginMember.mId}">
            <input id="test_mid" name="mPoint" value="${loginMember.mPoint}">
            <input id="test_mid" name="aNo" value="${loginMember.aNo}">
            <!-- 닉네임 변경 시작 -->
            <div class="modifyForm" id="modifynick">
                            <div class="popup">
                                    <div id="nick-div">
                                            <div id="nick-margin">
                                                <h2 id="nick-h2">닉네임을 등록해주세요.</h2>
                                                <h3 id="nick-h3">(9글자 내외)</h3>
                                            </div>
                                        </div>
                                <a class="close" href="#">&times;</a>
                                <br>
                                <div class="contented">
                                    <input type="text" name="mNick" id="mNick" value="${ loginMember.mNick }">
                                </div>
                                <br>
                                <div class="actionButton">
                                    <input type="submit" value="확인">&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="button" onclick="location.href='${ mymain }'">취소</button>
                                </div>
                            </div>
            </div>
            <!-- 닉네임 변경 끝 -->
            <!-- 자기소개 변경 시작 -->
            <div class="aboutmeForm" id="aboutMe">
                <div class="popup2">
                        <div id="nick-div2">
                                <div id="nick-margin2">
                                    <h2 id="nick-h2">자기소개를 등록해주세요.</h2>
                                    <h3 id="nick-h3">(최대 100자)</h3>
                                </div>
                            </div>
                    <a class="close" href="#">&times;</a>
                    <br>
                    <div class="contented2">
                        <p>
                            <textarea id="aboutMe" name="aboutMe" placeholder="자기소개는 최대 100자까지 입력됩니다."
                                style="padding: 5px; width: 100%; height: 150px"></textarea>
                        </p>
                    </div>
                    <br>
                    <div class="actionButton2">
                        <input type="submit" value="확인">&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" onclick="location.href='${ mymain }'">취소</button>
                    </div>
                </div>
            </div>
            <!-- 자기소개 변경 끝 -->
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
    <script src="resources/js/slim.min.js"></script>
    <script src="resources/js/popper.min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
</body>
</html>