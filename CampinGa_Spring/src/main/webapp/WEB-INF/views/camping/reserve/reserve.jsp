<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<link href="css/reserve.css" rel="stylesheet">
<script type="text/javascript">
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		showOtherMonths: true,
		yearSuffix: '년',
		minDate: "0D",
		beforeShowDay: disableDates
	});

	$(function() {
		$('#beginDate').datepicker({
			
		});
		$('#endDate').datepicker({
			
		});
	});

	function disableDates(date){
		var dateRange = [];
		var dateString = jQuery.datepicker.formatDate('yy-mm-dd', date);
		<c:forEach var = "reList" items="${reDateList}">
		    var startdate = "${reList.CHK_IN}"
		    var enddate = "${reList.CHK_OUT}";
			
		    console.log(startdate);
		    console.log(enddate);
		    
		    for (var d = new Date(startdate); d <= new Date(enddate); d.setDate(d.getDate() + 1)) {
		        dateRange.push($.datepicker.formatDate('yy-mm-dd', d));
		    }
		</c:forEach>
		    return [dateRange.indexOf(dateString) == -1];
	}
	
	
	function call() {
		var beginDate = document.getElementById("beginDate").value;
		var endDate = document.getElementById("endDate").value;
		var bd = beginDate.split('-');
		var ed = endDate.split('-');
		var bd_date = new Date(bd[0], bd[1], bd[2]);
		var ed_date = new Date(ed[0], ed[1], ed[2]);
		var dif = ed_date - bd_date;
		var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨

		if (beginDate && endDate) {
			const price = parseInt(dif / cDay) * parseInt('${campVO.PRICE}');
			document.getElementById('price').value = price
			document.getElementById('totalPrice').innerHTML = price
					.toLocaleString('ko-KR');
		}
	}

	function to_date(date_str) {
		var bd = date_str.split('-');
		return new Date(bd[0], bd[1], bd[2]);
	}
</script>
<div class="bar"></div>
<article>
   <form method="post" name="reserve" action="reservInsert">
         <input type="hidden" name="mid" value="${loginUser.MID}">
      <!-- 예약자 정보 (예약자, 전화번호, 이메일) -->
      
      <div id="reserveInfo">
      <div id="reserveInfo1">
         <table style="vertical-align:middle;">
            <tr>
            <th colspan="2"><div id="res_table_title">예약자 정보</div></th>            
            </tr>
            <tr>
               <th>예약자 이름</th>
               <td>${loginUser.NAME}</td>
            </tr>
            <tr>
               <th>휴대폰 번호</th>
               <td>${loginUser.MPHONE}</td>
            </tr>
            <tr>
               <th>이메일</th>
               <td>${loginUser.EMAIL}</td>
            </tr>
         </table>
      </div>

      <!-- 캠핑장 정보 (캠핑장이름, 객실정보, 체크인, 체크아웃, 결제금액)-->
      <div id="reserveInfo2">
      	 <input type="hidden" name="cseq" value="${campVO.CSEQ}">
      	 <input type="hidden" name="cname" value="${campVO.CNAME}">
         <input type="hidden" name="c_class" value="${campVO.C_CLASS}">
         <input type="hidden" name="max_people" value="${campVO.MAX_PEOPLE}">
         <input type="hidden" id="price" name="price" value="">
         <table>
            <tr>
               <th>캠핑장 이름</th>
               <td>${campVO.CNAME}</td>
            </tr>
            <tr>
               <th>객실정보</th>
               <td>${campVO.C_CLASS}</td>
            </tr>
            <tr class="chk">
               <th>체크인</th>
               <td><input id="beginDate" name="chk_in" onchange="call()" readonly></td>
            </tr>
            <tr class="chk">
               <th>체크아웃</th>
               <td><input id="endDate" name="chk_out" onchange="call()" readonly></td>
            </tr>
            <tr class="chk2">
               <th>인원<br>[${campVO.MIN_PEOPLE} ~ ${campVO.MAX_PEOPLE}명]</th>
               <td><input type="text" name="people" size="4">명</td>
            </tr>
            <tr>
               <th>결제금액<br>[일 X <fmt:formatNumber value="${campVO.PRICE}" pattern="#,###"/>원]</th>
               <td><span id="totalPrice">0</span>원</td>
            </tr>
         </table>
           <div id="reservebtn" style="margin-top:40px;">
            <input type="button" value="예약하기" onclick="go_reserve();">
            </div>
      </div>
      
      </div>
   </form>
</article>

<%@ include file="../../include/footer.jsp"%>