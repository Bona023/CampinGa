<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp"%>
<%@ include file="../../include/business/sub_menu.jsp"%>
<article id="mypage" class="adminPage">
	<h1>Q&amp;A</h1>
	<form name="frm" method="post" >
		<input type="hidden" name="qseq" value="${qnaVO.QSEQ}">
		<input type="hidden" name="bseq" value="${qnaVO.BSEQ}">
		<table id="reviewList">
			<tr>
				<th width="170">등록일</th><th>내용</th>				
			</tr>
			<tr>
				<td><fmt:formatDate value="${qnaVO.INDATE}" /></td>
				<td align="left" style="padding-left: 30px">${qnaVO.CONTENT}</td>
			</tr>
		</table>
		<!-- 관리자가 쓴 답글 또는 답글 쓰는 입력란 표시 -->
		<c:choose>
			<c:when test='${qnaVO.REPYN=="n"}'>					
				<div class="writeBox">
					<textarea name="reply" rows="3" cols="50"></textarea>
					<div class="btns">
						<input type="button" class="submit" value="저장" 
							   onClick="bsRepSave()">
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<table id="replyTable">
					<tr>
						<th width="180">↳ 사장님의 답변 :</th>
						<td>${qnaVO.REPLY}</td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>
		<div id="mypagebtn" style="width: 1000px">
		<input type="button" class="btn" value="목록" style="float: right;"
			onClick="location.href='businessmanQnaList'">
		</div>
	</form>
</article>

<%@ include file="../../include/business/footer.jsp"%>