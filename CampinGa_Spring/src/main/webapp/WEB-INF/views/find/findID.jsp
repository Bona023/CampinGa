<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article class="findArticle">
<c:if test="${idkey=='mid'}">
<h1>회원 ID 찾기</h1>
</c:if>
<c:if test="${idkey=='bid'}">
<h1>사업자 회원 ID 찾기</h1>
</c:if>
<div id="idORpw">
<form name="idFrm" action="returnID">
<input type="hidden" name="idkey" value="${idkey}">
<input type="hidden" name="pwkey" value="${pwkey}"> 
<div class="idpwText">
<span>이름, 전화번호를 입력해주세요<br>둘 다 필수 입력 입니다.</span>
</div>
<table class="idpwTable">
<tr><th width="100">이 름</th>
<td><input type="text" name="name" placeholder="이름 입력"></td>
</tr>
<tr><th>전화번호</th>
<td><span>예시처럼 입력해주세요(예: 010-1234-1234)</span>
<input type="text" name="phone" placeholder="010-0000-0000"></td>
</tr>
<tr>
<td colspan="2" style="background-color:transparent;">
<input type="submit" value="ID 찾기"></td>
</tr>
<c:if test="${findResult!=null}">
<tr><th>결 과</th><td>${findResult}</td>
</tr>
</c:if>
</table>
</form>
<a href="loginForm">
<div class="findBtn"><span>로그인하기</span></div></a>
<a href="findPW?idkey=${idkey}&pwkey=${pwkey}">
<div class="findBtn"><span>비밀번호 찾기</span></div></a>
</div>

</article>

<%@ include file="../include/footer.jsp" %>