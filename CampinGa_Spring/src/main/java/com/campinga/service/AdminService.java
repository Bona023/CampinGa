package com.campinga.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campinga.dao.IAdminDao;
import com.campinga.dto.BannerVO;
import com.campinga.dto.NoticeVO;
import com.campinga.dto.Paging;

@Service
public class AdminService {
	
	@Autowired
	IAdminDao adao;	

	public void getAdminList(HashMap<String, Object> paramMap) {
		adao.getAdminList(paramMap);
	}

	public void adminMemberList(HashMap<String, Object> paramMap) {
		// 회원 리스트 조회
		int page = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page") != null) {
			page = Integer.parseInt(requset.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
	    if(requset.getParameter("key")!=null) {
	       key = requset.getParameter("key");
	       session.setAttribute("key", key);
	    } else if(session.getAttribute("key")!=null){
	       key = (String)session.getAttribute("key");
	    } else {
	       session.removeAttribute("key");
	    }
		
		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 1); 
		cntMap.put("key", key);
		adao.AdminCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paging.paging();
		paramMap.put("key", key);
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		adao.adminMemberList(paramMap);		
	}

	public void adminCampingList(HashMap<String, Object> paramMap) {
		// 캠핑장 리스트 조회
		int page = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page") != null) {
			page = Integer.parseInt(requset.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
	    if(requset.getParameter("key")!=null) {
	       key = requset.getParameter("key");
	       session.setAttribute("key", key);
	    } else if(session.getAttribute("key")!=null){
	       key = (String)session.getAttribute("key");
	    } else {
	       session.removeAttribute("key");
	    }
		
		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 2); 		
		cntMap.put("key", key);
		adao.AdminCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.setDisplayPage(10);
		paging.paging();
		paramMap.put("key", key);
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		adao.adminCampingList(paramMap);		
	}
	
	public void adminRestList(HashMap<String, Object> paramMap) {
      // 예약 리스트 조회
      int page = 1;
      HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
      HttpSession session = requset.getSession();
      if (requset.getParameter("page") != null) {
         page = Integer.parseInt(requset.getParameter("page"));
         session.setAttribute("page", page);
      } else if (session.getAttribute("page") != null) {
         page = (Integer)session.getAttribute("page");
      } else {
         session.removeAttribute("page");
      }
      
      String key = "";
	  if(requset.getParameter("key")!=null) {
	     key = requset.getParameter("key");
	     session.setAttribute("key", key);
	  } else if(session.getAttribute("key")!=null){
	     key = (String)session.getAttribute("key");
	  } else {
	     session.removeAttribute("key");
	  }
      
      Paging paging = new Paging();
      paging.setPage(page);

      HashMap<String, Object> cntMap = new HashMap<String, Object>();
      cntMap.put("key", key);
      cntMap.put("cnt", 0);
      cntMap.put("tableName", 3);       
      adao.AdminCount(cntMap);

      int count = Integer.parseInt(cntMap.get("cnt") + "");
      paging.setTotalCount(count);
      paging.setDisplayPage(10);
	  paging.setDisplayRow(10);
      paging.paging();
      paramMap.put("key", key);
      paramMap.put("startNum", paging.getStartNum());
      paramMap.put("endNum", paging.getEndNum());
      paramMap.put("paging", paging);
      adao.adminRestList(paramMap);      
    }
	

	public void adminReviewList(HashMap<String, Object> paramMap) {
		// 리뷰 리스트 조회
		int page = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page") != null) {
			page = Integer.parseInt(requset.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
		if(requset.getParameter("key")!=null) {
			key = requset.getParameter("key");
		    session.setAttribute("key", key);
		} else if(session.getAttribute("key")!=null){
		    key = (String)session.getAttribute("key");
		} else {
		    session.removeAttribute("key");
		}
		
		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("key", key);
		cntMap.put("cnt", 0);
		cntMap.put("tableName", 4); 		
		adao.AdminCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paging.paging();
		paramMap.put("key", key);
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		adao.adminReviewList(paramMap);			
	}

	public void deleteReview(HashMap<String, Object> paramMap) {

		String [] rseqArr = (String[])paramMap.get("rseqArr");
		
		for(String rseq : rseqArr) {
			paramMap.put("rseq", rseq);
			adao.deleteReview(paramMap);
		}
		
	}

	public void adminNoticeList(HashMap<String, Object> paramMap) {
		// 공지사항 조회
		int page = 1;
		HttpServletRequest requset = (HttpServletRequest) paramMap.get("request");
		HttpSession session = requset.getSession();
		if (requset.getParameter("page") != null) {
			page = Integer.parseInt(requset.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
		if(requset.getParameter("key")!=null) {
			key = requset.getParameter("key");
		    session.setAttribute("key", key);
		} else if(session.getAttribute("key")!=null){
		    key = (String)session.getAttribute("key");
		} else {
		    session.removeAttribute("key");
		}
		
		Paging paging = new Paging();
		paging.setPage(page);

		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("key", key);
		cntMap.put("tableName", 5); 		
		adao.AdminCount(cntMap);

		int count = Integer.parseInt(cntMap.get("cnt") + "");
		paging.setTotalCount(count);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("paging", paging);
		adao.adminNoticeList(paramMap);
	}

	public void selectNoticeOne(HashMap<String, Object> paramMap) {
		adao.selectNoticeOne(paramMap);
	}

	public void adminNoticeUpdate(@Valid NoticeVO noticevo) {
		adao.adminNoticeUpdate(noticevo);		
	}

	public void adminNoticeWrite(NoticeVO noticevo) {
		adao.adminNoticeWrite(noticevo);		
	}

	public void adminNoticeDelete(int nseq) {
		adao.adminNoticeDelete(nseq);		
	}

	public void adminBannerlist(HashMap<String, Object> paramMap) {
		adao.adminBannerlist(paramMap);		
	}

	public void adminBannerWrite(BannerVO bannervo) {
		adao.adminBannerWrite(bannervo);		
	}

	public void bannerOrderUpdate(HashMap<String, Object> paramMap) {
		adao.bannerOrderUpdate(paramMap);		
	}

	public void bannerSelectOne(HashMap<String, Object> paramMap) {
		adao.bannerSelectOne(paramMap);		
	}

	public void adminBannerUpdate(BannerVO bannervo) {
		adao.adminBannerUpdate(bannervo);		
	}

	public void adminBannerDelete(int mbseq) {
		adao.adminBannerDelete(mbseq);		
	}

	public void adminCampingDelete(int bseq) {
		adao.adminCampingDelete(bseq);
	}

	public void adminCampingJoinDormant(HashMap<String, Object> paramMap) {
		adao.adminCampingJoinDormant(paramMap);		
	}

	public void updateMemberDormant(String memberid) {
		adao.updateMemberDormant(memberid);
	}

}
