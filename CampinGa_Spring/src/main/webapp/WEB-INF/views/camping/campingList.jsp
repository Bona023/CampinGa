<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article>
	<div class="clear"></div>
	<div id="campSearch">
		<input type="text" id="key" placeholder="캠핑장 이름을 입력해주세요" value="${key}"> 
		<a href="#" onclick="searchCamp()">
		<img id="searchBtn" src="images/main/sBtn.png"></a>
	</div>
	<div class="bar"></div>
	<div id="searchResult">
		<c:forEach items="${campList}" var="campVO">
			<div id="campInfo"
					onclick="location.href='campDetail?bseq=${campVO.BSEQ}'">
				<c:if test="${campVO.IMAGE != null}">
					<img id="campInfo_img" src="images/campingImage/${campVO.IMAGE}">
				</c:if>
				<c:if test="${campVO.IMAGE == null}">
					<img id="campInfo_img" src="images/main/imgfile.png">
				</c:if>
				<div id="campInfo_text">
					<span>${campVO.CNAME}</span><br> 
					<span> 주소 : ${campVO.CADDRESS1} ${campVO.CADDRESS2}</span><br> 
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						${campVO.CADDRESS3}</span><br> 
					<span>카테고리 : ${campVO.CATEGORY}</span><br> 
					<span>부대시설 : ${campVO.FACILITIES}</span>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="clear"></div>
</article>
<%@ include file="../include/footer.jsp"%>