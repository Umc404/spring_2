<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board Page</h1>
<hr>
<!-- search line -->
<!-- <nav class="navbar bg-body-tertiary"> -->
  <div class="container-fluid">
    <form action="/board/list" method="get" class="d-flex" role="search">
    <select class="form-select" name="type" id="inputGroupSelect01">
	    <option ${ph.pgvo.type eq null ? 'selected': '' } >Choose...</option>
	    <option value="t" ${ph.pgvo.type eq 't' ? 'selected': '' }>title</option>
	    <option value="w" ${ph.pgvo.type eq 'w' ? 'selected': '' }>writer</option>
	    <option value="c" ${ph.pgvo.type eq 'c' ? 'selected': '' }>content</option>
	    <option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected': '' }>title & writer</option>
	    <option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected': '' }>writer & content</option>
	    <option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected': '' }>title & content</option>
	    <option value="twc">all</option>
  	</select>
  	

    	<input class="form-control me-2" name="keyword" type="search" value="${ph.pgvo.keyword }" placeholder="Search" aria-label="Search">
    	<input type="hidden" name="pageNo" value="1">
      
  <%--     <button type="submit" class="btn btn-outline-success">
      	Search
       	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
	   		${ph.totalCount }
	    <span class="visually-hidden">unread messages</span>
	  </span>
      </button> --%>
	<button type="submit" class="btn btn-primary position-relative">
	Search
	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
	  ${ph.totalCount }
	  <span class="visually-hidden">unread messages</span>
	</span>
	</button>
    </form>
  </div>
<!-- </nav> -->
<table class="table table-striped table-hover">
  <thead>
  	<tr>
  		<th scope="col">#</th>
  		<th scope="col">title</th>
  		<th scope="col">writer</th>
  		<th scope="col">regDate</th>
  		<th scope="col">readCount</th>
  	</tr>
  </thead>
  <tbody>
  	<c:forEach items="${list }" var="bvo">
  		<tr>
  			<td>${bvo.bno }</td>
  			<td><a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a></td>
  			<td>${bvo.writer }</td>
  			<td>${bvo.regDate }</td>
  			<td>${bvo.readCnt }</td>
  		</tr>
  	</c:forEach>
  </tbody>
</table>
</div>

<!--pagination line -->
<nav aria-label="Page navigation example">
	<!-- 왼쪽 화살표 -->
	<!--  -->
  <ul class="pagination justify-content-center">
    <li class="page-item ${ph.prev eq false ? 'disabled':'' }">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.qty}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    
    <!-- 반복되는 페이징 넘버-->
    <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
    	<li class="page-item"><a class="page-link ${ph.pgvo.pageNo eq i? 'active':'' }" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.qty}">${i }</a></li>
    </c:forEach>
    
    <!-- 오른쪽 화살표 -->
    <li class="page-item ${ph.next eq false ? 'disabled':'' }">
      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.qty}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>

<a href="/"><button type="button" class="btn btn-success">index</button></a>
<jsp:include page="../layout/footer.jsp" />	