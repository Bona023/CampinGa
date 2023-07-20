<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/business/header.jsp"%>
<%@ include file="../../include/business/sub_menu.jsp"%>

<article style="height: 1350px;">
	<form method="post" name="campingRoom" enctype="multipart/form-data" action="insertCampingRoom">
		<div class="roomInsert">
			<div class="roomInsert_title">
				<span>객실 등록</span>
			</div>
			<br>
			<div class="roomInput">
				<span>객실 이름</span>
				<div class="roomInput_div">
					<input type="text" name="c_class" size="60" placeholder="캠핑장 이름을 등록하세요.">
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>객실 사진</span><br>
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
				<span>객실 설명</span>
				<div class="roomInput_div">
				<textarea name="c_content"></textarea>
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>객실 가격</span>
				<div class="roomInput_div">
				<input type="text" name="price" size="20" value="0">
				<span>&nbsp;원</span>
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>기준인원</span>
				<div class="roomInput_div"> 
				<input type="text" name="min_people" size="5" value="0">
				<span>&nbsp;명</span>
				</div>
			</div>
			<br>
			<div class="roomInput">
				<span>최대인원</span>
				<div class="roomInput_div">
				<input type="text" name="max_people" size="5" value="0">
				<span>&nbsp;명</span>
				</div>
			</div>
			<br>
			<div class="buttons">
				<input type="submit" value="객실등록" class="button">
			</div>
		</div>
	</form>
</article>

<%@ include file="../../include/business/footer.jsp"%>