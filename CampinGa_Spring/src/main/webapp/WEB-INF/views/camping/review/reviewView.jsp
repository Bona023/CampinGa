<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="ReviewBox" align="center">
	<h2>Review</h2>
	<table id="ReviewList" style="align: center; width: 700px">
		<tr>
			<th>번호</th>
			<th>내용</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>수정/삭제</th>
		</tr>
		<c:forEach items="${reviewList}" var="ReviewVO">
			<tr>
				<td width="8%">${ReviewVO.rseq}</td>
				<td width="40%">${ReviewVO.content}</td>
				<td>${ReviewVO.mid}</td>
				<td><fmt:formatDate value="${ReviewVO.indate}" /></td>

				<td width="20%"><c:if test="${ReviewVO.mid==loginUser.mid}">
						<input type="button" value="수정" class="submit"
							onclick="location.href='camp.do?command=reviewForm&rseq=${ReviewVO.rseq}'">
						<input type="button" value="삭제" class="submit"
							onclick="location.href='camp.do?command=deleteReview&rseq=${ReviewVO.rseq}'">
					</c:if>
			</tr>
			<tr>
				<c:if test="${ReviewVO.rseq==updateRseq}">
					<td colspan="5">
						<form name="frm" method="post">
							<input type="hidden" name="rseq" value="${ReviewVO.rseq}">
							<input type="hidden" name="mid" value="${ReviewVO.mid}">
							<textarea cols="70" rows="10" name="content">${ReviewVO.content}</textarea>
							<input type="submit" value="확인" onclick="reviewCheck();">
						</form>
					</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</div>

<form name="form" method="post" action="camp.do" style="align: center;">
	<input type="hidden" name="command" value="insertReview">
	<fieldset>
		<legend>Review</legend>
		<textarea rows="8" cols="100" name="content"></textarea>
		<div id="buttons" style="float: right">
			<input type="submit" value="리뷰등록">
			<input type="reset" value="취소">
		</div>
	</fieldset>
</form>
