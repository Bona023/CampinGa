<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>

<article>
<form method="post" action="updateUserInfo">
    <div class="joinTable">
    <h2>사용자 정보 수정</h2><br>
   <fieldset>
      <div class="inputDiv">
      <label>아이디</label><input type="text" name="mid" value="${loginUser.MID}" readonly><br>
      </div>
      <div class="inputDiv">
        <label>이름</label><input type="text" name="name"  value="${loginUser.NAME}"><br> 
        </div>
        <div class="inputDiv">  
        <label>전화번호</label><input  type="text" name="mphone"  value="${loginUser.MPHONE}"><br>
        </div>
        <div class="inputDiv">
        <label>이메일</label><input type="text" name="email" value="${loginUser.EMAIL}">
      </div>   
  </fieldset><div class="clear"></div>
	<div id="buttons">
		<input type="submit" value="정보수정" class="submit" > 
		<input type="reset" value="취소" class="cancel">
	</div>
   
   </div>
</form>
${message}
</article>

<%@ include file="../../include/footer.jsp" %>