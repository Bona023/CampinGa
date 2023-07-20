package com.campinga.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class QnaVO {
	
	private Integer qseq;
	private String mid;
	private Integer bseq;
	@NotEmpty(message="내용을 입력하세요")
	@NotNull(message="내용을 입력하세요")
	private String content;
	private Timestamp indate;
	private String reply;
	private String repyn;
}
