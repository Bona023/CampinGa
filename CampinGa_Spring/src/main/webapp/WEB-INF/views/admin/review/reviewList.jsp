<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>
<article id="mypage" class="adminPage">
	<h1>리뷰 목록</h1>  
	<form name="frm" method="post">
	<table class="adSearch" style="float:right;">
		<tr><td class="searchTd">내용 검색 
			<input type="text" name="key" value="${key1}">
			<input class="adpage_btn" type="button" value="검색" onclick="go_search('adminReviewList')">
			<input class="adpage_btn" type="button" name="btn_total" value="전체보기" onClick="go_total('adminReviewList')">
		</td></tr>
	</table><br>
	<table id="reviewList">
		<tr>
			<th width="80">번호</th>
			<th>내용</th>
			<th>아이디</th>
			<th>작성일</th>
			<th>삭제</th>
		</tr>
	    <c:forEach items="${reviewList}" var="reviewVO">
		    <tr>
		    	<td>${reviewVO.RSEQ}</td>
		    	<td>${reviewVO.CONTENT}</td>
		    	<td>${reviewVO.MID}</td>
		    	<td><fmt:formatDate value="${reviewVO.INDATE}"/></td>
		    	<td><input type="checkbox" name="rseq" value="${reviewVO.RSEQ}"></td>
		    </tr>
	  </c:forEach>
	  <tr>
     <th colspan="5"><a href="#" onClick="go_review_delete();">리뷰 삭제하기</a></th>
	  </tr>
	</table>
	<jsp:include page="../paging/paging.jsp">   
	    <jsp:param value="adminReviewList" name="command"/>
	</jsp:include>
	</form>
</article>


<%@ include file="../include/footer.jsp"%>