package com.campinga.dao;

import java.util.HashMap;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Mapper;

import com.campinga.dto.BusinessVO;
import com.campinga.dto.QnaVO;

@Mapper
public interface IBusinessDao {

	void getBusinessCam(HashMap<String, Object> paramMap);
	void insertBusinessCam(@Valid BusinessVO businessvo);
	void updateBusiness(HashMap<String, Object> paramMap);
	void deleteBusiness(HashMap<String, Object> paramMap);
	void BusinessGetAllCount(HashMap<String, Object> cntMap);
	
    void getBusinessRestList(HashMap<String, Object> paramMap);

	void getBusinessQnaList(HashMap<String, Object> paramMap);
	void getQnaOne(HashMap<String, Object> paramMap);
	void SaveQnaRep(QnaVO qnavo);

	void campingRoomList(HashMap<String, Object> paramMap);
	void campingRoomOne(HashMap<String, Object> paramMap);
	void insertCampingRoom(HashMap<String, Object> paramMap);
	void deleteCampingRoom(HashMap<String, Object> paramMap);
	void updateCampingRoom(HashMap<String, Object> paramMap);
	
	void BsCampingInfoUpdate(HashMap<String, Object> paramMap);
	void dormantBusiness(HashMap<String, Object> paramMap);
	
	void returnBid(HashMap<String, Object> paramMap);
	void confirmBid(HashMap<String, Object> paramMap);
	void updateNewPw(String bid, String newPw);
	
	
	

}
