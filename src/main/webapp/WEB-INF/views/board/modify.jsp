<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board Modify Page...</h1>
<hr>
<form action="/board/update" method="post">
	<div class="mb-3">
	  <label for="n" class="form-label">no.</label>
		<input type="hidden" name="bno" value="${bvo.bno }">
	  <input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
	</div>
	<div class="mb-3">
	  <label for="t" class="form-label">title</label>
	  <input type="text" name="title" class="form-control" id="t" value="${bvo.title }">
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">writer</label>
	  <input type="text" class="form-control" id="w" value="${bvo.writer }" readonly>
	  <span class="badge text-bg-info">${bvo.regDate }</span>
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">content</label>
	  <textarea class="form-control" name="content" id="c" rows="3">${bvo.content }</textarea>
	</div>
	
	<button type="submit" class="btn btn-success">modify</button>
	<a href="/board/list"><button type="button" class="btn btn-info">list</button></a>
</form>	
	
</div>
<jsp:include page="../layout/footer.jsp" />