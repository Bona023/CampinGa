<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드</title>

<link rel="stylesheet" type="text/css" href="/css/campinga.css" >
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/script/campinga.js"></script>
<script type="text/javascript">
//캠핑장 사진 업로드
var str = '';
$(function(){
	$('#fileAddBtn').click( function(){
		var formselect = $("#fileupForm")[0];  
		var formdata = new FormData(formselect); 
		$.ajax({ 
			url:"<%=request.getContextPath() %>/fileup", 
			type:"POST",
			enctype:"multipart/form-data",
			async: false,
			data: formdata,
	    	timeout: 10000,
	    	contentType : false,
	        processData : false,
	        success : function(data){
	            if(data.STATUS == 1){
	            	str += data.FILENAME+',';
	            	//$("#filename").empty();
	            	$("#filename").append("<div>"+data.FILENAME+"</div>");
	            	$("#image").val(str);
	            	$("#filename").append("<img src='images/campingImage/"+data.FILENAME+"'height='200'/>");
	            	console.log(str);
	            }
	        },
	        error: function() {	alert("파일 업로드 실패");}
		});
	});
});
</script>
</head>
<body>
<article style="text-align: center;">
<br><h1>이미지 등록</h1>  
<form name="frm" action="bsCampingImgs" style="margin: 20px auto;">
	<table class="bannerTable" style="width: 650px; height: 400px;
		margin-left:auto; margin-right:auto;">
		<tr>
			<th width="100px" height="350px">이미지</th>
	    	<td style="vertical-align:top; text-align: center">
	   			<input type="hidden" name="image" id="image" value="${dto.image}">
	   			<div id="filename" style="margin: 20px 0;">
	   				<c:if test="${dto.image!=null}">
	   				fileName : ${dto.image}
	   				</c:if>
	   			</div>
	   		</td>
	   	</tr>
	   	<tr>
	   		<td colspan="2" height="50px"></td>
	   	</tr>	  
	</table>
	<input class="banBtn" type="submit" value="이미지 등록" style="margin-right: 40px;">
</form>
	
	<div style="position:relative; top:-130px; left: -100px; width: 600px; margin-left:200px;">
		<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
			<input type="file" name="fileimage">
			<input style="margin-left: 20px" type="button" id="fileAddBtn" value="이미지 업로드">
		</form>
	</div>
	
</article>

</body>
</html>