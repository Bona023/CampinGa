package com.campinga.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.campinga.dao.IMemberDao;
import com.campinga.dto.MemberVO;
import com.campinga.dto.Paging;

@Service
public class MemberService {
	
	@Autowired
	IMemberDao mdao;

	public void getMemberCam(HashMap<String, Object> paramMap) {
		mdao.getMemberCam(paramMap);
		
	}

	public void insertMemberCam(MemberVO membervo) {
		mdao.insertMemberCam(membervo);
	}
	
	public void getReservateList(HashMap<String, Object> paramMap) {
		int page1 = 1;
		HttpServletRequest requset = (HttpServletRequest)paramMap.get("request");
		HttpSession session = requset.getSession();
		if(requset.getParameter("page1")!=null) {
			page1 = Integer.parseInt(requset.getParameter("page1"));
			session.setAttribute("page1", page1);
		} else if(session.getAttribute("page1")!=null){
			page1 = (Integer)session.getAttribute("page1");
		} else {
			session.removeAttribute("page1");
		}
		
		Paging paging1 = new Paging();
		paging1.setPage(page1);
		
		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("mid", paramMap.get("mid"));
		cntMap.put("tableName", 1);
		cntMap.put("cnt", 0);
		mdao.getMyPageCount(cntMap);			
		
		int count = Integer.parseInt(cntMap.get("cnt")+"");
		paging1.setTotalCount(count);
		paging1.paging();
		paramMap.put("startNum1", paging1.getStartNum());
		paramMap.put("endNum1", paging1.getEndNum());
		paramMap.put("paging1", paging1);
		mdao.getReservateList(paramMap);		
		
	}

    public void getFavoritesList(HashMap<String, Object> paramMap) {
        int page2 = 1;
 		HttpServletRequest requset = (HttpServletRequest)paramMap.get("request");
 		HttpSession session = requset.getSession();
 		if(requset.getParameter("page2")!=null) {
 			page2 = Integer.parseInt(requset.getParameter("page2"));
 			session.setAttribute("page2", page2);
 		} else if(session.getAttribute("page2")!=null){
 			page2 = (Integer)session.getAttribute("page2");
 		} else {
 			session.removeAttribute("page2");
 		}
 		
 		Paging paging2 = new Paging();
 		paging2.setPage(page2);
 		
 		HashMap<String, Object> cntMap = new HashMap<String, Object>();
 		cntMap.put("cnt", 0);
 		cntMap.put("tableName", 2);
 		cntMap.put("mid", paramMap.get("mid"));
 		mdao.getMyPageCount(cntMap);			
 		int count = Integer.parseInt(cntMap.get("cnt")+"");
 		paging2.setTotalCount(count);
 		paging2.paging();
 		paramMap.put("startNum2", paging2.getStartNum());
 		paramMap.put("endNum2", paging2.getEndNum());
 		paramMap.put("paging2", paging2);
 		mdao.getFavoritesList(paramMap);
		
	}
	

	public void updateMember(HashMap<String, Object> paramMap) {
		mdao.updateMember(paramMap);		
	}


	public void deleteMember(HashMap<String, Object>paramMap) {
		mdao.deleteMember(paramMap);		
	}


	@Autowired
	TransactionTemplate tt;
	
	public void cancelReservate(HashMap<String, Object> paramMap) {
		try {
			tt.execute(new TransactionCallbackWithoutResult() {				
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					mdao.cancelReservate(paramMap);					
				}			
			});			
			System.out.println("Transaction Commit");
		} catch (Exception e) {
	        System.out.println("Transaction RollBack");
		}
	}

	public void deleteMyFavorites(HashMap<String, Object> paramMap) {
		mdao.deleteMyFavorites(paramMap);		
	}
  
  public void dormantMember(HashMap<String, Object> paramMap) {
		mdao.dormantMember(paramMap);	
	}

	public void returnMid(HashMap<String, Object> paramMap) {
		mdao.returnMid(paramMap);		
	}

	public void confirmMid(HashMap<String, Object> paramMap) {
		mdao.confirmMid(paramMap);		
	}

	public void updateNewPw(String mid, String newPw) {
		mdao.updateNewPw(mid, newPw);		
  }
	

	

}
