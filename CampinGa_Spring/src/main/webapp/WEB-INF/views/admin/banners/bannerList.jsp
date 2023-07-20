<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article id="mypage" class="adminPage">
	<h1>메인 이미지 관리</h1>
	<form name="frm" method="post">	
		<div id="mypagebtn" style="text-align: right;" onclick="location.href='adminBannerWriteForm'">
     		<input type="button" value="이미지 등록">
    	</div>	
		<table id="bannerList" class="rentList">			
			<tr><th>번호</th><th>제목</th><th>순위</th><th>사용유무</th>
				<th>등록일</th><th>수정</th><th>삭제</th></tr>
		<c:choose>
	    	<c:when test="${bannerList.size()==0}">
	    		<tr><td width="100%" colspan="6" align="center" height="23">등록된 상품이 없습니다.</td></tr>
	    	</c:when>
	    	<c:otherwise>
   			<c:forEach items="${bannerList}" var="bannerVO">
   				<tr>
   					<td height="23" align="center" >${bannerVO.MBSEQ}</td>
   					<td style="text-align:left; padding-left:50px; padding-right:0px;width:300px;">
   						${bannerVO.NAME}
   					</td>
   					<td>
  						<select name="order_seq" id="${bannerVO.MBSEQ}" onChange="orderChange('${bannerVO.MBSEQ}');">
  							<c:forEach var="cnt" begin="1" end="5" varStatus="status">
	  							<c:choose>
									<c:when test="${cnt==bannerVO.ORDER_SEQ}">
										<option value="${cnt}" selected>${cnt}</option>
									</c:when>
									<c:otherwise>
										<option value="${cnt}" >${cnt}</option>
									</c:otherwise>
								</c:choose>
  							</c:forEach>
  							<c:choose>
								<c:when test="${bannerVO.ORDER_SEQ==6}">
									<option value="6" selected>사용안함</option>
								</c:when>
								<c:otherwise>
									<option value="6" >사용안함</option>
								</c:otherwise>
							</c:choose>
  						</select>
   					</td>
   					<td>${bannerVO.USEYN}</td>
   					<td width="150"><fmt:formatDate value="${bannerVO.INDATE}"/></td>
      				<td><input type="button" value="수정" 
      					 onClick="location.href='bannerUpdateForm?mbseq=${bannerVO.MBSEQ}'">
      				</td>
      				<td>
      					<input type="button" value="삭제" onclick="delBanner('${bannerVO.MBSEQ}')">
      				</td>
   				</tr>
   			</c:forEach>
	    	</c:otherwise>
	    </c:choose>
		</table>
	</form>		
</article>
						

<%@ include file="../include/footer.jsp"%>