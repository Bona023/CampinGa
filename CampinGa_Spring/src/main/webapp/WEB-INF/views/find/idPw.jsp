<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article class="findArticle">

<div id="idORpw">

<div class="findTitle"><span>아이디 찾기</span></div>
<a href="findID?idkey=mid&pwkey=mpw">
<div class="findBtn"><span>일반 회원</span></div></a>
<a href="findID?idkey=bid&pwkey=bpw">
<div class="findBtn"><span>사업자 회원</span></div></a>

<div class="findTitle"><span>비밀번호 찾기</span></div>
<a href="findPW?idkey=mid&pwkey=mpw">
<div class="findBtn"><span>일반 회원</span></div></a>
<a href="findPW?idkey=bid&pwkey=bpw">
<div class="findBtn"><span>사업자 회원</span></div></a>

</div>

</article>

<%@ include file="../include/footer.jsp" %>