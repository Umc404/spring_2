<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="mb-3">
	<h1>login Insert</h1>
	<hr>
	<form action="/user/login" method="post">
		<div class="mb-3">
		  <label for="e" class="form-label">email</label>
		  <input type="text" class="form-control" id="e" name="email" placeholder="email..">
		</div>
		<div class="mb-3">
		  <label for="p" class="form-label">password</label>
		  <input type="text" class="form-control" id="p" name="pwd" placeholder="password..">
		</div>
		<!-- 로그인 실패 시 errMessage 출력 -->
		<c:if test="${param.errMsg ne null }">
			<div class="text-danger">${param.errMsg }</div>
		</c:if>
		<button type="submit" class="btn btn-primary">login</button>	
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>