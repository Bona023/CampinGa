package com.campinga.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.campinga.dto.BannerVO;
import com.campinga.dto.NoticeVO;
import com.campinga.dto.Paging;
import com.campinga.service.AdminService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class AdminController {
	
	@Autowired
	AdminService as;	

	@RequestMapping(value = "/adminLoginForm")
	public String adminLoginForm() {
		return "admin/adminlogin";
	}
	
	// 관리자 로그인
	@RequestMapping(value="/adminLogin", method = RequestMethod.POST)
	public String adminLogin(HttpServletRequest request, Model model,
			@RequestParam("adminId") String adminId,
			@RequestParam("adminPwd") String adminPwd) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		paramMap.put("adminId", adminId);
		as.getAdminList(paramMap); 	
		
		String url = "admin/adminlogin";
		ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
	    if( list.size() == 0 ) {	
	       model.addAttribute("message", "조회된 아이디가 없습니다");
		   return url;
	    }
	    HashMap<String, Object> resultMap = list.get(0);
	    if(resultMap.get("PWD")==null)
		    model.addAttribute("message", "관리자에게 문의하세요");
	    else if(adminPwd.equals((String)resultMap.get("PWD"))) {
		    HttpSession session = request.getSession();
		    session.setAttribute("loginAdmin", resultMap);
		    url = "redirect:/adminMemberList";
	    } else
		  model.addAttribute("message", "비밀번호가 틀렸습니다");
		return url;
	}	
		
	// 관리자 로그아웃
	@RequestMapping(value="/adminLogout")
	public String adminLogout(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
	    session.removeAttribute("loginAdmin");
	    return "redirect:/";
	}
		
	// 회원 리스트 페이지
	@RequestMapping("/adminMemberList")
	public ModelAndView adminMemberList(
			@RequestParam(value="first", required=false) String first,
			HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		HashMap<String, Object>loginAdmin
			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
		
		if(loginAdmin==null) {
			mav.setViewName("admin/adminlogin");			
		} else {
			if(first!=null) {
				request.removeAttribute("page");
				session.removeAttribute("page");
				request.removeAttribute("key");
				session.removeAttribute("key");
			}
			HashMap<String, Object>paramMap = new HashMap<String,Object>();
			paramMap.put("ref_cursor", null);
			paramMap.put("request", request);
			as.adminMemberList(paramMap);
			ArrayList<HashMap<String, Object>>list
				=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			mav.addObject("key", (String)paramMap.get("key"));
			mav.addObject("memberList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/member/memberList");			
		}
		return mav;
	}	
	
	// 사용자회원 휴면 전환
	@RequestMapping("/adminMemberDormant")
	public String adminMemberDormant( HttpServletRequest request, Model model ) {
		
		String [] mid = request.getParameterValues("mid");

		for (String memberid : mid) {
			// 각각의 사용자 아이디로 CHKYN을 Y -> N, N -> Y로 변경
			as.updateMemberDormant(memberid);
		}
		
		return "redirect:/adminMemberList";
	}	
	
	// 캠핑장 관리 페이지
	@RequestMapping("/adminCampingList")
	public ModelAndView adminCampingList(
			@RequestParam(value="first", required=false) String first,
			HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();

		HashMap<String, Object>loginAdmin
			= (HashMap<String, Object>)session.getAttribute("loginAdmin");

		if(loginAdmin==null) {
			mav.setViewName("admin/adminlogin");			
		} else {
			if(first!=null) {
				request.removeAttribute("page");
				session.removeAttribute("page");
				request.removeAttribute("key");
				session.removeAttribute("key");
			}
			HashMap<String, Object>paramMap = new HashMap<String,Object>();
			paramMap.put("ref_cursor", null);
			paramMap.put("request", request);
			as.adminCampingList(paramMap);
			ArrayList<HashMap<String, Object>>list
				=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			mav.addObject("key", (String)paramMap.get("key"));
			mav.addObject("campingList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/camping/campingList");			
		}
		return mav;
	}
	
	
	// 가입 승인 or 휴면
	@RequestMapping("/adminCampingJoinDormant")
	public String adminCampingJoinDormant(HttpServletRequest request, 
			@RequestParam("bseq") int bseq,
			@RequestParam("chkyn") String chkyn) {
		HttpSession session = request.getSession();

		HashMap<String, Object> loginAdmin = 
				(HashMap<String, Object>) session.getAttribute("loginAdmin");
		String url = "redirect:/adminCampingList";
		if (loginAdmin == null) {
			url = "admin/adminlogin";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("bseq", bseq);
			paramMap.put("chkyn", chkyn);
			as.adminCampingJoinDormant(paramMap);
		}
		return url;
	}
	
	
	// 사업자(캠핑장) 계정 삭제
	@RequestMapping("/adminCampingDelete")
	public String adminCampingDelete(@RequestParam("bseq") int bseq,
			HttpServletRequest request) {
		HttpSession session = request.getSession();

		HashMap<String, Object>loginAdmin
			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
		
		String url = "redirect:/adminCampingList";
		if(loginAdmin==null) {
			url = "admin/adminlogin";			
		} else {
			as.adminCampingDelete(bseq);
		}		
		return url;
	}
	
	

	// 예약 관리
	@RequestMapping("/adminRestList")
	public ModelAndView adminRestList(
			@RequestParam(value="first", required=false) String first,
	        HttpServletRequest request) {
	
		ModelAndView mav = new ModelAndView();
	    HttpSession session = request.getSession();
	
	    HashMap<String, Object>loginAdmin
	       = (HashMap<String, Object>)session.getAttribute("loginAdmin");
	
	    if(loginAdmin==null) {
	         mav.setViewName("admin/adminlogin");         
	    } else {
	    	if(first!=null) {
	    		request.removeAttribute("page");
	            session.removeAttribute("page");
	            request.removeAttribute("key");
				session.removeAttribute("key");
	        }
	        HashMap<String, Object>paramMap = new HashMap<String,Object>();
	        paramMap.put("ref_cursor", null);
	        paramMap.put("request", request);
	        as.adminRestList(paramMap);
	        ArrayList<HashMap<String, Object>>list
	           =(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
	        mav.addObject("key", (String)paramMap.get("key"));
	        mav.addObject("restList", list);
	        mav.addObject("paging", (Paging)paramMap.get("paging"));
	        mav.setViewName("admin/camping/campingRestList");         
	    }
	    return mav;
	 }
	 
	
	// 리뷰페이지
    @RequestMapping("/adminReviewList")
    public ModelAndView adminReviewList(
         @RequestParam(value="first", required=false) String first,
         HttpServletRequest request) {
      
         ModelAndView mav = new ModelAndView();
         HttpSession session = request.getSession();
       
        HashMap<String, Object>loginAdmin
          = (HashMap<String, Object>)session.getAttribute("loginAdmin");
   
        if(loginAdmin==null) {
           mav.setViewName("admin/adminlogin");         
        } else {
            if(first!=null) {
               request.removeAttribute("page");
               session.removeAttribute("page");
               request.removeAttribute("key");
               session.removeAttribute("key");
            }
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("request", request);
        paramMap.put("ref_cursor", null);
        as.adminReviewList(paramMap);
        ArrayList<HashMap<String, Object>> list 
           = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
        mav.addObject("key", (String)paramMap.get("key"));
        mav.addObject("paging", (Paging)paramMap.get("paging"));
        mav.addObject("reviewList", list);
        mav.setViewName("admin/review/reviewList");
        }
       return mav;
     }
   
    // 리뷰 삭제
    @RequestMapping("adminReviewDelete")
    public String board_delete(@RequestParam("rseq") String[] rseqArr,
    		Model model , HttpServletRequest request) {
      
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("rseqArr", rseqArr);
      
        as.deleteReview(paramMap);
        return "redirect:/adminReviewList";
    }
    
    
    // 공지사항 관리 페이지
 	@RequestMapping("/adminNoticeList")
 	public ModelAndView adminNoticeList(
 			@RequestParam(value="first", required=false) String first,
 			HttpServletRequest request) {

 		ModelAndView mav = new ModelAndView();
 		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");

 		if(loginAdmin==null) {
 			mav.setViewName("admin/adminlogin");			
 		} else {
 			if(first!=null) {
 				request.removeAttribute("page");
 				session.removeAttribute("page");
 			}
 			HashMap<String, Object>paramMap = new HashMap<String,Object>();
 			paramMap.put("ref_cursor", null);
 			paramMap.put("request", request);
 			as.adminNoticeList(paramMap);
 			ArrayList<HashMap<String, Object>>list
 				=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
 			mav.addObject("noticeList", list);
 			mav.addObject("paging", (Paging)paramMap.get("paging"));
 			mav.setViewName("admin/notice/noticeList");			
 		}
 		return mav;
 	}
    
 	
 	// 공지사항 보기
 	@RequestMapping("/adminNoticeDetail")
 	public ModelAndView adminNoticeDetail(@RequestParam("nseq") int nseq,
 			HttpServletRequest request) {
 		ModelAndView mav = new ModelAndView();
 		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");

 		if(loginAdmin==null) {
 			mav.setViewName("admin/adminlogin");			
 		} else {
 			HashMap<String, Object>paramMap = new HashMap<String,Object>();
 	 		paramMap.put("nseq", nseq);
 	 		paramMap.put("ref_cursor", null);
 	 		as.selectNoticeOne(paramMap);
 	 		ArrayList<HashMap<String, Object>>list
 	 			=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
 	 		mav.addObject("noticeVO", list.get(0));
 	 		mav.setViewName("admin/notice/noticeDetail"); 			
 		} 		
 		return mav;
 	}
 	
 	
 	// 공지사항 수정 페이지
 	@RequestMapping("adminNoticeUpdateForm")
 	public ModelAndView adminNoticeUpdateForm(@RequestParam("nseq") int nseq, 			
 			HttpServletRequest request) {
 		
 		ModelAndView mav = new ModelAndView();
 		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");

 		if(loginAdmin==null) {
 			mav.setViewName("admin/adminlogin");			
 		} else {
 			HashMap<String, Object>paramMap = new HashMap<String,Object>();
 	 		paramMap.put("nseq", nseq);
 	 		paramMap.put("ref_cursor", null);
 	 		as.selectNoticeOne(paramMap);
 	 		ArrayList<HashMap<String, Object>>list
 	 			=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
 	 		HashMap<String, Object>nvo = list.get(0);
 	 		NoticeVO dto = new NoticeVO();
 	 		dto.setNseq(nseq);
 	 		dto.setContent((String)nvo.get("CONTENT"));
 	 		dto.setSubject((String)nvo.get("SUBJECT")); 
 	 		mav.addObject("noticeVO", dto);
 	 		mav.setViewName("admin/notice/noticeUpdate"); 
 		} 		
 		return mav;
 	}
 	
 	
 	// 공지사항 수정
  	@RequestMapping(value="adminNoticeUpdate", method=RequestMethod.POST)
  	public ModelAndView adminNoticeUpdate(@RequestParam("nseq") int nseq,
  			@ModelAttribute("noticeVO") @Valid NoticeVO noticevo,
  			BindingResult result, HttpServletRequest request) {
  		
  		ModelAndView mav = new ModelAndView();
  		mav.setViewName("admin/notice/noticeUpdate");
  		if(result.getFieldError("subject")!=null) {   
  			mav.addObject("message", result.getFieldError("subject").getDefaultMessage());
  		} else if(result.getFieldError("content")!=null) {
  			mav.addObject("message", result.getFieldError("content").getDefaultMessage());
  		} else {
  			as.adminNoticeUpdate(noticevo);
  			mav.setViewName("redirect:/adminNoticeDetail?nseq="+nseq);  			
  		}  		
  		return mav;
  	}
    
    
  	// 공지사항 쓰기 폼
  	@RequestMapping("/adminNoticeWriteForm")
  	public String noticeWriteForm(HttpServletRequest request) { 
  		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
 		String url = "admin/notice/noticeWrite";
 		if(loginAdmin==null) {
 			url = "admin/adminlogin";			
 		} 
  		return url;
  	}
    
  	// 공지사항 작성
  	@RequestMapping(value="adminNoticeWrite", method=RequestMethod.POST)
    public String noticeWrite( 
    		@ModelAttribute("noticeVO") @Valid NoticeVO noticevo,
    		BindingResult result, Model model) {
  		
  		String url = "admin/notice/noticeWrite";
  		if(result.getFieldError("subject")!=null) {   
  			model.addAttribute("message", result.getFieldError("subject").getDefaultMessage());
  		} else if(result.getFieldError("content")!=null) {
  			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
  		} else {
  			as.adminNoticeWrite(noticevo);
  			url = "redirect:/adminNoticeList";  			
  		}  		  		
  		return url;
  	}
  	
  	// 공지사항 삭제
  	@RequestMapping("adminNoticeDelete")
  	public String adminNoticeDelete(HttpServletRequest request,
  			@RequestParam("nseq") int nseq) {
  		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
 		String url = "redirect:/adminNoticeList";
 		if(loginAdmin==null) {
 			url = "admin/adminlogin";			
 		} else {
 			as.adminNoticeDelete(nseq);
 		}
 		return url;
  	}
    
    
  	// 롤링 이미지 리스트
  	@RequestMapping("/adminBannerList")
  	public ModelAndView adminMainimgList(HttpServletRequest request) {
  		ModelAndView mav = new ModelAndView();
  		HttpSession session = request.getSession();

 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
 		if(loginAdmin==null) {
 			mav.setViewName("admin/adminlogin");			
 		} else {
 			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			as.adminBannerlist(paramMap);
			ArrayList<HashMap<String, Object>>list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			mav.addObject("bannerList", list); 			
 			mav.setViewName("admin/banners/bannerList");
 		}  		
  		return mav;
  	}
  	
  	
  	// 롤링 이미지 등록 페이지
  	@RequestMapping("/adminBannerWriteForm")
  	public String adminBannerWriteForm(HttpServletRequest request) {
  		HttpSession session = request.getSession();
 		HashMap<String, Object>loginAdmin
 			= (HashMap<String, Object>)session.getAttribute("loginAdmin");
 		String url = "admin/banners/writeBanner";
 		if(loginAdmin==null) {
 			url = "admin/adminlogin";			
 		}  		
  		return url;
  	}
    
  	@Autowired
  	ServletContext context;
  	
  	// 배너 이미지파일 업로드
  	@RequestMapping(value="banFileUp", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> fileup(Model model, HttpServletRequest request){
		String path = context.getRealPath("/images/banner");
		HashMap<String, Object> result = new HashMap<String, Object>();		
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 10*1024*1024, "UTF-8",  new DefaultFileRenamePolicy()
			);
			result.put("STATUS", 1);
			result.put("FILENAME", multi.getFilesystemName("fileimage"));
		} catch (IOException e) {e.printStackTrace();
		}
		return result;
	}
    
  	
  	
  	// 배너 이미지 등록
  	@RequestMapping("/adminBannerWrite")
  	public String adminBannerWrite(@ModelAttribute("dto") @Valid BannerVO bannervo,
  			BindingResult result, Model model) {
  		
  		String url = "redirect:/adminBannerList";
  		if(result.getFieldError("name")!=null) {
  			url = "admin/banners/writeBanner";
  			model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
  		} else if(result.getFieldError("image")!=null) {
  			url = "admin/banners/writeBanner";
  			model.addAttribute("message", result.getFieldError("image").getDefaultMessage());
  		} else {
  			if(bannervo.getOrder_seq()==6) bannervo.setUseyn("N");
  			else bannervo.setUseyn("Y");
  			as.adminBannerWrite(bannervo);  			
  		}  		
  		return url;
  	}
  	
  	
  	
  	// 배너 순서 변경
  	@RequestMapping("/orderChange")
  	public String orderChange(
  			@RequestParam("mbseq") int mbseq,
  			@RequestParam("changeval") int order_seq) {
  		HashMap<String, Object> paramMap = new HashMap<String, Object>();
  		paramMap.put("mbseq", mbseq);
  		paramMap.put("order_seq", order_seq);
  		as.bannerOrderUpdate(paramMap);
  		
  		return "redirect:/adminBannerList";
  	}
  	
  	
  	
  	// 배너 수정 페이지
  	@RequestMapping("/bannerUpdateForm")
  	public ModelAndView adminBannerUpdate(@RequestParam("mbseq") int mbseq,
  			HttpServletRequest request) {
  		
  		ModelAndView mav = new ModelAndView();
  		HashMap<String, Object> loginAdmin
  			= (HashMap<String, Object>)request.getSession().getAttribute("loginAdmin");
  		if(loginAdmin==null) {
  			mav.setViewName("admin/adminlogin");
  		} else {
  			HashMap<String, Object>paramMap = new HashMap<String, Object>();
  			paramMap.put("mbseq", mbseq);
  			paramMap.put("ref_cursor", null);
  			as.bannerSelectOne(paramMap);
  			ArrayList<HashMap<String, Object>>list
  			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
  			mav.addObject("banner", list.get(0));  			
  			mav.setViewName("admin/banners/editBannerForm");
  		}  		  		
  		return mav;
  	}
  	
  	
  	// 배너 수정하기
  	@RequestMapping("/adminBannerUpdate")
  	public ModelAndView adminBannerUpdate(@ModelAttribute("banner") BannerVO bannervo,
  			@RequestParam("oldimage") String oldimage) {
  		ModelAndView mav = new ModelAndView();  		
  		if(bannervo.getOrder_seq()<6) bannervo.setUseyn("Y");
  		else bannervo.setUseyn("N");
  		if(bannervo.getImage().equals("")) bannervo.setImage(oldimage);
  		as.adminBannerUpdate(bannervo);  
  		mav.setViewName("redirect:/adminBannerList");
  		return mav;
  	}
  	
  	
  	// 배너 삭제
  	@RequestMapping("/adminBannerDelete")
  	public String adminBannerDelete(@RequestParam("mbseq") int mbseq) {
  		as.adminBannerDelete(mbseq);
  		return "redirect:/adminBannerList";
  	}
  	
  	
    

		
}
