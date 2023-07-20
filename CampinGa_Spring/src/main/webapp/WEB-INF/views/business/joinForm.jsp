<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/business/sub_menu.jsp"%>

<article>
   <form method="post" name="joinForm" action="businessJoin"> 
      <div class="joinTable">
         <h1>사업자 신청</h1>
         <div class="inputDiv">
         <label>아이디</label>
            <input type="text" class="joinInput" name="bid" size="20" value="${dto.bid}">
            <input type="button" value="ID중복체크" onclick="Bsidcheck(1);" class="btn">
            <input type="hidden" name="reid">
         </div>   
         <div class="inputDiv">
          <label>사업자 이름</label>
            <input type="text" class="joinInput" name="name" size="20" value="${dto.name}">
         </div>
         <div class="inputDiv">
         <label>캠핑장 이름</label>
            <input type="text" class="joinInput" name="cname" size="20" value="${dto.cname}">
         </div>                        
         <div class="inputDiv">
         <label>비밀번호</label>
            <input type="password" class="joinInput" name="pwd" size="20">
         </div>
         <div class="inputDiv">
         <label>비밀번호 확인</label> <br>
            <input type="password" class="joinInput" name="pwd_check" size="20"></div>
         <div class="inputDiv">
         <label>핸드폰 번호</label>
            <input type="text" class="joinInput" name="phone" size="20" value="${dto.phone}"></div>
         <div class="inputDiv">
          <label>이메일</label>
            <input type="text" class="joinInput" name="email" size="30" value="${dto.email}"></div>
         <div class="inputDiv">
          <label>캠핑장 주소</label><br><br>
             &nbsp;&nbsp;
            <select id="sido" name="caddress1" class="selectAd" onchange="chDo(this.value)" value="${dto.caddress1}">
                <option value="" selected="selected">도/시 선택</option>
                  <option value="1">서울</option>
                  <option value="2">부산</option>
                  <option value="3">대구</option>
                  <option value="4">인천</option>
                  <option value="5">광주</option>
                  <option value="6">대전</option>
                  <option value="7">울산</option>
                  <option value="8">강원</option>
                  <option value="9">경기</option>
                  <option value="10">경남</option>
                  <option value="11">경북</option>
                  <option value="12">전남</option>
                  <option value="13">전북</option>
                  <option value="14">제주</option>
                  <option value="15">충남</option>
                  <option value="16">충북</option>
            </select>
            <select id="gungu" name="caddress2" class="selectAd" value="${dto.caddress2}">
                <option value="" selected="selected">시/군/구 선택</option>
            </select> <br>          
            <input type="text" name="caddress3" placeholder="상세주소를 입력해주세요" value="${dto.caddress3}">
         </div>  
         <div class="buttons">
            <input type="submit" value="가입하기" class="button">
            <input type="button" value="메인으로" onclick="location.href='main'" class="button">
        </div>      
      </div>       
   </form>
</article>
${message}
<%@ include file="../include/footer.jsp"%>

