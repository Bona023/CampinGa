<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../admin/include/header.jsp" %>

<div id="wrap">

   <article>
      <div class="login">
       <h2>관리자 로그인</h2>
         <form name="frm" method="post" action="adminLogin">            
               <div class="login_id">
               <label>아 이 디</label><input type="text" name="adminId" size="10">
               </div>
               <div class="login_pwd">
               <label>비밀번호</label><input type="password" name="adminPwd" size="10">
               </div><br>
               <div class="buttons">
                     <input class="button" type="submit" value="로그인" onClick="adminCheck();">
               </div>      
                     <br><br><h4 style="color:red">${message}</h4>
            
         </form>
      </div>
   </article>
</div>


<%@ include file="../admin/include/footer.jsp" %>
