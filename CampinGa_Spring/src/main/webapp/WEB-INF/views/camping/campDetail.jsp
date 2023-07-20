<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
</style>
<article>
	<!-- 캠핑장 세부설명 -->
	<%@ include file="detail.jsp"%>

	<!-- 캠핑장 객실 정보 -->
	<div id="roomBox_main">
		<div class="detail_title"><span>객실안내/예약</span></div>
		<c:forEach items="${campingList}" var="campVO">
			<div id="roomBox">
				<div class="room_img">
					<img src="images/campingImage/${campVO.C_IMAGE}" class="img" />
				</div>
				<div class="room_info">
					<div class="room_info-title"><span>${campVO.C_CLASS}</span></div>
					<div class="room_info-text">
						<div><span>종류</span></div>
						<div><span>${campVO.CATEGORY}</span></div>
					</div>
					<div class="room_info-text">
						<div><span>기준인원</span></div>
						<div><span>${campVO.MIN_PEOPLE}명/최대인원 ${campVO.MAX_PEOPLE}명</span></div>
					</div>
					<div class="room_info-text">
						<div><span>가격</span></div>
						<div>
		                     <span>
		                        <fmt:formatNumber value="${campVO.PRICE}" pattern="#,###"/>원
		                     </span>
                 		</div>
					</div>
					<div class="roomInfo-bar"></div>					
					<div class="resbtn" onclick="location.href='reserveForm?cseq=${campVO.CSEQ}'">
						<span>예약하기</span>
					</div>				
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="bar2"></div>	
	
	<!-- Q&A -->
	<div class="listBox" id="qnabox" >
		<div class="detail_title"><span>Q & A</span></div>
		<table class="view">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>내용</th>
				<th>답변여부</th>
				<th>수정/삭제</th>
			</tr>
			<c:forEach items="${qnalist}" var="qnaVO">
				<tr class="listOne">
					<td>${qnaVO.QSEQ}</td>
					<td>${qnaVO.MID}</td>
					<td><fmt:formatDate value="${qnaVO.INDATE}" type="date" /></td>
					<td style="padding-left: 25px;">${qnaVO.CONTENT}</td>
					<td><c:choose>
							<c:when test="${qnaVO.REPYN=='y'}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
							<c:otherwise>답변대기중</c:otherwise>
						</c:choose></td>
					<td>
					<div class="btns">		
		
						<c:if test="${qnaVO.MID == loginUser.MID}">					
							<input type="button" value="수정"
								onclick="location.href='campDetail?qseq=${qnaVO.QSEQ}&bseq=${bseq}#qnabox'">
							<input type="button" value="삭제"
								onclick="location.href='deleteQna?qseq=${qnaVO.QSEQ}&bseq=${bseq}#qnabox'">
						</c:if>
				
						</div>
					</td>
				</tr>
				<c:if test="${qnaVO.QSEQ==updateQseq}">
				<tr>
					<td  colspan="3">&nbsp;&nbsp;</td>
					<td id="updateTd" colspan="3">
						<form name="frm1" method="post">
							<input type="hidden" name="qseq" value="${qnaVO.QSEQ}">
							<input type="hidden" name="bseq" value="${bseq}"> 
							<input type="hidden" name="mid" value="${qnaVO.MID}">
							<textarea name="content">${qnaVO.CONTENT}</textarea>
							<input type="submit" value="확인" onclick="QnaCheck('${bseq}');">
						</form>
					</td>
				</tr>
				</c:if>
				<c:if test="${qnaVO.REPYN=='y'}">
				<tr id="replyTr">
					<td colspan="3">↳ 캠핑장 사장님의 답변 &nbsp;&nbsp;: </td>
					<td colspan="3" style="text-align: left;">${qnaVO.REPLY}</td>
				</tr>
				</c:if>
			</c:forEach>
		</table>

		<form name="frm" method="post">
			<input type="hidden" name="bseq" value="${bseq}">
			<div class="writeBox">
				<textarea rows="8" cols="65" name="content"></textarea>
				<div class="btns">
					<input class="submit"  type="submit" value="QnA쓰기" onclick="return qnawriteCheck()">
				</div>
			</div>
		</form>
		<br> <br> <br>
		<div class="paging">
			<c:if test="${paging1.prev}">
				<a href="campDetail?bseq=${bseq}&page1=${paging1.beginPage-1}#qnabox">◀</a>
			</c:if>
			<c:forEach begin="${paging1.beginPage}" end="${paging1.endPage}" var="index">
				<c:choose>
					<c:when test="${index==paging1.page}">
						<span style="color: red;">${index}&nbsp;</span>
					</c:when>
					<c:otherwise>
					  <a href="campDetail?bseq=${bseq}&page1=${index}#qnabox">${index}&nbsp;</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging1.next}">
				<a href="campDetail?bseq=${bseq}&page1=${paging1.endPage+1}#qnabox">▶</a>
			</c:if>
		</div>
	
	</div>

	<div class="bar2"></div>

	<!-- 리뷰 -->
	<div class="listBox" id="reviewbox">
		<div class="detail_title"><span>리뷰</span></div>
		<table class="view">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>내용</th>
				<th>수정/삭제</th>
			</tr>
			<c:forEach items="${reviewList}" var="ReviewVO">
				<tr class="listOne">
					<td>${ReviewVO.RSEQ}</td>
					<td>${ReviewVO.MID}</td>
					<td><fmt:formatDate value="${ReviewVO.INDATE}" /></td>
					<td>&nbsp;&nbsp;&nbsp;${ReviewVO.CONTENT}</td>
					<td><div class="btns">
					<c:if test="${ReviewVO.MID==loginUser.MID}">
							<input type="button" value="수정" class="submit"
								onclick="location.href='campDetail?rseq=${ReviewVO.RSEQ}&bseq=${bseq}#reviewbox'">
							<input type="button" value="삭제" class="submit"
								onclick="location.href='deleteReview?rseq=${ReviewVO.RSEQ}&bseq=${bseq}#reviewbox'">
						</c:if>	</div>
				</tr>

				<c:if test="${ReviewVO.RSEQ==updateRseq}">
					<tr>
						<td colspan="3">&nbsp;&nbsp;</td>
						<td id="updateTd" colspan="2">
							<form name="frm2" method="post">
								<input type="hidden" name="rseq" value="${ReviewVO.RSEQ}">
								<input type="hidden" name="bseq" value="${bseq}"> <input
									type="hidden" name="mid" value="${ReviewVO.MID}">
								<textarea rows="8" cols="65" name="content">${ReviewVO.CONTENT}</textarea>
								<input type="submit" value="확인" onclick="reviewCheck('${bseq}');">
							</form>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<form name="form" method="post" >
			<input type="hidden" name="bseq" value="${bseq}">
			<div class="writeBox">
				<textarea rows="8" cols="65" name="content"></textarea>
				<div class="btns">
					<input type="submit" class="submit" value="리뷰쓰기" onclick="return reviewwriteCheck()">
				</div>
			</div>
		</form>
		<br>
		<br>
		<br>
		<div class="paging">
			<c:if test="${paging2.prev}">
				<a href="campDetail?bseq=${bseq}&page2=${paging2.beginPage-1}#reviewbox">◀</a>
			</c:if>
			<c:forEach begin="${paging2.beginPage}" end="${paging2.endPage}" var="index">
				<c:choose>
					<c:when test="${index==paging2.page}">
						<span style="color: red;">${index}&nbsp;</span>
					</c:when>
					<c:otherwise>
						<a href="campDetail?bseq=${bseq}&page2=${index}#reviewbox">${index}&nbsp;</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging2.next}">
				<a href="campDetail?bseq=${bseq}&page2=${paging2.endPage+1}#reviewbox">▶</a>
			</c:if>
		</div>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>