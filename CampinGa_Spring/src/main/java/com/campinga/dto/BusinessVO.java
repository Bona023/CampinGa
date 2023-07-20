package com.campinga.dto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class BusinessVO {
	 // 사업자 정보
	   private Integer bseq;
	   @NotNull(message="사업자 아이디를 입력하세요")
	   @NotEmpty(message="사업자 아이디를 입력하세요")
	   private String bid;
	   @NotNull (message="비밀번호를 입력하세요")
	   @NotEmpty(message="비밀번호를 입력하세요")
	   private String pwd;
	   @NotNull (message="이름을 입력하세요")
	   @NotEmpty(message="이름을 입력하세요")
	   private String name;
	   @NotNull (message="핸드폰번호를 입력하세요")
	   @NotEmpty(message="핸드폰번호를 입력하세요")
	   private String phone;
	   @NotNull (message="이메일을 입력하세요")
	   @NotEmpty(message="이메일을 입력하세요")
	   private String email;
	   
	   // 캠핑장 정보
	   @NotNull (message="캠핑장 이름을 입력하세요")
	   @NotEmpty(message="캠핑장 이름을 입력하세요")
	   private String cname;
	   @NotNull (message="시/도를 입력하세요")
	   @NotEmpty(message="시/도를 입력하세요")
	   private String caddress1;   // 전체, 특별시, 도
	   @NotNull (message="시/군/구를 입력하세요")
	   @NotEmpty(message="시/군/구를 입력하세요")
	   private String caddress2;   // 시, 군
	   @NotNull (message="상세주소를 입력하세요")
	   @NotEmpty(message="상세주소를 입력하세요")
	   private String caddress3;   // 세부주소
	   private String facilities;
	   @NotNull (message="이미지를 등록하세요")
	   @NotEmpty(message="이미지를 등록하세요")
	   private String image;
	   @NotNull (message="내용을 입력하세요")
	   @NotEmpty(message="내용을 입력하세요")
	   private String content;
	   @NotNull (message="카테고리를 입력하세요")
	   @NotEmpty(message="카테고리를 입력하세요")
	   private String category;
	   private String chkyn;

}
