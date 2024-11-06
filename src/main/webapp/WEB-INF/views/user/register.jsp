<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    
<jsp:include page="../layout/header.jsp" />
<div class="mb-3">

	<h1>Board Insert</h1>
	<hr>
	<form action="/user/register" method="post">
		<div class="mb-3">
		  <label for="e" class="form-label">email</label>
		  <input type="text" class="form-control" id="e" name="email" placeholder="email..">
		</div>
		<div class="mb-3">
		  <label for="p" class="form-label">password</label>
		  <input type="text" class="form-control" id="p" name="pwd" placeholder="password..">
		</div>
		<div class="mb-3">
		  <label for="n" class="form-label">nickName</label>
		  <input type="text" class="form-control" id="n" name="nickName" placeholder="nickname..">
		</div>
		
		<button type="submit" class="btn btn-primary">join</button>	
	</form>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>