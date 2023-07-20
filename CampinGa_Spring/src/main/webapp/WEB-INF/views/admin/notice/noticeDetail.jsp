<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article>
<div id="noticeview">
   <div class="noticeTitle">
		<h1>공지사항</h1>
	</div> 
	<div class="noticeOne">
		<div class="noticeOne_title">
		 <div><span>제목</span></div>
		 <div><span>${noticeVO.SUBJECT}</span></div>
		</div>
		<div class="noticeOne_content">
			<pre>${noticeVO.CONTENT}</pre>
		</div>   
	</div>
    <div class="buttons" style="height: 80px; line-height: 80px;">
    	<input class="btn"  type="button" value="수정" 
    	       onClick="location.href='adminNoticeUpdateForm?nseq=${noticeVO.NSEQ}'">
		<input class="btn"  type="button" value="삭제" 
			   onClick="notiecDeleteChk('${noticeVO.NSEQ}')">
		<input class="btn"  type="button" value="목록" 
			   onClick="location.href='adminNoticeList'">    	
    </div>   
   <div class="buttons">   
</div>
</article>

<%@ include file="../include/footer.jsp"%>