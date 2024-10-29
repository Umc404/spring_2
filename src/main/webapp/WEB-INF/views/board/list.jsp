<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board ?? Page</h1>
<hr>
<table class="table table-striped table-hover">
  <thead>
  	<tr>
  		<th scope="col">#</th>
  		<th scope="col">title</th>
  		<th scope="col">writer</th>
  		<th scope="col">regdate</th>
  		<th scope="col">readCount</th>
  	</tr>
  </thead>
  <tbody>
  	<c:forEach items="${list }" var="bvo">
  		<tr>
  			<td>${bvo.bno }</td>
  			<td><a href="#">${bvo.title }</a></td>
  			<td>${bvo.writer }</td>
  			<td>${bvo.regDate }</td>
  			<td>${bvo.readCnt }</td>
  		</tr>
  	</c:forEach>
  </tbody>
</table>
<button type="button" class="btn btn-success">Success</button><br>
<jsp:include page="../layout/footer.jsp" />	