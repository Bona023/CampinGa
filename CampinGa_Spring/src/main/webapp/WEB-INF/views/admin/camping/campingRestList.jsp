<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub_menu.jsp"%>

<article id="mypage" class="adminPage">
   <h1>객실 예약리스트</h1>
   <form name="frm" method="post"><br><br>
   <table class="adSearch" style="float:right;">
      <tr>
         <td class="searchTd">객실 이름&nbsp;&nbsp;<input type="text" name="key" value="${key}">&nbsp;
         <input class="adpage_btn" type="button" value="검색" onclick="go_search('adminRestList')">
         <input class="adpage_btn" type="button" name="btn_total" value="전체보기" onClick="go_total('adminRestList')">
      </td></tr>
   </table><br>
   <table class="rentList">
      <tr>
         <th>예약 번호</th>
         <th>예약 일자</th>
         <th>캠핑장 이름</th>
         <th>객실 이름</th>
         <th>인원</th>
         <th>체크인</th>
         <th>체크 아웃</th>
         <th>예약자</th>
         <th>금액</th>
      </tr>
      <c:forEach items="${restList}" var="reservationVO">
         <tr>
            <td>${reservationVO.RESEQ}</td>
            <td><fmt:formatDate value="${reservationVO.RES_DATE}" type="both" dateStyle="short" timeStyle="short"/>&nbsp;&nbsp;</td>
            <td>${reservationVO.CNAME}</td>
            <td>${reservationVO.C_CLASS}</td>
            <td>${reservationVO.PEOPLE}</td>
            <td>
                 <fmt:parseDate value = "${reservationVO.CHK_IN}" var = "check_in" pattern = "yy-MM-dd" />
                 <fmt:formatDate type = "date" value="${check_in}"/>
                </td>
                <td>
                 <fmt:parseDate value = "${reservationVO.CHK_OUT}" var = "check_out" pattern = "yy-MM-dd" />
                 <fmt:formatDate type = "date" value="${check_out}"/>
                </td>
            <td>${reservationVO.MID}</td>
            <td>
               <fmt:formatNumber value="${reservationVO.PRICE}" pattern="#,###"/>원
            </td>
         </tr>
      </c:forEach>
   </table>
   </form>
   
   
   <div class="clear"></div>

   <jsp:include page="../paging/paging.jsp">
      <jsp:param name="command" value="adminRestList" />
   </jsp:include>
</article>

<%@ include file="../include/footer.jsp"%>