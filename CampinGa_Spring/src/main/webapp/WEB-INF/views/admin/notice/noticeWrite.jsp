<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article id="mypage" class="adminPage">
	<h1>공지사항 작성</h1>
	<div class="noticeWrite">
	<form name="frm" method="post" action="adminNoticeWrite">
	<input type="hidden" name="aid" value="${loginAdmin.AID}">
	<div class="writeSubject">		
		<div><span>제 목</span></div>
		<div>
       		<input type="text" name="subject" maxlength="100" value="${noticeVO.subject}"
       			   placeholder="제목을 입력해주세요.">
       	</div>
	</div>
	<div class="writeContent">
   		<div><span>내 용</span></div>
   		<div>
   			<textarea name="content" placeholder="공지사항 내용을 입력해주세요.">${noticeVO.subject}</textarea>
   		</div>			
	</div>
	<div class="writeBtns">
		<input type="submit" value="등록">           
		<input type="button" value="목록" onClick="location.href='adminNoticeList'">
	</div>
	<c:if test="${message!=null}">
	<div style="text-align:center;font-size:130%;font-weight:bold;color:red">
		${message}
		</div>
	</c:if>
	</form>
	</div>
</article>

<%@ include file="../include/footer.jsp"%>