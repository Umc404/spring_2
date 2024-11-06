<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>user list</h1>
<c:forEach items="${userList }" var="uvo">
	<div>email : ${uvo.email }</div>
	<div>nickName : ${uvo.nickName }</div>
	<div>regDate : ${uvo.regDate }</div>
	<div>lastLogin : ${uvo.lastLogin }</div>
	
	<%-- ${userList } --%>
</c:forEach>


</div>
<jsp:include page="../layout/footer.jsp" />