<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<h1>Board Detail Page...</h1>
<hr>
<!-- request 객체로 온 값은 ${bdto} -->
<!-- c:set은 값을 저장하는 용도 -->
<c:set value="${bdto.bvo }" var="bvo"></c:set>

	<div class="mb-3">
	  <label for="n" class="form-label">no.</label>
	  <input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
	</div>
	<div class="mb-3">
	  <label for="t" class="form-label">title</label>
	  <input type="text" class="form-control" id="t" value="${bvo.title }" readonly>
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">writer</label>
	  <input type="text" class="form-control" id="w" value="${bvo.writer }" readonly>
	  <span class="badge text-bg-info">${bvo.regDate }</span>
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">content</label>
	  <textarea class="form-control" id="c" rows="3" readonly>${bvo.content }</textarea>
	</div>
	
	<!-- # file upload line # -->
	<c:set value="${bdto.flist }" var="flist"></c:set>
	<div class="mb-3">
		<ul class="list-group list-group-flush">
		  <!-- 파일의 개수만큼 li를 반복하여 파일 표시 타입이 1인 경우만 그림을 표시 -->
		  <c:forEach items="${flist }" var="fvo">
		  	<li class="list-group-item">
		  		<c:choose>
		  			<c:when test="${fvo.fileType eq '1'}">
		  				<div>
		  					<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}">
		  				</div>
		  			</c:when>
		  			<c:otherwise>
		  				<!-- 일반파일 : 아이콘 하나 가져와서 다운로드 가능하게 생성 -->
		  				<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download="">
		  					<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
	  							<path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1m-1 4v3
	  									.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0"/>
							</svg>
		  				</a>
		  			</c:otherwise>
		  		</c:choose>
		  		<div class="fw-bold">${fvo.fileName }</div>
		  		<span class="badge text-bg-primary rounded-pill">${fvo.regDate } / ${fvo.fileSize } Bytes</span>
		  	</li>
		  </c:forEach>
		</ul>
	</div>
	
	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">modify</button></a>
	<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">delete</button></a>
	<br>
	<hr>
	
	<!-- comment line -->
	<!-- comment post -->
	
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.uvo.nickName" var="authNick"/>
		<div class="input-group mb-3">
		  <span class="input-group-text" id="cmtWriter">${authNick }</span>
		  <input type="text" id="cmtText" class="form-control" placeholder="write comment.." aria-label="Username" aria-describedby="basic-addon1">
		  <button type="button" id="cmtAdd" class="btn btn-secondary">Post</button>
		</div>
	<c:set value="${authNick }" var="nick"/>
	</sec:authorize>
	
	<!-- comment print -->
	<ul class="list-group list-group-flush" id="cmtListArea">
	  <li class="list-group-item">
		  <div class="ms-2 me-auto">
		  		<div class="fw-bold">Comment name</div>
		      Content
		  </div>
	    <span class="badge text-bg-primary rounded-pill">regDate</span>
	  </li>
	</ul>
		
	<!-- 댓글 더보기 버튼 -->
	<div>
		<button type="button" id="moreBtn" data-page="1" class="btn btn-dark" style="visibility: hidden">More +</button>
	</div>
	
	
	<!-- modal : 댓글창 수정 누를 시 생성 -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="cmtWriterMod"></h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="text" class="form-control" id="cmtTextMod">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" id="cmtModBtn" class="btn btn-primary">Changes</button>
      </div>
    </div>
  </div>
</div>
	
	<script type="text/javascript">
	let bnoVal = `<c:out value="${bvo.bno }" />`;
	console.log(bnoVal);
	let authNick = `<c:out value="${nick }" />`;
	console.log(authNick);
	</script>
	
<!-- 	<script type="text/javascript">
		let bnoVal = `<c:out value="${bvo.bno}" />`;
		console.log(bnoVal);
	</script>
	 -->
	<script type="text/javascript" src="/resources/js/boardDetailComment.js"></script>
	
	<script type="text/javascript">
		spreadCommentList(bnoVal);
	</script>
	
</div>
<jsp:include page="../layout/footer.jsp" />