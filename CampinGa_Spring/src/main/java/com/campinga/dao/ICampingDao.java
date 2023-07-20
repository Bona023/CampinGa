package com.campinga.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.campinga.dto.ReservationVO;

@Mapper
public interface ICampingDao {
	
	void categoryAll(HashMap<String, Object> paramMap);
	void categoryList(HashMap<String, Object> paramMap);
	void campNameSerch(HashMap<String, Object> paramMap);
	void campDetailByBseq(HashMap<String, Object> paramMap);
	void getFav(HashMap<String, Object> paramMap);
	void selectCampingList(HashMap<String, Object> paramMap);
	void getCount(HashMap<String, Object> cntMap);
	void selectQnaByBseq(HashMap<String, Object> paramMap);
	void selectReviewByBseq(HashMap<String, Object> paramMap);

	void getBannerList(HashMap<String, Object> paramMap);
	
	void getNewRecoCamping(HashMap<String, Object> paramMap);
	void getSearchResult(HashMap<String, Object> paramMap);
	
	void insertQna(HashMap<String, Object> paramMap);
	void updateQna(HashMap<String, Object> paramMap);
	void deleteQna(HashMap<String, Object> paramMap);
	void insertReview(HashMap<String, Object> paramMap);
	void updateReview(HashMap<String, Object> paramMap);
	void deleteReview(HashMap<String, Object> paramMap);
	void selectCampOne(HashMap<String, Object> paramMap);
	void reserveInsert(ReservationVO resVO);
	
	void insertFavorites(HashMap<String, Object> paramMap);
	void deleteFavorites(HashMap<String, Object> paramMap);
	

}
