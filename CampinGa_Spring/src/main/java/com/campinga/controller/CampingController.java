package com.campinga.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import org.springframework.web.servlet.ModelAndView;

import com.campinga.dto.FavoritesVO;
import com.campinga.dto.MemberVO;
import com.campinga.dto.Paging;
import com.campinga.dto.QnaVO;
import com.campinga.dto.ReviewVO;
import com.campinga.dto.ReservationVO;
import com.campinga.service.AdminService;
import com.campinga.service.CampingService;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;

@Controller
public class CampingController {

	@Autowired
	CampingService cs;

	// 메인 페이지
	@RequestMapping("/")
	public ModelAndView main() {

		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		paramMap.put("ref_cursor3", null);

		cs.getNewRecoCamping(paramMap);		

		// 새로운 캠핑장 리스트
		ArrayList<HashMap<String, Object>> newCampList 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor1");
		
		// 추천 캠핑장 리스트
		ArrayList<HashMap<String, Object>> recoCampList 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor2");
		
		// 메인 롤링 리스트
		cs.getBannerList(paramMap);
		ArrayList<HashMap<String, Object>> bannerList
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor3");

		mav.addObject("newCampList", newCampList);
		mav.addObject("recoCampList", recoCampList);
		mav.addObject("bannerList", bannerList);

		mav.setViewName("main");
		return mav;
	}

	// 메인 페이지 검색기능
	@RequestMapping("/mainSearch")
	public ModelAndView mainSearch(HttpServletRequest request, Model model, @RequestParam("address1") String address1,
			@RequestParam("address2") String address2, @RequestParam("cname") String cname) {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("address1", address1);
		paramMap.put("address2", address2);
		paramMap.put("cname", cname);
		paramMap.put("ref_cursor", null);
		cs.getSearchResult(paramMap);

		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		mav.addObject("campList", list);
		mav.setViewName("camping/campingList");
		return mav;
	}

	@RequestMapping("/category")
	public ModelAndView categoryList(@RequestParam("kind") int kind) {

		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		if (kind == 1) {
			cs.categoryAll(paramMap);
		} else {
			String[] kindList = { "", "오토캠핑", "캠핑", "카라반", "캠프닉" };
			String category = kindList[kind - 1];
			paramMap.put("category", category);
			cs.categoryList(paramMap);
		}

		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		mav.addObject("campList", list);
		mav.setViewName("camping/campingList");
		return mav;
	}

	@RequestMapping("/CampNameSearch")
	public ModelAndView CampNameSearch(@RequestParam("key") String key) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		paramMap.put("key", key);
		cs.campNameSerch(paramMap);

		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

