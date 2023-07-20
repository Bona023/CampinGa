<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
	opener.frmbs.imagefiles.value='${image}';  // 전송될 히든태그에 이름 삽입
	self.close();
</script>

</body>
</html>