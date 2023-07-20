<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>
<article  id="mypage" class="adminPage">
   <h1>회원목록</h1>  
   <form name="frm" method="post">
   <table class="adSearch" style="float:right;"><br><br>
      <tr><td class="searchTd">회원 이름 <input type="text" name="key" value="${key}">
      <input class="adpage_btn" type="button" value="검색" onclick="go_search('adminMemberList')">
      <input class="adpage_btn" type="button" name="btn_total" value="전체보기 " onClick="go_total('adminMemberList')"></td> </tr>
   </table><br>
   <table class="memberInfoList2">
      <tr>
         <th>아이디</th>
         <th>이름</th>
         <th>전화번호</th>
         <th>이메일</th>
         <th>휴면설정</th>
         <th>삭제</th>
      </tr>
       <c:forEach items="${memberList}" var="memberVO">
          <tr>
             <td>${memberVO.MID}</td>
             <td>${memberVO.NAME}</td>
             <td>${memberVO.MPHONE}</td>
             <td>${memberVO.EMAIL}</td>
             <c:choose>
	             <c:when test="${memberVO.CHKYN=='Y'}">
	             	<td>
	             		<span style="color: blue;">활동계정
	             		<input type="checkbox" name="mid" value="${memberVO.MID}">
	             	</td> 
	             </c:when>
	             <c:otherwise>
	             	<td>
	             		<span style="font-weight: bold; color: red">휴면계정
	             		<input type="checkbox" name="mid" value="${memberVO.MID}">
	             	</td> 
	             </c:otherwise>
             </c:choose>     
             <td>
				<input type="button" value="삭제" >
			 </td>
          </tr>
     </c:forEach>
   </table>
    <div style="float:right;" id="mypagebtn">
     <input type="button" value="휴면회원 설정" onClick="go_members_dormant();">
    </div><br><br><br>
    <div>
   <jsp:include page="../paging/paging.jsp">   
       <jsp:param value="adminMemberList" name="command"/>
   </jsp:include>
   </div>
   </form>
</article>


<%@ include file="../include/footer.jsp"%>