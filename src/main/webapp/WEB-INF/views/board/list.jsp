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
  			<td>
  				<a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a>
	  			<c:if test="${bvo.cmtQty > 0}">
	  					[${bvo.cmtQty }]
	  			</c:if>
	  			<c:if test="${bvo.hasFile > 0 }">
	  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-floppy-fill" viewBox="0 0 16 16">
				  <path d="M0 1.5A1.5 1.5 0 0 1 1.5 0H3v5.5A1.5 1.5 0 0 0 4.5 7h7A1.5 1.5 0 0 0 13 5.5V0h.086a1.5 1.5 0 0 1 1.06.44l1.415 1.414A1.5 1.5 0 0 1 16 2.914V14.5a1.5 1.5 0 0 1-1.5 1.5H14v-5.5A1.5 1.5 0 0 0 12.5 9h-9A1.5 1.5 0 0 0 2 10.5V16h-.5A1.5 1.5 0 0 1 0 14.5z"/>
				  <path d="M3 16h10v-5.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5zm9-16H4v5.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5zM9 1h2v4H9z"/>
				</svg>
				(${bvo.hasFile })
	  			</c:if>
  			</td>
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