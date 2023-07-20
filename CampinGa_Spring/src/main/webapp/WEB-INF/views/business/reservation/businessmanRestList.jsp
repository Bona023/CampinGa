<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp" %>
<%@ include file="../../include/business/sub_menu.jsp"%>
<article id="mypage" class="adminPage">
<div class="detail_title"><span>캠핑장 예약 조회</span></div>
   <form method="post" name="reservateInfo">      
      <table class="rentList">
         <tr>
            <th>예약일자</th>
            <th>예약자</th>
            <th>전화번호</th>
            <th>예약장소</th>
            <th>인원</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>금액</th>
         </tr>
         <c:forEach items="${reList}" var="resVO">
            <tr>
               <td><fmt:formatDate value="${resVO.RES_DATE}" type="both" 
                     dateStyle="short" timeStyle="short"/></td>
               <td>${resVO.NAME}</td>
               <td>${resVO.MPHONE}</td>
               <td>${resVO.CNAME}&nbsp;${resVO.C_CLASS}</td>
               <td>${resVO.PEOPLE}명</td>
               <td>
            	  <fmt:parseDate value = "${resVO.CHK_IN}" var = "check_in" pattern = "yy-MM-dd" />
            	  <fmt:formatDate type = "date" value="${check_in}"/>
                </td>
                <td>
            	  <fmt:parseDate value = "${resVO.CHK_OUT}" var = "check_out" pattern = "yy-MM-dd" />
            	  <fmt:formatDate type = "date" value="${check_out}"/>
                </td>
               	<td>
                   <fmt:formatNumber value="${resVO.PRICE}" pattern="#,###"/>원
                </td>
            </tr>
         </c:forEach>
      </table>
   </form>
   
   <jsp:include page="../../include/paging.jsp">   
       <jsp:param name="command" value="businessmanRestList" />
   </jsp:include>
	
</article>
<%@ include file="../../include/business/footer.jsp"%>