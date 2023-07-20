package com.campinga.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campinga.dao.ICampingDao;
import com.campinga.dto.Paging;
import com.campinga.dto.ReservationVO;

@Service
public class CampingService {

	@Autowired
	ICampingDao cdao;

	public void categoryAll(HashMap<String, Object> paramMap) {
		cdao.categoryAll(paramMap);
	}

	public void categoryList(HashMap<String, Object> paramMap) {
		cdao.categoryList(paramMap);
	}

	public void campNameSerch(HashMap<String, Object> paramMap) {
		cdao.campNameSerch(paramMap);
	}

	public void campDetailByBseq(HashMap<String, Object> paramMap) {
		cdao.campDetailByBseq(paramMap);
	}

	public void getFav(HashMap<String, Object> paramMap) {
		cdao.getFav(paramMap);
	}

	public void selectCampingList(HashMap<String, Object> paramMap) {
		cdao.selectCampingList(paramMap);
	}

	public void selectQnaByBseq(HashMap<String, Object> paramMap) {
		// 캠핑장 QnA 조회
		int page1 = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page1") != null) {
			page1 = Integer.parseInt(requset.getParameter("page1"));
			session.setAttribute("page1", page1);
		} else if (session.getAttribute("page1") != null) {
			page1 = (Integer) session.getAttribute("page1");
		} else {
			session.removeAttribute("page1");
		}

		Paging paging1 = new Paging();
		paging1.setPage(page1);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 1);
		cntMap.put("bseq", Integer.parseInt(paramMap.get("bseq") + ""));
		cdao.getCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging1.setTotalCount(count);
		paging1.paging();
		paramMap.put("startNum1", paging1.getStartNum());
		paramMap.put("endNum1", paging1.getEndNum());
		paramMap.put("paging1", paging1);
		cdao.selectQnaByBseq(paramMap);
	}

	public void selectReviewByBseq(HashMap<String, Object> paramMap) {
		// 캠핑장 review 조회
		int page2 = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page2") != null) {
			page2 = Integer.parseInt(requset.getParameter("page2"));
			session.setAttribute("page2", page2);
		} else if (session.getAttribute("page2") != null) {
			page2 = (Integer) session.getAttribute("page2");
		} else {
			session.removeAttribute("page2");
		}

		Paging paging2 = new Paging();
		paging2.setPage(page2);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 2);
		cntMap.put("bseq", Integer.parseInt(paramMap.get("bseq") + ""));
		cdao.getCount(cntMap);
		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging2.setTotalCount(count);
		paging2.paging();
		paramMap.put("startNum2", paging2.getStartNum());
		paramMap.put("endNum2", paging2.getEndNum());
		paramMap.put("paging2", paging2);
		cdao.selectReviewByBseq(paramMap);
	}

	public void getNewRecoCamping(HashMap<String, Object> paramMap) {
		cdao.getNewRecoCamping(paramMap);
	}

	public void getSearchResult(HashMap<String, Object> paramMap) {
		cdao.getSearchResult(paramMap);
	}

	public void insertQna(HashMap<String, Object> paramMap) {
		cdao.insertQna(paramMap);
	}

	public void updateQna(HashMap<String, Object> paramMap) {
		cdao.updateQna(paramMap);
	}

	public void deleteQna(HashMap<String, Object> paramMap) {
		cdao.deleteQna(paramMap);
	}

	public void insertReview(HashMap<String, Object> paramMap) {
		cdao.insertReview(paramMap);
	}

	public void updateReview(HashMap<String, Object> paramMap) {
		cdao.updateReview(paramMap);
	}

	public void deleteReview(HashMap<String, Object> paramMap) {
		cdao.deleteReview(paramMap);
	}

	public void selectCampOne(HashMap<String, Object> paramMap) {
		cdao.selectCampOne(paramMap);
	}

	public void reserveInsert(ReservationVO resVO) {
		cdao.reserveInsert(resVO);

	}

	public void insertFavorites(HashMap<String, Object> paramMap) {
		cdao.insertFavorites(paramMap);
	}

	public void deleteFavorites(HashMap<String, Object> paramMap) {
		cdao.deleteFavorites(paramMap);
	}

	public void getBannerList(HashMap<String, Object> paramMap) {
		cdao.getBannerList(paramMap);		
	}

}
