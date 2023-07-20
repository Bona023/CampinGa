<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp"%>
<div id="mainSearch">
	<div id="main_img">		
		<div id="mainImg" style="position:absolute;left:0px;top:0px;text-align:left;">
		<c:forEach items="${bannerList}"  var="bannerVO"><img src="images/banner/${bannerVO.IMAGE}" style="width:1400px;height:750px;"></c:forEach>
		</div>		
	</div>
	<div id="main_searchbar">
		<div id="selects">
			<div id="selectAddress">
				<span>지역별</span> <select id="sido" class="selectAd" onchange="chDo(this.value)">
					<option value="0" selected="selected">도/시 선택</option>
					<option value="1">서울시</option>
					<option value="2">부산시</option>
					<option value="3">대구광역시</option>
					<option value="4">인천광역시</option>
					<option value="5">광주광역시</option>
					<option value="6">대전광역시</option>
					<option value="7">울산광역시</option>
					<option value="8">강원도</option>
					<option value="9">경기도</option>
					<option value="10">경상남도</option>
					<option value="11">경상북도</option>
					<option value="12">전라남도</option>
					<option value="13">전라북도</option>
					<option value="14">제주도</option>
					<option value="15">충청남도</option>
					<option value="16">충청북도</option>
				</select> <select id="gungu" class="selectAd">
					<option value="" selected="selected">시/군/구 선택</option>
				</select>
				
				<!-- 시/군/구 value는 한글 그대로임 -->
			</div>
			<br>
			<div id="searchName">
				<span>캠핑장명</span> <input type="text" id="inputText" name="cname" size="20"> 
				<input type="button" id="mainBtn" value="검색" onclick="mainSearch()">
			</div>
		</div>
	</div>
</div>
<!-- new 캠핑장 -->
<div class="mainTitle">새로 추가된 캠핑장!!</div>
<div class="newCampings">
	<c:forEach items="${newCampList}" var="newCamp">
		<div class="newCampCard">
			<a href="campDetail?bseq=${newCamp.BSEQ}">
				<div class="newCampImgs">
					<c:choose>
						<c:when test="${newCamp.IMAGE==null}">
							<img class="campImg" src="images/main/imgfile.jpg">
						</c:when>
						<c:otherwise>
							<img class="campImg" src="images/campingImage/${newCamp.IMAGE}">
						</c:otherwise>
					</c:choose>
					<div class="imgCover">
						<span>캠핑장정보</span><br> <span>자세히보기</span>
					</div>
				</div>
			</a>
			<div class="newCampName">
				<span>${newCamp.CNAME}</span>
			</div>
			<div class="newCampInfo">
				<span>${newCamp.CONTENT}</span>
			</div>
		</div>
	</c:forEach>
</div>

<!-- 추천 캠핑장 -->
<div id="recoBox">
	<div style="position: relative;" class="mainTitle">이달의 추천 캠핑장!!</div>
	<div class="recoCampings">
		<div class="recoview">
			<!-- recoCampList -->
			<div class="btnA" id="btnL">
				<img src="images/main/arrL.png">
			</div>
			<div class="cardView">
				<div class="cards">
					<c:forEach items="${recoCampList}" var="recoCamp">
						<div class="recoCampCard" 
							onclick="location.href='campDetail?bseq=${recoCamp.BSEQ}'">
							<div class="cardHeader">
								<span>${recoCamp.CNAME}</span>
							</div>
							<div class="recoImg">
								<img src="images/campingImage/${recoCamp.IMAGE}">
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="btnA" id="btnR">
				<img src="images/main/arrR.png">
			</div>
		</div>
	</div>
</div>


<%@ include file="include/footer.jsp"%>
