<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp"%>
<%@ include file="../../include/business/sub_menu.jsp"%>

<article style="height: 1400px">
	<form method="post" name="campingRoom" action="updateCampingRoom" enctype="multipart/form-data">
		<input type="hidden" name="cseq" value="${campVO.CSEQ}">
		<input type="hidden" name="oldc_image" value="${campVO.C_IMAGE}">			
		<div class="roomInsert">
			<div class="roomInsert_title">
				<span>객실 수정</span>
			</div>
			<br>
			<div class="roomInput">
				<span>객실 이름</span>
				<div class="roomInput_div">
					<input type="text" name="c_class" size="20" value="${campVO.C_CLASS}">
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>현재 객실 사진</span><br>
				<div style="text-align: center; margin-top: 15px;">
					<img src="images/campingImage/${campVO.C_IMAGE}" 
					style="width: 300px; height: 200px; border-radius: 10px;">
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>이미지 파일 선택</span><br>
				<div style="text-align: center; margin-top: 15px;">
					<img id="previewImg" src="images/main/imgfile.png" 
					style="width: 300px; height: 200px; border-radius: 10px;">
				</div>
				<div class="filebox">
				    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
				    <label for="file">파일찾기</label> 
				    <input type="file" id="file" name="c_image">
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>객실 가격</span>
				<div class="roomInput_div">
				<input type="text" name="price" size="20" value="${campVO.PRICE}">
				<span>&nbsp;원</span>
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>기준인원</span>
				<div class="roomInput_div"> 
				<input type="text" name="min_people" size="5" value="${campVO.MIN_PEOPLE}">
				<span>&nbsp;명</span>
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>최대인원</span>
				<div class="roomInput_div">
				<input type="text" name="max_people" size="5" value="${campVO.MAX_PEOPLE}">
				<span>&nbsp;명</span>
				</div>
			</div>			
			<br>
			<div class="buttons">
				<input type="submit" value="객실수정" class="button">
			</div>
		</div>
	</form>
</article>

<%@ include file="../../include/business/footer.jsp"%>