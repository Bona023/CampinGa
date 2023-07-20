<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>
<article style="text-align: center;">
<h1>배너 등록</h1>  
<form name="frm" action="adminBannerWrite" style="margin: 20px auto;">
	<table class="bannerTable">
		<tr><th>제목</th>
			<td width="600px" id="banTitle"><input type="text" name="name" maxlength="100" value="${dto.name}"></td></tr>
		<tr><th>순위</th>
			<td>
				<select name="order_seq">
					<option value="">디스플레이될 순서를 선택하세요 </option>
					<option value="1">1</option><option value="2">2</option><option value="3">3</option>
					<option value="4">4</option><option value="5">5</option><option value="6">사용안함 </option>
				</select>
			</td></tr>
		<tr><th height="300px">배너 이미지</th>
	    	<td style="vertical-align:top; text-align: center">
	   			<input type="hidden" name="image" id="image" value="${dto.image}">
	   			<div id="filename" style="margin: 20px 0;">
	   				<c:if test="${dto.image!=null}">
	   				fileName : ${dto.image}
	   				</c:if>
	   			</div>
	   		</td>
	   	</tr>	    
	</table>
	<c:if test="${message!=null}">
	 <div id="errorMsg" style="color:red;">ERROR : ${message}</div>
	</c:if>
	<input class="banBtn" type="submit" value="배너등록" style="margin-right: 40px;">   
	<input class="banBtn" type="button" value="취소" onClick="location.href='adminBannerList'">
	</form>
	
	<div style="position:relative; top:-130px; width: 600px; margin-left:200px;">
	<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
		<input type="file" name="fileimage">
		<input style="margin-left: 20px" type="button" id="fileAddBtn" value="이미지 업로드">
	</form>
	</div>
	
</article>
<%@ include file="../include/footer.jsp" %>