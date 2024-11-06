<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board Modify Page...</h1>
<hr>
<c:set value="${bdto.bvo }" var="bvo"></c:set>
<form action="/board/update" method="post" enctype="multipart/form-data">
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
	
	<!-- # file upload line # -->
	<c:set value="${bdto.flist }" var="flist"></c:set>
	<div class="mb-3">
		<ul class="list-group list-group-flush">
		  <!-- 파일의 개수만큼 li를 반복하여 파일 표시 타입이 1인 경우만 그림을 표시 -->
		  <c:forEach items="${flist }" var="fvo">
		  	<li class="list-group-item">
		  		<c:choose>
		  			<c:when test="${fvo.fileType > 0 }">
		  				<div>
		  					<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}">
		  				</div>
		  			</c:when>
		  			<c:otherwise>
		  				<!-- 일반파일 : 아이콘 하나 가져와서 다운로드 가능하게 생성 -->
		  			</c:otherwise>
		  		</c:choose>
		  		<div class="fw-bold">${fvo.fileName }</div>
		  		<span class="badge text-bg-primary rounded-pill">${fvo.regDate } / ${fvo.fileSize } Bytes</span>
		  		<button type="button" data-uuid="${fvo.uuid }" class="btn btn-outline-danger btn-sm file-x">X</button>
		  	</li>
		  </c:forEach>
		</ul>
	</div>
		<button type="submit" class="btn btn-success" id="regBtn">modify</button>
		<a href="/board/list"><button type="button" class="btn btn-info">list</button></a>
</form>	
	<script type="text/javascript" src="/resources/js/boardModify.js"></script>
	<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
</div>
<jsp:include page="../layout/footer.jsp" />