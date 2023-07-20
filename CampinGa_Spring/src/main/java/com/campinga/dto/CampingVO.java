package com.campinga.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CampingVO {
	
	private Integer cseq;
	private Integer bseq;
	private String cname;
	private String c_image;
	private String c_content;
	private String c_class;
	private String res_sta;
	private Integer price;
	private Integer min_people;
	private Integer max_people;
	private Timestamp c_indate;
	private String caddress1;
	private String caddress2;
	private String caddress3;
	private String phone;	
	private String Category;
	private String Facilities;
	private String Image;

}
