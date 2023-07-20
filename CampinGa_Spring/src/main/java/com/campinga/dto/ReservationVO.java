package com.campinga.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReservationVO {
	
	private Integer reseq;
	private Integer bseq;
	private Integer cseq;
	private String mid;
	private Timestamp res_date;
	private Integer price;
	private Integer people;
	private String chk_in;
	private String chk_out;
	private String cname;
	private String c_class;
	private String res_sta;
	private String bid;

}
