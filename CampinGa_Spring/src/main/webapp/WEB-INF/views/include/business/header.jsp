<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CampinGa</title>
<link href="css/campinga.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="script/campinga.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">

$(function(){
	$('#myButton').click( function(){
		
		var formselect = $("#fileuploadForm")[0];   // 지목된 폼을 변수에 저장
		var formdata = new FormData(formselect);   // 전송용 폼객에 다시 저장
		$.ajax({    // 웹페이지 이동 또는 새로고침이 필요없는 request요청
			url:"<%=request.getContextPath() %>/fileup",   // 해당 컨트롤러의 requestMapping 목적지 설정
			type:"POST",
			enctype:"multipart/form-data",
			async: false,
			data: formdata,
	    	timeout: 10000,
	    	contentType : false,
	        processData : false,
	        success : function( data ){
	            if(data.STATUS == 1){  	//동적으로 div태그 달아주기.
	            	$("#filename").append("<div>"+data.FILENAME+"</div>");
	            	$("#previewImg").val(data.FILENAME);
	            	$("#filename").append("<img src='images/"+data.FILENAME+"' height='150'/>");
	            }
	        },
	        error: function() {				alert("실패");			}
		});
	});
});
</script>
</head>
<body>

<div id="wrap">
	<header>
	<nav id="top_menu"> <!-- 메인메뉴 시작 -->
		<ul>
			<c:choose>
				<c:when test="${not empty loginUser}">
					<li><a href="myPage" style="width: 100px;">
						${loginUser.NAME}(${loginUser.MID})</a></li>
					<li><a href="logout">Logout</a></li>
				</c:when>
				<c:when test="${not empty loginBusinessman}">
					<li><a href="businessmanMypage">
						${loginBusinessman.NAME}(${loginBusinessman.BID})</a></li>
					<li><a href="logout">Logout</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="loginForm">Login</a></li>
					<li><a href="contract">Join</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="noticeList">Notice</a></li>
		</ul>
	</nav>
	
	<div id="logo"><!-- 로고시작 -->
		<a href="/">
			<img src="images/main/logoH.png">
		</a>
	</div><!-- 로고 끝 -->
	
	<nav id="category_menu">		
		<div onclick="location.href='category?kind=1'"><span>ALL</span></div>
		<div class="icons" onclick="location.href='category?kind=2'">
			<div class="iconImg1">
				<img src="images/icon/autoB.png">
				<span>오토캠핑</span>
			</div>
			<div class="iconImg2">
				<img src="images/icon/autoW.png">
				<span>오토캠핑</span>
			</div>				
		</div>
		<div class="icons" onclick="location.href='category?kind=3'">
			<div class="iconImg1">
				<img src="images/icon/glamB.png">
				<span>캠핑</span>
			</div>
			<div class="iconImg2">
				<img src="images/icon/glamW.png">
				<span>캠핑</span>
			</div>
		</div>
		<div class="icons" onclick="location.href='category?kind=4'">
			<div class="iconImg1">
				<img src="images/icon/caraB.png">
				<span>카라반</span>
			</div>
			<div class="iconImg2">
				<img src="images/icon/caraW.png">
				<span>카라반</span>
			</div>
		</div>
		<div class="icons" onclick="location.href='category?kind=5'">
			<div class="iconImg1">
				<img src="images/icon/picB.png">
				<span>캠프닉</span>
			</div>
			<div class="iconImg2">
				<img src="images/icon/picW.png">
				<span>캠프닉</span>
			</div>
		</div>	
	</nav>
	</header>







