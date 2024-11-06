<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1> Custom 404 Page ...</h1>
<h3><a href="/">홈으로 돌아가기.</a></h3>

<h3><c:out value="${exception }"/></h3>
</body>
</html>