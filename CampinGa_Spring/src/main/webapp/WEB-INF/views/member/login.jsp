<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article style="width:600px;height:600px;margin:0 auto;">
    <form method="post" name="loginFrm" id="loginTable">
      <div class="login">
      <h2>로그인</h2>
      <fieldset>
         <legend></legend>
         <div class="login_id">
            <label>User ID</label><input class="memberid" name="mid" type="text"><br> 
         </div>
         <div class="login_pwd">
              <label>Password</label><input name="pwd" type="password"><br>
          </div>    
          <div class="login_radio">
               <input type="radio" name="user" value="1" checked="checked"/>개인 &nbsp; &nbsp; 
               <input type="radio" name="user" value="2"/>사업자
          </div>
      </fieldset>
      <div class="buttons">
           <input type="submit" value="login" class="button" onclick="login();">
           <input type="button" value="join" class="button" 
                  onclick="location.href='contract'"> <br><br>
           <input style="width:174px;" type="button" value="Find ID & PW" class="button"
           	      onclick="location.href='findIdPw'">
       </div><br><br>
       <div>&nbsp;&nbsp;&nbsp;${message}</div>  
   </div>
   </form>
   
</article>


<%@ include file="../include/footer.jsp" %>