<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="../layout/header.jsp" />
<div class="mb-3">
<form action="/board/insert" method="post">
<div class="mb-3">
  <label for="t" class="form-label">title</label>
  <input type="text" class="form-control" id="t" name="title" placeholder="title..">
</div>
<div class="mb-3">
  <label for="w" class="form-label">writer</label>
  <input type="text" class="form-control" id="w" name="writer" placeholder="writer..">
</div>
<div class="mb-3">
  <label for="c" class="form-label">content</label>
  <textarea class="form-control" id="c" name="content" rows="3"></textarea>
</div>
<button type="submit" class="btn btn-primary">Primary</button>
</form>
</div>

<jsp:include page="../layout/footer.jsp" />

</body>
</html>