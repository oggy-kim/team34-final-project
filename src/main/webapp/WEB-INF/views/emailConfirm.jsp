<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

    <script type="text/javascript">
        var mId = "${mId}";

        alert(mId + "님 회원가입을 축하합니다. 이제 로그인이 가능합니다.");

        window.open('','_self','');
        window.close();
        self.location = '/';

    </script>

</body>
</html>