<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html></html>
<head>
<meta charset="UTF-8">
<title>header.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body></body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">Spring</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/board/list">Board List</a>
        </li>
        <!-- <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/user/register">회원가입</a></li>
            <li><a class="dropdown-item" href="/user/login">로그인</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li> -->
        <!-- authorize : 권한 -->
        <sec:authorize access="isAnonymous()">			<!-- anonymous : 비 로그인 상태 -->
        <!-- 인증 객체가 없는 상태 -->
	        <li class="nav-item">
	        	<a class="nav-link" href="/user/register">회원가입</a>
	        </li>
	        <li class="nav-item">
	        	<a class="nav-link" href="/user/login">로그인</a>
	        </li>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">			<!-- isAuthenticated : 로그인 상태 -->
        <!-- 인증 객체가 만들어져 있는 상태 -->
        <!-- 인증된 객체 가져오기 => 현재 로그인 정보는 : principal -->
        <sec:authentication property="principal.uvo.email" var="authEmail"/>
        <sec:authentication property="principal.uvo.nickName" var="authNick"/>
        <sec:authentication property="principal.uvo.authList" var="auths"/>	<!-- UserVO 선언된 list -->
        	<li class="nav-item">
	          <a class="nav-link" href="/board/register">Board Register</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#"> 회원정보 수정 ${authNick } (${authEmail })</a>
	        </li>
	        <c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get() }">
	        	<li class="nav-item">
	        		<a class="nav-link text-danger" href="/user/list">회원 리스트(ADMIN)</a>
	        	</li>
	        </c:if>
	        <li class="nav-item">
	        	<a class="nav-link" href="/user/logout">Logout</a>
	        	<!-- 로그아웃은 UserController 가 아닌 SecurityConfig 에 있음. -->
	        </li>
        </sec:authorize>	
      </ul>
      <!-- <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form> -->
    </div>
  </div>
</nav>