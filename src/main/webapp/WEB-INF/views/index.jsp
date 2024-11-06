<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<jsp:include page="layout/header.jsp" />

<div class="container-md">
	<h1>
		My Spring Project  
	</h1>
	<P>  The time on the server is ${serverTime}. </P>

<script type="text/javascript">
	let modify_msg = `<c:out value = "${modify_msg}" />`;
	console.log(modify_msg);
	if(modify_msg == "ok") {
		alert("회원정보 수정 완료. 다시 로그인하세요.");
	} else if(modify_msg == "fail") {
		alert("회원정보 수정 실패. 재시도 해주세요."");
	}
	
	let remove_msg = `<c:out value = "${remove_msg}" />`;
	console.log(remove_msg);
	if(remove_msg == "ok") {
		alert("회원탈퇴 완료.");
	} else if (remove_msg == "fail") {
		alert("회원탈퇴 실패.");
	}
</script>
</div>

<jsp:include page="layout/footer.jsp" />
