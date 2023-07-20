<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp"%>
<%@ include file="../../include/business/sub_menu.jsp"%>

<div id="roomBox_main">
      <div class="detail_title"><span>객실관리</span></div>
      <c:forEach items="${campingList}" var="campVO">
         <div id="roomBox">
            <div class="room_img">
               <img src="images/campingImage/${campVO.C_IMAGE}" class="img" />
            </div>
            <div class="room_info">
               <div class="room_info-title"><span>${campVO.C_CLASS}</span></div>
               <div class="room_info-text">
                  <div><span>종류</span></div>
                  <div><span>${campVO.CATEGORY}</span></div>
               </div>
               <div class="room_info-text">
                  <div><span>기준인원 ${campVO.MIN_PEOPLE}명/최대인원 ${campVO.MAX_PEOPLE}명</span></div>
                  <div>
                     <span>
                        <fmt:formatNumber value="${campVO.PRICE}" pattern="#,###"/>원
                     </span>
                  </div>
               </div>
               <div class="roomInfo-bar"></div>
               <div class="bmresbtns">            
               <span class="bmresbtn" onclick="location.href='campingRoomUpdateForm?cseq=${campVO.CSEQ}'">수정</span>
               <span class="bmresbtn" onclick="location.href='deleteCampingRoom?cseq=${campVO.CSEQ}'">삭제</span>            
               </div>   
            </div>
         </div>
      </c:forEach>
      <div class="resbtn" onclick="location.href='insertCampingRoomForm'">
         <span style="cursor: pointer;">객실 추가</span>
      </div>   
   </div>




<%@ include file="../../include/business/footer.jsp"%>