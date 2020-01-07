<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CODEHAPPY</title>
    <link rel="icon" type="image/png" href="${ pageContext.servletContext.contextPath }/resources/images/common/siteicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/main.css" />
</head>
<body class="is-preload">
    <script>
		<c:if test="${!empty msg }">
			alert('${ msg }');
			<c:remove var="msg"/>
		</c:if>
	</script>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>