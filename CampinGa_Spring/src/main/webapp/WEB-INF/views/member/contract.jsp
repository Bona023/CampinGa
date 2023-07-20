<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<article>
	<div class="contract">
		<h2>회원 가입 약관</h2>
		<form id="join" method="post" name="contractFrm" action="joinForm">
			<input type="hidden" name="user" value=""> <br>
			<div class="btns">
				<input type="button" value="일반 회원" onclick="joinChoose(1)">
				<input type="button" value="사업자 회원" onclick="joinChoose(2)">
			</div>				
			<div class="conView">
			<span id="contract" style="color:black;">
				가입유형을 선택해주세요</span>			
			</div>
			<div class="btns">
				<input type="radio" name="okon"> 동의함&nbsp;&nbsp;&nbsp; 
				<input type="radio" name="okon" checked="checked"> 동의안함&nbsp;&nbsp;&nbsp;
				<input type="button" value="Next" class="submit"  onclick="go_next();" class="btn">
			</div>			
		</form>
	</div>
</article>

<%@ include file="../include/footer.jsp"%>