<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp"%>
<%@ include file="../../include/business/sub_menu.jsp"%>
<article id="mypage" class="adminPage">
  <div class="detail_title"><span>Q&amp;A</span></div>
  <table id="reviewList">
		<tr>
			<th>번호(답변여부)</th>
			<th>내용</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>

		<c:forEach items="${qnalist}" var="camp_qnaVO">
			<input type="hidden" name="bseq" value="${loginBusinessman.BSEQ}">
			<tr>
				<td>${camp_qnaVO.QSEQ}<c:choose>
						<c:when test='${camp_qnaVO.REPYN=="n"}'>(미처리)</c:when>
						<c:otherwise>(답변처리완료)</c:otherwise>
					</c:choose></td>
				<td><a href="businessmanQnaView?qseq=${camp_qnaVO.QSEQ}">${camp_qnaVO.CONTENT}</a></td>
				<td>${camp_qnaVO.MID}</td>
				<td><fmt:formatDate value="${camp_qnaVO.INDATE}" /></td>
			</tr>		
		</c:forEach>
	</table>
	<br>

<jsp:include page="../../include/paging.jsp">
	<jsp:param name="command" value="businessmanQnaList" />
</jsp:include>

</article>

<%@ include file="../../include/business/footer.jsp"%>