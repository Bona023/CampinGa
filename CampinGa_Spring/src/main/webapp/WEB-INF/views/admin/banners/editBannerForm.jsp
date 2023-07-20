<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>
<script type="text/javascript">
function bannerUpdate(){
	let name = document.frm.name;
	let newimg = document.frm.image;
	let oldimg = document.frm.oldimage;
	if(name.value==""){
		alert("배너 제목을 작성해주세요");
		name.focus();
		return
	}else if(newimg.value==""){
		if(confirm("이전 이미지를 사용합니다.")){
			document.frm.submit();
		}else{
			return;
		}
	}
	document.frm.submit();
}
</script>
<article>
<h1>배너 등록</h1>  
<form name="frm" method="post" action="adminBannerUpdate" style="text-align: center">
	<table class="bannerTable">
		<tr>
			<th width="100px">번호</th>
			<td width="350px" >
				${banner.MBSEQ}<input type="hidden" name="mbseq" size="47" value="${banner.MBSEQ}">
			</td>
			<th width="100px">등록일</th>
			<td width="350px"><fmt:formatDate value="${banner.INDATE}"/></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3" id="banTitle">
				<input type="text" name="name" size="47" value="${banner.NAME}">
			</td>
		</tr>
		<tr><th>순위</th>
			<td>
				<select name="order_seq" style="width:200px">
					<c:forEach var="cnt" begin="1" end="5" varStatus="status">
				    	<c:choose>
							<c:when test="${cnt==banner.ORDER_SEQ}">
								<option value="${cnt}" selected>${cnt}</option>
							</c:when>
							<c:otherwise>
								<option value="${cnt}" >${cnt}</option>
							</c:otherwise>
						</c:choose>
				    </c:forEach>
				    <c:choose>
						<c:when test="${banner.ORDER_SEQ==6}">
							<option value="6" selected>사용안함</option>
						</c:when>
						<c:otherwise>
							<option value="6" >사용안함</option>
						</c:otherwise>
						</c:choose>
			    	</select>
			</td>
			<th>사용유무</th><td>${banner.USEYN}</td>
		</tr>
		<tr>
			<th height="350px">이전 이미지</th>
	    	<td style="vertical-align:top;">
	   			<input type="hidden" name="oldimage" value="${banner.IMAGE}">
	   			<img src="images/banner/${banner.IMAGE}" height="200px" style="margin-top: 20px;">
	   			<div style="margin-top: 10px;">${banner.IMAGE}</div>
	   		</td>
	   		<th>새 이미지</th>
	    	<td style="vertical-align:top;">
	   			<input type="hidden" name="image" id="image" value="">
	   			<div id="filename" style="margin:15px 0;"></div>
	   		</td>
	   	</tr>
	</table>
	<input class="banBtn" type="button" value="등록" onClick="bannerUpdate()" style="margin-right: 30px;">  
	<input class="banBtn" type="button" value="취소" onClick="location.href='adminBannerList'" style="margin-right: 30px;">
	<input class="banBtn" type="button" value="삭제" onclick="delBanner('${banner.MBSEQ}')"> 
	</form>
	
	<div style="position:relative; top:-120px;  width: 300px; float: right;">
	<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
		<input type="file" name="fileimage"><br>
		<input type="button" id="fileAddBtn" value="이미지 업로드">
	</form>
	</div>
	
</article>
<%@ include file="../include/footer.jsp" %>