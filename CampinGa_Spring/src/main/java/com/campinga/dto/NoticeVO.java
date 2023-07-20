package com.campinga.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int nseq;
	private String aid;
	
	@NotNull(message = "제목을 입력해주세요.")
	@NotEmpty(message = "제목을 입력해주세요.")
	private String subject;
	
	@NotNull(message = "내용을 입력해주세요.")
	@NotEmpty(message = "내용을 입력해주세요.")
	private String content;
	private Timestamp indate;

}
