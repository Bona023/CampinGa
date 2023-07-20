package com.campinga.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class BannerVO {
	
 	private int mbseq;
 	
 	@NotEmpty(message="제목을 작성해주세요.")
	@NotNull(message="제목을 작성해주세요.")
	private String name;
	private int order_seq;
	
	@NotEmpty(message="이미지를 등록해주세요.")
	@NotNull(message="이미지를 등록해주세요.")
	private String image;
	private String useyn;
	private Timestamp indate;

}
