package com.campinga.dao;

import java.util.HashMap;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Mapper;

import com.campinga.dto.MemberVO;

@Mapper
public interface IMemberDao {

	void getMemberCam(HashMap<String, Object> paramMap);
	void insertMemberCam(MemberVO membervo);	
	void getMyPageCount(HashMap<String, Object> cntMap);
	void getReservateList(HashMap<String, Object> paramMap);
	void getFavoritesList(HashMap<String, Object> paramMap);
	void updateMember(HashMap<String, Object> paramMap);
	void deleteMember(HashMap<String, Object> paramMap);
	void cancelReservate(HashMap<String, Object> paramMap);
	void deleteMyFavorites(HashMap<String, Object> paramMap);
  void dormantMember(HashMap<String, Object> paramMap);
	void returnMid(HashMap<String, Object> paramMap);
	void confirmMid(HashMap<String, Object> paramMap);
	void updateNewPw(String mid, String newPw);
	


}
