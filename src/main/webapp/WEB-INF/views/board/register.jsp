<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="../layout/header.jsp" />
<div class="mb-3">
	<h1>Board Insert</h1>
<sec:authentication property="principal.uvo.nickName" var="authNick"/>
	<hr>
	<!-- enctype : multipart/form-data -->
	<form action="/board/insert" method="post" enctype="multipart/form-data">
		<div class="mb-3">
		  <label for="t" class="form-label">title</label>
		  <input type="text" class="form-control" id="t" name="title" placeholder="title..">
		</div>
		<div class="mb-3">
		  <label for="w" class="form-label">writer</label>
		  <input type="text" class="form-control" id="w" name="writer" value="${authNick }" readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="c" class="form-label">content</label>
		  <textarea class="form-control" id="c" name="content" rows="3"></textarea>
		</div>
		
		<!-- 첨부파일 입력 라인 추가 -->
		<div class="mb-3">
			<label for="file" class="form-label"></label>
			<input type="file" class="form-control" id="file" name="files"
			multiple="multiple" style="display:none">
			<button type="button" class="btn btn-info" id="trigger">FileUpload..</button>
		</div>
		
		<!-- 첨부파일 표시라인 -->
		<div class="mb-3" id="fileZone">
		</div>
		
		<button type="submit" class="btn btn-primary" id="regBtn">Register</button>
	</form>
</div>

<script type="text/javascript" src="/resources/js/boardRegister.js"></script>

<jsp:include page="../layout/footer.jsp" />