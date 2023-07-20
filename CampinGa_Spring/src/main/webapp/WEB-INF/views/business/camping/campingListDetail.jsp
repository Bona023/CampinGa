<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../include/business/header.jsp" %>
<%@ include file="../../include/business/sub_menu.jsp"%>

<article style="height: 1800px">
   <form name="frmbs" action="BsCampingInfoUpdate" method="post" enctype="multipart/form-data">
      <input type="hidden" name="bseq" value="${businessVO.BSEQ}">
      <input type="hidden" name="oldimg" value="${businessVO.IMAGE}" >
      <div class="roomInsert">
         <div class="roomInsert_title">
            <span>캠핑장 정보 수정</span>
         </div>
         <br>
         <div class="roomInput">
            <span>캠핑장 이름</span>
            <div class="roomInput_div">
               <input type="text" name="cname" size="40" value="${businessVO.CNAME}">
            </div>
         </div>
         <br>
         
         <div class="roomInput">
            <span>현재 캠핑장 사진</span><br>
            <div style="text-align: center; margin-top: 15px;">
               <c:if test="${businessVO.IMAGE != null}">
                  <img src="images/campingImage/${businessVO.IMAGE}" style="width: 300px; height: 200px; border-radius: 10px;">
               </c:if>
               <c:if test="${businessVO.IMAGE == null}">
                  <img src="images/main/imgfile.png" style="width: 300px; height: 200px; border-radius: 10px;">
               </c:if>
            </div>
         </div>
         <br>
         
         <div class="roomInput">
            <span>이미지 파일 선택</span><br>
            <div style="text-align: center; margin-top: 15px;">
               <img id="previewImg" src="images/main/imgfile.png" 
               style="width: 300px; height: 200px; border-radius: 10px;">
            </div>
            <div class="filebox" >
                <input class="upload-name" value="첨부파일" placeholder="첨부파일">
                <label for="file">파일찾기</label> 
                <input type="file" id="file" name="newimg">
            </div>
         </div>
         <br>
         
         <div class="roomInput">
         <span>캠핑장 소개용 이미지 선택</span><br>
	         <div class="filebox" >
	         	<input class="upload-name" name="imagefiles" value="첨부파일" placeholder="첨부파일">
	         	<input type="button" value="이미지 등록" onclick="selectimg();">
	         </div>	
         </div>
         <br>
         
         <div class="roomInput">
            <span>캠핑장 주소</span>
            <div class="roomInput_div">
               <select name="caddress1" id="sido" style="width: 200px" onchange="chDo(this.value)">
               <c:forTokens var="item" varStatus="status" items="서울시,부산시,대구광역시,인천광역시,광주광역시,대전광역시,울산광역시,강원도,경기도,경상남도,경상북도,전라남도,전라북도,제주도,충청남도,충청북도"  delims=",">
                  <c:choose>
                     <c:when test="${item==businessVO.CADDRESS1}">
                        <option value="${status.count}" selected="selected">${item}</option>
                     </c:when>
                     <c:otherwise>
                        <option value="${status.count}">${item}</option>
                     </c:otherwise>
                  </c:choose>
               </c:forTokens>
               </select>
               <select style="width: 200px" name="caddress2" id="gungu">
                  <option>${businessVO.CADDRESS2}</option>
               </select>
            </div>
            <div class="roomInput_div">
               <input type="text" name="caddress3" size="50" value="${businessVO.CADDRESS3}">
            </div>
         </div>
         <br>
         <div class="roomInput">
            <span>캠핑장 소개</span>
            <div class="roomInput_div">
            <textarea name="content">${businessVO.CONTENT}</textarea>
            </div>
         </div>
         <br>
         <div class="roomInput">
            <span>카테고리</span>
            <div class="roomInput_div">
            <select name="category">
               <c:forEach items="${cateMap}" var="cate">
                  <c:choose>
                     <c:when test="${cate==businessVO.CATEGORY}">
                        <option value="${cate}" selected="selected">${cate}</option>
                     </c:when>
                     <c:otherwise>
                        <option value="${cate}">${cate}</option>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </select>
            </div>
         </div>
         <br>
         <div class="roomInput">
            <span>부대시설</span>
            <div class="roomInput_div" style="text-align: left;">
             <c:forTokens var="item" items="공용주차장,공용화장실,편의점/매점,카페" delims=",">
                <c:choose>
                 <c:when test="${fn:contains(businessVO.FACILITIES, item)}">
                    <input checked="checked" type="checkbox" name="facilities" value="${item}"/>&nbsp;${item}&nbsp;&nbsp;&nbsp;
                 </c:when>
                 <c:otherwise>
                    <input type="checkbox" name="facilities" value="${item}"/>&nbsp;${item}&nbsp;&nbsp;&nbsp;
                 </c:otherwise>
              </c:choose>                 
             </c:forTokens> <br>
             <c:forTokens var="item" items="공용샤워실,바베큐장,수영장,개수대" delims=",">
                <c:choose>
                 <c:when test="${fn:contains(businessVO.FACILITIES, item)}">
                    <input checked="checked" type="checkbox" name="facilities" value="${item}"/>&nbsp;${item}&nbsp;&nbsp;&nbsp;
                 </c:when>
                 <c:otherwise>
                    <input type="checkbox" name="facilities" value="${item}"/>&nbsp;${item}&nbsp;&nbsp;&nbsp;
                 </c:otherwise>
              </c:choose>                 
             </c:forTokens>
            </div>
         </div>
            <div class="buttons">
               <input type="submit" value="등록하기">
            </div>
      </div>
   </form>

   
   
</article>

<%@ include file="../../include/business/footer.jsp"%>


