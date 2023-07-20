<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article id="mypage" class="adminPage">
	<h1>공지사항</h1>
	<form name="frm" method="post">	
		<div id="mypagebtn" style="text-align: right;" onclick="location.href='adminNoticeWriteForm'">
     		<input type="button" value="글쓰기">
    	</div>	
		<table id="noticeList" class="rentList">			
			<tr><th>번호</th><th>제목</th><th>등록일</th><th>삭제</th></tr>
			<c:forEach items="${noticeList}" var="notice">
				<tr>
					<td align="center">${notice.NSEQ}</td>
					<td style="text-align:left; padding-left:50px;">
						<a href="adminNoticeDetail?nseq=${notice.NSEQ}">
							${notice.SUBJECT}</a>
					</td>				
					<td><fmt:formatDate value="${notice.INDATE}"/></td>
					<td>
					<c:if test="${loginAdmin!=null}">
					<input type="button" value="삭제" onclick="notiecDeleteChk('${notice.NSEQ}')">
					</c:if>					
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>	
	<jsp:include page="../paging/paging.jsp">   
	    <jsp:param value="adminNoticeList" name="command"/>
	</jsp:include>
	
</article>
						

<%@ include file="../include/footer.jsp"%>