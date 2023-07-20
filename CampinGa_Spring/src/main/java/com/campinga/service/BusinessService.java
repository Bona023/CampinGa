package com.campinga.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campinga.dao.IBusinessDao;
import com.campinga.dto.BusinessVO;
import com.campinga.dto.Paging;
import com.campinga.dto.QnaVO;

@Service
public class BusinessService {

	@Autowired
	IBusinessDao bdao;

	public void getBusinessCam(HashMap<String, Object> paramMap) {
		bdao.getBusinessCam(paramMap);
	}

	public void updateBusiness(HashMap<String, Object> paramMap) {
		bdao.updateBusiness(paramMap);

	}
  
  public void dormantBusiness(HashMap<String, Object> paramMap) {
		 bdao.dormantBusiness(paramMap);
	}

	public void deleteBusiness(HashMap<String, Object> paramMap) {
		bdao.deleteBusiness(paramMap);

	}

	public void getBusinessRestList(HashMap<String, Object> paramMap) {

		HttpServletRequest request = (HttpServletRequest) paramMap.get("request");
		HttpSession session = request.getSession();

		if (request.getParameter("first") != null) {
			session.removeAttribute("page");
		}
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}

		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 1);
		cntMap.put("bseq", paramMap.get("bseq"));

		bdao.BusinessGetAllCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);

		paging.paging();

		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		bdao.getBusinessRestList(paramMap);
		paramMap.put("paging", paging);
	}

	public void getBusinessQnaList(HashMap<String, Object> paramMap) {
		HttpServletRequest request = (HttpServletRequest) paramMap.get("request");
		HttpSession session = request.getSession();

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}

		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 2);
		cntMap.put("bseq", paramMap.get("bseq"));
		bdao.BusinessGetAllCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		bdao.getBusinessQnaList(paramMap);
	}

	public void getQnaOne(HashMap<String, Object> paramMap) {
		bdao.getQnaOne(paramMap);
	}

	public void SaveQnaRep(QnaVO qnavo) {
		bdao.SaveQnaRep(qnavo);
	}

	public void campingRoomList(HashMap<String, Object> paramMap) {

		int page = 1;
		HttpServletRequest request = (HttpServletRequest) paramMap.get("request");
		HttpSession session = request.getSession();

		if (request.getParameter("page") != null && !request.getParameter("page").equals("")) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		paramMap.put("tableName", 3);
		bdao.BusinessGetAllCount(paramMap);
		int count = Integer.parseInt(paramMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		bdao.campingRoomList(paramMap);
	}

	public void deleteCampingRoom(HashMap<String, Object> paramMap) {
	      bdao.deleteCampingRoom(paramMap);
	}

	public void campingRoomOne(HashMap<String, Object> paramMap) {
		bdao.campingRoomOne(paramMap);
	}

	public void insertCampingRoom(HashMap<String, Object> paramMap) {
	      bdao.insertCampingRoom(paramMap);      
	}
	
	public void updateCampingRoom(HashMap<String, Object> paramMap) {
		bdao.updateCampingRoom(paramMap);
	}

	public void insertBusinessCam(BusinessVO businessvo) {
		bdao.insertBusinessCam(businessvo);
	}

	public void BsCampingInfoUpdate(HashMap<String, Object> paramMap) {
		bdao.BsCampingInfoUpdate(paramMap);
	}

	public void returnBid(HashMap<String, Object> paramMap) {
		bdao.returnBid(paramMap);		
	}

	public void confirmBid(HashMap<String, Object> paramMap) {
		bdao.confirmBid(paramMap);		
	}

	public void updateNewPw(String bid, String newPw) {
		bdao.updateNewPw(bid, newPw);		
  }
  





}


