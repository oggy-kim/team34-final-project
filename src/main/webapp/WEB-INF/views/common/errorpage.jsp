<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="error-container" style="text-align:center;">
		<h1>Error</h1>
		<%-- <h2 style="color:red;">${ msg }</h2> --%>
		<h2 style="color:red;"><%= request.getAttribute("javax.servlet.error.message") %></h2>
		<a href="/">시작페이지로 돌아가기</a>
	</div>
</body>
</html>