<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<div class="bar"></div>
<article id="mypage" class="adminPage">
	<h1>공지사항</h1>
	<form name="frm" method="post">		
		<table id="noticeList" class="rentList">
			<tr><th>번호</th><th>제목</th><th>등록일</th></tr>
			<c:forEach items="${noticeList}" var="notice">
				<tr>
					<td align="center">${notice.NSEQ}</td>
					<td style="text-align:left; padding-left:50px;">
						<a href="noticeDetail?nseq=${notice.NSEQ}">${notice.SUBJECT}</a>
					</td>				
					<td><fmt:formatDate value="${notice.INDATE}"/></td>
					<td>	   	 			
	   	 			</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<jsp:include page="../include/paging.jsp">   
	    <jsp:param value="noticeList" name="command"/>
	</jsp:include>

</article>


<%@ include file="../include/footer.jsp"%>