<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp" %>
<%@ include file="../../include/business/sub_menu.jsp"%>

<script src="business/business.js"></script>
<article>
<form method="post" action="updateBusinessInfo">
	<input type="hidden" name="bseq" value="${loginBusinessman.BSEQ}">
	<div class="joinTable">
	<h2>사업자 정보 수정</h2> <br><br>
	<fieldset>
		<div class="inputDiv" style="padding-left: 30px;">
		<label>User ID </label><input type="text" name="bid" value="${loginBusinessman.BID}" readonly><br>
		</div>
		<div class="inputDiv" style="padding-left: 30px;">
        <label>Name </label><input type="text" name="name"  value="${loginBusinessman.NAME}"><br> 
		</div>
		<div class="inputDiv" style="padding-left: 30px;">
        <label>Phone Number </label><input  type="text" name="phone"  value="${loginBusinessman.PHONE}"><br>
		</div>
		<div class="inputDiv" style="padding-left: 30px;">
        <label>E-Mail </label><input type="text" name="email" value="${loginBusinessman.EMAIL}">
		</div>
	</fieldset><br><br>
	<div id="mypagebtn">
		
		<input type="submit" value="정보수정" class="submit" > 
		<input type="reset" value="취소" class="cancel">
	
	</div>
	</div>
</form>

${message}
</article>

<%@ include file="../../include/business/footer.jsp" %>