<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article id="mypage" class="adminPage">
	<h1>캠핑장 정보</h1>
	<form name="frm" method="post">
	   <table class="adSearch" style="float:right; width:500px;"><br>
      <tr><td class="searchTd">캠핑장 이름 <input type="text" name="key" value="${key}">
      <input class="adpage_btn" type="button" value="검색" onclick="go_search('adminCampingList')">
      <input class="adpage_btn" type="button" name="btn_total" value="전체보기 " onClick="go_total('adminCampingList')"></td> </tr>
   </table><br>

		<table class="rentList">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주소</th>
				<th>연락처</th>
				<th>가입승인</th>
				<th>계정삭제</th>
			</tr>
			<c:forEach items="${campingList}" var="camp">
				<tr>
					<td height="2" align="center">${camp.BSEQ}</td>
					<td height="2" align="center">${camp.CNAME}</td>
					<td height="2" align="center">
						${camp.CADDRESS1}&nbsp;${camp.CADDRESS2}<br> 
						${camp.CADDRESS3}</td>
					<td height="2" align="center">${camp.PHONE}</td>
					<td>
						<c:choose>
                     		<c:when test="${camp.CHKYN=='Y'}">
                        		<input type="checkbox" name="onOff" checked="checked" 
                              			onchange="joinDormant('${camp.BSEQ}','N')">
                     		</c:when>
                     		<c:otherwise>
                        		<input type="checkbox" name="onOff" onchange="joinDormant('${camp.BSEQ}','Y')">
                    		</c:otherwise>
                 		</c:choose>  								
					</td>
					<td>
						<input type="button" value="삭제" onclick="businessDel('${camp.BSEQ}')">
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>

	<div class="clear"></div>

	<jsp:include page="../paging/paging.jsp">
		<jsp:param name="command" value="adminCampingList" />
	</jsp:include>

</article>

<%@ include file="../include/footer.jsp"%>