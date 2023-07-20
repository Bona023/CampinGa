<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
function newPwchk(){
	let npw = document.npwFrm.nPw.value;
	let npwChk = document.npwFrm.nPwChk.value;
	if(npw==""){
		alert("새 비밀번호를 입력해주세요")
		document.npwFrm.nPw.focus();
		return;
	}else if(npwChk==""){
		alert("비밀번호 확인을 입력해주세요")
		document.npwFrm.nPwChk.focus();
		return;
	}else if(npw!=npwChk){
		alert("비밀번호 확인과 일치하지 않습니다. 다시 입력해주세요");
		document.npwFrm.nPw.focus();
		return;
	}else{
		document.npwFrm.submit();
	}
}
</script>

<article class="findArticle" style="height:750px;">
<c:if test="${pwkey=='mpw'}">
<h1>회원 비밀번호 새로 설정</h1>
</c:if>
<c:if test="${pwkey=='bpw'}">
<h1>사업자 회원 비밀번호 새로 설정</h1>
</c:if>
<div id="idORpw">
<form name="idFrm" action="confirmPW">
<input type="hidden" name="pwkey" value="${pwkey}">
<div class="idpwText">
<span>ID, Email을 입력해주세요<br>둘 다 필수 입력 입니다.</span>
</div>
<table class="idpwTable">
<tr><th width="100">ID</th>
<td><input type="text" name="id" placeholder="ID 입력"></td>
</tr>
<tr><th>Email</th>
<td><span>가입 시 입력한 메일주소를 입력해주세요.</span>
<input type="text" name="email" placeholder="xxx@xxxxx.xxx"></td>
</tr>
<tr>
<td colspan="2" style="background-color:transparent;">
<input type="submit" value="본인 확인"></td>
</tr>
<c:if test="${findResult=='no'}">
<tr><th>결 과</th><td><span>가입된 내역이 없습니다.</span></td>
</tr>
</c:if>
</table>
</form>
<c:if test="${findResult=='yes'}">
<form name="npwFrm" action="updateNewPw">
	<input type="hidden" name="${mORb}" value="${inputId}">
	<table class="idpwTable" style="height:250px;">
	<tr><th>새 비밀번호</th>
	<td><input type="password" name="nPw"></td>
	<tr><th>새 비밀번호<br>확 인</th>
	<td><input type="password" name="nPwChk"></td>
	</tr>
	<tr>
	<td colspan="2" style="background-color:transparent;">
	<input type="button" value="비밀번호 변경" onclick="newPwchk();"></td>
	</tr>
	</table>
</form>
</c:if>
</div>


</article>

<%@ include file="../include/footer.jsp" %>