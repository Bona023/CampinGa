<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	// 캠핑장 상세 페이지 : 캠핑장 이미지 롤링
	let imgArr = '${campMain.CAMPIMAGES}';
	let imgsNum = imgArr.split(",").length-2;
	let orders = 0;
	$('#leftBtn').click(function() {
		if (orders == 0) return;
		orders--;
		dist = -1 * 800 * orders;
		$('#campImgs').animate({ left: dist }, 500)
	})
	$('#RightBtn').click(function() {
		if (orders == imgsNum) return;
		orders++;
		dist = -1 * 800 * orders;
		$('#campImgs').animate({ left: dist }, 500)
	})
})
</script>

<div class="bar"></div>
<div id="campingdetail">
	<div id="campMain">
		<div id="campMain_img">
			<c:if test="${campMain.IMAGE != null}">
				<img id="campInfo_img" src="images/campingImage/${campMain.IMAGE}">
			</c:if>
			<c:if test="${campMain.IMAGE == null}">
				<img id="campInfo_img" src="images/main/imgfile.png">
			</c:if>
		</div>
		<div id="campMain_info">
			<div id="campMain_info-title">
				<h2>${campMain.CNAME}</h2>
			</div>
			<label>주소 : </label><span>${campMain.CADDRESS1}&nbsp;${campMain.CADDRESS2}&nbsp;${campMain.CADDRESS3}</span><br>
			<br><label>문의처 : </label><span>${campMain.PHONE}</span><br>
			<br><label>캠핑장 유형 : </label><span>${campMain.CATEGORY}</span><br>
			<br><label>운영기간 : </label><span>봄, 여름, 가을, 겨울</span><br>
			<br><label>운영일 : </label><span>평일+주말</span><br>
			<br><label>부대시설 : </label><span>${campMain.FACILITIES}</span><br>
			<br>
			<div id="campMain_info-btns">			
			<c:if test="${loginUser!=null}">
				<c:choose>
					<c:when test="${chk_fav == 'Y'}">
					<input type="button" value="♥&nbsp;&nbsp;Delete" class="favDel" 
						onclick="location.href='deleteFavorites?bseq=${bseq}'">
					</c:when>
					<c:otherwise>
						<input type="button" value="♡&nbsp;&nbsp;Like" class="favAdd"
							onclick="location.href='addFavorites?bseq=${bseq}'">
					</c:otherwise>
				</c:choose>
			</c:if>	

			</div>
		</div>
	</div>
</div>
<div id="campDetail">
	<div class="detail_title"><span>캠핑장 소개</span></div>
	
	<div id="campDetail_imgs">
		<div id="leftBtn">
			<img src="images/main/arrL.png"">
		</div>	
		<div id="campImgs" style="width:8000px">
			<c:set var="campimgs" value="${fn:split(campMain.CAMPIMAGES,',')}"/>
			<!-- ${fn:length(campimgs)} -->
			<c:forEach var="images" items="${campimgs}"><img id="camImg" src="images/campingImage/${images}" class="campDetail_img" width=800 height=400/></c:forEach>
		</div>	
		<div id="RightBtn">
			<img src="images/main/arrR.png"">
		</div>
	</div>
	
	<div class="detail_text">
		<h3>${campMain.CONTENT}</h3>
	</div>
</div>

<div id="campDetail">	
	<div class="detail_title"><span>캠핑장 위치</span></div>
	<div id="map"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95c93542ef2c88b25c3bc53b19fb9bd8&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	var address = '${campMain.CADDRESS1}'+' '+'${campMain.CADDRESS2}'+' '+'${campMain.CADDRESS3}'
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	        var str = '<div style="width:200px;text-align:center;padding:6px 0;">'+'${campMain.CNAME}'+'</div>'
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: str
	        });
	        infowindow.open(map, marker);
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>
</div>
