package com.campinga.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.campinga.dto.BannerVO;
import com.campinga.dto.NoticeVO;

@Mapper
public interface IAdminDao {

	void getAdminList(HashMap<String, Object> paramMap);

	void AdminCount(HashMap<String, Object> cntMap);
	void adminMemberList(HashMap<String, Object> paramMap);

	void adminCampingList(HashMap<String, Object> paramMap);
	void adminCampingJoinDormant(HashMap<String, Object> paramMap);
	void adminCampingDelete(int bseq);
	
	void adminRestList(HashMap<String, Object> paramMap);
	
	void adminReviewList(HashMap<String, Object> paramMap);
	void deleteReview(HashMap<String, Object> paramMap);

	void adminNoticeList(HashMap<String, Object> paramMap);
	void selectNoticeOne(HashMap<String, Object> paramMap);
	void adminNoticeUpdate(NoticeVO noticevo);
	void adminNoticeWrite(NoticeVO noticevo);
	void adminNoticeDelete(int nseq);

	void adminBannerlist(HashMap<String, Object> paramMap);
	void adminBannerWrite(BannerVO bannervo);
	void adminBannerUpdate(BannerVO bannervo);
	void adminBannerDelete(int mbseq);
	void bannerOrderUpdate(HashMap<String, Object> paramMap);
	void bannerSelectOne(HashMap<String, Object> paramMap);

	void updateMemberDormant(String memberid);

	

	
}
