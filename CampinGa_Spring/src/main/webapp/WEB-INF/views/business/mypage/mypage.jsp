<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp" %>
<%@ include file="../../include/business/sub_menu.jsp"%>


<article id="mypage">
   <!-- 회원 간단한 정보 + 정보수정 버튼-->
   <div class="detail_title"><span>사업자 정보</span></div>
   <form method="post" name="memberInfo">      
      <table class="memberInfoList1">
         <tr>
            <th>이름</th>
            <td>${loginBusinessman.NAME}</td>
         </tr>
         <tr>
            <th>아이디</th>
            <td>${loginBusinessman.BID}</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td>${loginBusinessman.EMAIL}</td>
         </tr>
         <tr>
            <th>전화번호</th>
            <td>${loginBusinessman.PHONE}</td>
         </tr>
         <tr>
			<td colspan="2" id="mypagebtn"  height="80" style="line-height: 80px">
				<input type="button" value="정보수정"
						onclick="location.href='businessmanEditForm'">			
				<input type="button" value="회원탈퇴"
						onclick="location.href='deleteBusinessman'">
			</td>
		</tr>
      </table>
   </form>


   

   
</article>
<%@ include file="../../include/business/footer.jsp"%>