		mav.addObject("campList", list);
		mav.addObject("key", (String) paramMap.get("key"));
		mav.setViewName("camping/campingList");
		return mav;
	}

	@RequestMapping("/campDetail")
	public ModelAndView campDetail(@RequestParam("bseq") int bseq, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bseq", bseq);
		mav.addObject("bseq", bseq);

		paramMap.put("request", request);

		// 캠핑장 정보 조회
		paramMap.put("ref_cursor", null);
		cs.campDetailByBseq(paramMap);
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		mav.addObject("campMain", list.get(0));
		System.out.println(list.get(0).get("CAMPIMAGES"));

		// 로그인한 경우 즐겨찾기 조회
		HashMap<String, Object> loginUser = (HashMap<String, Object>) request.getSession().getAttribute("loginUser");
		if (loginUser != null) {
			paramMap.put("myFav", "");
			paramMap.put("mid", loginUser.get("MID"));
			cs.getFav(paramMap);
			String myFav = (String) paramMap.get("myFav");
			if (myFav.equals("y")) {
				mav.addObject("chk_fav", "Y");
			} else {
				mav.addObject("chk_fav", "N");
			}
		}

		// 캠핑장 객실 조회
		paramMap.put("ref_cursor2", null);
		cs.selectCampingList(paramMap);

		ArrayList<HashMap<String, Object>> list2 = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor2");

		mav.addObject("campingList", list2);

		// 캠핑장 QnA 조회
		paramMap.put("ref_cursor3", null);
		cs.selectQnaByBseq(paramMap);

		ArrayList<HashMap<String, Object>> list3 = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor3");

		if (request.getParameter("qseq") != null) {
			int qseq = Integer.parseInt(request.getParameter("qseq"));
			mav.addObject("updateQseq", qseq);
		}
		mav.addObject("paging1", (Paging) paramMap.get("paging1"));
		mav.addObject("qnalist", list3);

		// 캠핑장 review 조회
		paramMap.put("ref_cursor4", null);
		cs.selectReviewByBseq(paramMap);

		ArrayList<HashMap<String, Object>> list4 = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor4");

		if (request.getParameter("rseq") != null) {
			int rseq = Integer.parseInt(request.getParameter("rseq"));
			mav.addObject("updateRseq", rseq);
		}

		mav.addObject("paging2", (Paging) paramMap.get("paging2"));
		mav.addObject("reviewList", list4);

		mav.setViewName("camping/campDetail");
		return mav;
	}

	// 큐앤에이 등록, 수정, 삭제
	@RequestMapping(value = "/insertQna", method = RequestMethod.POST)
	public ModelAndView insertQna(@ModelAttribute("qnaVO") @Valid QnaVO qvo, @RequestParam("bseq") int bseq,
			BindingResult result, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");

		mav.setViewName("campDetail?bseq=" + bseq + "#qnabox");
		if (loginUser == null)
			mav.setViewName("member/login");
		else {
			if (result.getFieldError("content") != null)
				mav.addObject("message", result.getFieldError("content").getDefaultMessage());
			else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				qvo.setMid((String) loginUser.get("MID"));

				paramMap.put("bseq", bseq);
				paramMap.put("mid", qvo.getMid());
				paramMap.put("content", qvo.getContent());

				cs.insertQna(paramMap);
				mav.setViewName("redirect:/campDetail?bseq=" + bseq + "#qnabox");
			}
		}
		return mav;
	}

	@RequestMapping(value = "/updateQna", method = RequestMethod.POST)
	public String updateQna(@ModelAttribute("qnaVO") @Valid QnaVO qvo, BindingResult result,
			@RequestParam("bseq") int bseq, Model model, HttpServletRequest request) {

		if (result.getFieldError("content") != null)
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", Integer.parseInt(request.getParameter("qseq")));
			paramMap.put("content", request.getParameter("content"));
			paramMap.put("mid", request.getParameter("mid"));
			cs.updateQna(paramMap);
		}

		return "redirect:/campDetail?bseq=" + bseq + "#qnabox";
	}

	@RequestMapping(value = "/deleteQna")
	public String deleteQna(@RequestParam("qseq") int qseq, @RequestParam("bseq") int bseq,
			HttpServletRequest request) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq", qseq);
		paramMap.put("bseq", bseq);

		cs.deleteQna(paramMap);
		return "redirect:/campDetail?bseq=" + bseq + "#qnabox";
	}

	// 리뷰 등록, 수정, 삭제
	@RequestMapping(value = "/insertReview")
	public ModelAndView insertReview(@ModelAttribute("ReviewVO") @Valid ReviewVO rvo, @RequestParam("bseq") int bseq,
			BindingResult result, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");
		mav.setViewName("campDetail?bseq=" + bseq + "#reviewbox");
		if (loginUser == null)
			mav.setViewName("member/login");
		else {
			if (result.getFieldError("content") != null)
				mav.addObject("message", result.getFieldError("content").getDefaultMessage());
			else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();

				rvo.setMid((String) loginUser.get("MID"));

				paramMap.put("bseq", bseq);
				paramMap.put("mid", rvo.getMid());
				paramMap.put("content", rvo.getContent());

				cs.insertReview(paramMap);
				mav.setViewName("redirect:/campDetail?bseq=" + bseq + "#reviewbox");
			}
		}
		return mav;
	}

	@RequestMapping(value = "/updateReview", method = RequestMethod.POST)
	public String updateReview(@ModelAttribute("ReviewVO") @Valid ReviewVO rvo, BindingResult result,
			@RequestParam("bseq") int bseq, Model model, HttpServletRequest request) {

		if (result.getFieldError("content") != null)
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("rseq", Integer.parseInt(request.getParameter("rseq")));
			paramMap.put("content", request.getParameter("content"));
			paramMap.put("mid", request.getParameter("mid"));
			cs.updateReview(paramMap);
		}

		return "redirect:/campDetail?bseq=" + bseq + "#reviewbox";
	}

	@RequestMapping("deleteReview")
	public String deleteReview(@RequestParam("rseq") int rseq, @RequestParam("bseq") int bseq,
			HttpServletRequest request) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("rseq", rseq);
		paramMap.put("bseq", bseq);

		cs.deleteReview(paramMap);
		return "redirect:/campDetail?bseq=" + bseq + "#reviewbox";
	}

	@RequestMapping("/reserveForm")
	public ModelAndView reserveForm(HttpServletRequest request, @RequestParam("cseq") int cseq) {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> loginUser = 
				(HashMap<String, Object>) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			mav.addObject("message", "예약하려면 로그인해주세요.");
			mav.setViewName("member/login");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("cseq", cseq);
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor2", null);
			cs.selectCampOne(paramMap);
			ArrayList<HashMap<String, Object>> list = 
					(ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			ArrayList<HashMap<String, Object>> resDate = 
					(ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor2");
			mav.addObject("campVO", list.get(0));
			mav.addObject("reDateList", resDate);
			mav.setViewName("camping/reserve/reserve");
		}
		return mav;
	}

	// ------------------------ 캠핑장 예약 --------------------------------------
	@RequestMapping("/reserveInsert")
	public ModelAndView reserveInsert(@ModelAttribute("dto") ReservationVO resVO, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		cs.reserveInsert(resVO);
		mav.setViewName("redirect:/myPage");
		return mav;
	}
	
	
	// 즐겨찾기 추가
	@RequestMapping("/addFavorites")
	public ModelAndView addFavorites( HttpServletRequest request, 
			@RequestParam("bseq") int bseq) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>) session.getAttribute("loginUser");

		mav.setViewName("campDetail?bseq=" + bseq );
		if (loginUser == null)
			mav.setViewName("member/login");
		else {	
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			FavoritesVO fvo = new FavoritesVO();
			
			if( fvo.getFav_check() == null || fvo.getFav_check().equals("n")) 
				fvo.setFav_check("y");
			
			fvo.setMid((String) loginUser.get("MID"));

			paramMap.put("bseq", bseq);
			paramMap.put("mid", fvo.getMid());
			paramMap.put("fav_check", fvo.getFav_check());
			
			cs.insertFavorites(paramMap);
			mav.setViewName("redirect:/campDetail?bseq=" + bseq);
		}
		return mav;
	}
	
	
	@RequestMapping("/deleteFavorites")
	public String deleteFavorites(HttpServletRequest request, 
			@RequestParam("bseq") int bseq) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bseq", bseq);

		cs.deleteFavorites(paramMap);
		
		return "redirect:/campDetail?bseq=" + bseq;
	}

	
	@Autowired
	AdminService as;
	
	// 공지사항 페이지
	@RequestMapping("noticeList")
	public ModelAndView noticeList(HttpServletRequest request,
 			@RequestParam(value="first", required=false) String first) {

 		ModelAndView mav = new ModelAndView();
 		HttpSession session = request.getSession();

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
		mav.setViewName("notice/noticeList");			
 		
 		return mav;
 	} 
	
	
	// 공지사항 보기
	@RequestMapping("/noticeDetail")
 	public ModelAndView noticeDetail(@RequestParam("nseq") int nseq,
 			HttpServletRequest request) {
 		ModelAndView mav = new ModelAndView();
 		HttpSession session = request.getSession();

		HashMap<String, Object>paramMap = new HashMap<String,Object>();
 		paramMap.put("nseq", nseq);
 		paramMap.put("ref_cursor", null);
 		as.selectNoticeOne(paramMap);
 		ArrayList<HashMap<String, Object>>list
 			=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
 		mav.addObject("noticeVO", list.get(0));
 		mav.setViewName("notice/noticeDetail"); 			
 			
 		return mav;
 	}

}
