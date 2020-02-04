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
                <c:import url="./main/mainpage.jsp"/>
            </div>
         </div>
        <c:import url="./common/sidebar.jsp"/>
    </div>
</div>
    <!-- Scripts -->
    <script src="resources/js/jquery.min.js"></script>
    <script src="resources/js/browser.min.js"></script>
    <script src="resources/js/breakpoints.min.js"></script>
    <script src="resources/js/util.js"></script>
    <script src="resources/js/main.js"></script>
    <script src="${contextPath}/resources/js/common/prettydate.js"></script>
</body>
</html>