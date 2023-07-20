<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administer</title>
<link href="css/campinga.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="script/campinga.js"></script>
<script type="text/javascript">
//배너파일 업로드
var str = '';
$(function(){
	$('#fileAddBtn').click( function(){
		var formselect = $("#fileupForm")[0];  
		var formdata = new FormData(formselect); 
		$.ajax({ 
			url:"<%=request.getContextPath() %>/banFileUp", 
			type:"POST",
			enctype:"multipart/form-data",
			async: false,
			data: formdata,
	    	timeout: 10000,
	    	contentType : false,
	        processData : false,
	        success : function(data){
	            if(data.STATUS == 1){
	            	$("#filename").empty();
	            	$("#filename").append("<div>"+data.FILENAME+"</div>");
	            	$("#image").val(data.FILENAME);
	            	$("#filename").append("<img src='images/banner/"+data.FILENAME+"'height='200'/>");
	            	str += data.FILENAME+'#';
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

<div id="wrap">
   <header class="adminHeader">         
      <div id="logo">
         <a href="/">
            <img src="images/main/logoF.png" width="220" height="50">
         </a>
      </div>
      <div class="adLogout">
      <c:if test="${loginAdmin!=null}">
         <input type="button" value="logout" 
         onClick="location.href='adminLogout'">
      </c:if>            
      </div>      
   </header>