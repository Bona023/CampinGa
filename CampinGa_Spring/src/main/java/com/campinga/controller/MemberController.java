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

import com.campinga.dto.MemberVO;
import com.campinga.dto.Paging;
import com.campinga.service.BusinessService;
import com.campinga.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService ms;

	@RequestMapping(value = "/loginForm")
	public String loginForm() {
		return "member/login";
	}

	// 멤버 로그인 기능
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			HttpServletRequest request, Model model) {

		String url = "member/login";
		if (result.getFieldError("mid") != null)
			model.addAttribute("message", result.getFieldError("mid").getDefaultMessage());
		else if (result.getFieldError("pwd") != null)
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mid", membervo.getMid());
			paramMap.put("ref_cursor", null);

			ms.getMemberCam(paramMap);

			ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");

			if (list.size() == 0) {
				model.addAttribute("message", "아이디가 없습니다");
				return "member/login";
			}
			HashMap<String, Object> mvo = list.get(0);
			if (!mvo.get("CHKYN").equals("Y"))
				model.addAttribute("message", "휴면계정 입니다. <br> 관리자에게 문의하세요.");
			else if (!mvo.get("PWD").equals(membervo.getPwd()))
				model.addAttribute("message", "비밀번호가 맞지않습니다");
			else if (mvo.get("PWD").equals(membervo.getPwd())) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", mvo);
				url = "redirect:/";
			}
		}
		return url;
	}

	// 멤버 로그아웃 기능
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null)
			session.removeAttribute("loginUser");
		else if(session.getAttribute("loginBusinessman") != null)
			session.removeAttribute("loginBusinessman");
		return "redirect:/";
	}

	@RequestMapping(value = "/contract")
	public String contract() {
		return "member/contract";
	}

	@RequestMapping(value = "/joinForm", method = RequestMethod.POST)
	public String join_form(@RequestParam("user") String choose) {
		String url = "";
		if (choose.equals("1")) {
			url = "member/joinForm";
		} else {
			url = "business/joinForm";
		}
		return url;
	}

	// 멤버 아이디 체크
	@RequestMapping("/idCheckForm")
	public String idCheckForm(@RequestParam("mid") String mid, 
			Model model, HttpServletRequest request) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mid", mid);
		paramMap.put("ref_cursor", null);
		ms.getMemberCam(paramMap);

		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		if (list.size() == 0) {
			model.addAttribute("result", -1);
		} else {
			model.addAttribute("result", 1);
		}
		model.addAttribute("mid", mid);

		return "member/idCheck";
	}

	// 멤버 회원가입 기능
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value = "reid", required = false) String reid,
			@RequestParam(value = "pwdCheck", required = false) String pwdCheck) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/joinForm");
		mav.addObject("reid", reid);
		if (result.getFieldError("mid") != null)
			mav.addObject("message", result.getFieldError("mid").getDefaultMessage());
		else if (result.getFieldError("pwd") != null)
			mav.addObject("message", result.getFieldError("pwd").getDefaultMessage());
		else if (result.getFieldError("name") != null)
			mav.addObject("message", result.getFieldError("name").getDefaultMessage());
		else if (result.getFieldError("email") != null)
			mav.addObject("message", result.getFieldError("email").getDefaultMessage());
		else if (result.getFieldError("mphone") != null)
			mav.addObject("message", result.getFieldError("mphone").getDefaultMessage());

		else if (!membervo.getMid().equals(reid))
			mav.addObject("message", "아이디 중복체크가 되지 않았습니다");
		else if (!membervo.getPwd().equals(pwdCheck))
			mav.addObject("message", "비밀번호 확인이 일치하지 않습니다");
		else {
			ms.insertMemberCam(membervo);

			mav.addObject("message", "회원가입이 완료되었습니다. 로그인하세요");
			mav.setViewName("member/login");
		}
		return mav;
	}
	
	// 멤버 마이페이지 기능
	@RequestMapping("/myPage")  
	public ModelAndView mypage( HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mid", loginUser.get("MID"));
		paramMap.put("request", request);
		
		//예약조회
		paramMap.put("ref_cursor1", null);
        ms.getReservateList(paramMap);
		ArrayList<HashMap<String , Object>> list1
		= (ArrayList<HashMap<String , Object>>) paramMap.get("ref_cursor1");		
		mav.addObject("reList", list1);
		mav.addObject("paging1", (Paging)paramMap.get("paging1"));
		
		//즐겨찾기
		paramMap.put("ref_cursor2", null);
		 ms.getFavoritesList(paramMap);
	    ArrayList<HashMap<String , Object>> list2
		= (ArrayList<HashMap<String , Object>>) paramMap.get("ref_cursor2");
	   
	    mav.addObject("favorList", list2);
	    mav.addObject("paging2", (Paging)paramMap.get("paging2"));
	    mav.setViewName("member/mypage/mypage");
		}	
		return mav;
	}
	
	//멤버 마이페이지 회원 정보 수정 이동
	@RequestMapping(value="/editForm" )
	public String editForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		MemberVO dto = new MemberVO();
		dto.setMid( (String)loginUser.get("MID") );
		dto.setName( (String)loginUser.get("NAME") );
		dto.setMphone( (String)loginUser.get("MPHONE") );
		dto.setEmail( (String)loginUser.get("EMAIL") );
		
		model.addAttribute("dto" , dto);
		return "member/mypage/updateInfo";
	}
	
	//멤버 마이페이지 회원 정보 수정 
	@RequestMapping(value = "/updateUserInfo", method=RequestMethod.POST)
	public ModelAndView updateUserInfo( 
			@ModelAttribute("dto") @Valid MemberVO membervo, BindingResult result,
		HttpServletRequest request	) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/mypage/updateInfo");
		if( result.getFieldError("name") != null )
			mav.addObject("message", result.getFieldError("name").getDefaultMessage() );
		else if( result.getFieldError("mphone") != null )
			mav.addObject("message", result.getFieldError("mphone").getDefaultMessage() );
		else if( result.getFieldError("email") != null )
			mav.addObject("message", result.getFieldError("email").getDefaultMessage() );
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("MID", membervo.getMid() );
			paramMap.put("NAME", membervo.getName() );
			paramMap.put("MPHONE", membervo.getMphone() );
			paramMap.put("EMAIL", membervo.getEmail() );
			
			ms.updateMember( paramMap );
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", paramMap);
			mav.setViewName("redirect:/myPage");
		}		
		return mav;
	}
	
	// 멤버 마이페이지 회원 휴면계정 전환
	@RequestMapping("deleteMember")
	public String deleteMember(HttpSession session, Model model) {
		HashMap<String, Object> loginUser = 
				(HashMap<String, Object>) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "member/login";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mid", loginUser.get("MID"));
			ms.dormantMember(paramMap);
			session.removeAttribute("loginUser");
			model.addAttribute("message", "휴면 처리되었습니다. 탈퇴를 원하시면 관리자에게 문의하세요.");
		}
		return "member/login";
	}
	
	//마이페이지 예약 취소
	@RequestMapping(value = "/cancelReservate")
	public String cancelReservate( HttpServletRequest request, Model model,
			@RequestParam("reseq") int reseq) {
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			return "member/login";
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("reseq", reseq);
			ms.cancelReservate( paramMap);
		}	
		return "redirect:/myPage";
	}
	

	//마이페이지 즐겨찾기 해제
	@RequestMapping(value = "/deleteMyFavorites")
	public String deleteFavorites( HttpSession session, Model model,
			@RequestParam("fseq") int fseq) {
		HashMap<String, Object> loginUser = (HashMap<String, Object>)session.getAttribute("loginUser");
		if( loginUser == null ) {
			return "member/login";
		}else {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fseq", fseq);
		ms.deleteMyFavorites( paramMap);		
		}	
		return "redirect:/myPage";
	}
	
	
	//아이디 비번 찾기 페이지 이동
	@RequestMapping("/findIdPw")
	public String findID() {
		return "find/idPw";
	}
	
	// 아이디 찾기 페이지
	@RequestMapping("findID")
	public ModelAndView findID(@RequestParam("idkey") String idkey,
			@RequestParam("pwkey") String pwkey) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("idkey", idkey);
		mav.addObject("pwkey", pwkey);
		mav.setViewName("find/findID");
		return mav;
	}
	
	@Autowired
	BusinessService bs;
	
	// 아이디 리턴
	@RequestMapping("/returnID")
	public ModelAndView returnID(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		String idkey = request.getParameter("idkey");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		HashMap<String, Object>paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("phone", phone);
		paramMap.put("id", "");
		if(idkey.equals("mid")) {
			ms.returnMid(paramMap);
			String mid = (String)paramMap.get("id");
			if(mid==null) {
				mav.addObject("findResult", "해당 id가 없습니다.");
			}else {
				String idResult = "회원님의 ID는 '"+mid+"' 입니다";
				mav.addObject("findResult", idResult);
			}			
			mav.setViewName("find/findID");
		}else if(idkey.equals("bid")){
			bs.returnBid(paramMap);
			String bid = (String)paramMap.get("id");
			if(bid==null) {
				mav.addObject("findResult", "해당 id가 없습니다.");
			}else {
				String idResult = "회원님의 ID는 '"+bid+"' 입니다";
				mav.addObject("findResult", idResult);
			}			
			mav.setViewName("find/findID");			
		}else {
			mav.addObject("message", "알 수 없는 오류입니다.");
			mav.setViewName("loginForm");
		}
		mav.addObject("idkey",idkey);
		mav.addObject("pwkey", request.getParameter("pwkey"));
		return mav;
	}
	
	
	// 새 비밀번호 설정 페이지
	@RequestMapping("/findPW")
	public ModelAndView findPW(@RequestParam("idkey") String idkey,
			@RequestParam("pwkey") String pwkey) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("idkey", idkey);
		mav.addObject("pwkey", pwkey);
		mav.setViewName("find/findPW");
		return mav;
	}
	
	
	// 비밀번호 업데이트를 위한 본인 확인
	@RequestMapping("/confirmPW")
	public ModelAndView confirmPW(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		String pwkey = request.getParameter("pwkey");
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		HashMap<String, Object>paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("email", email);
		paramMap.put("ref_cursor", null);
		if(pwkey.equals("mpw")) {
			ms.confirmMid(paramMap);
			ArrayList<HashMap<String, Object>>list
			=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			if(list.size()==0) {
				mav.addObject("findResult", "no");
			}else {
				mav.addObject("findResult", "yes");
				mav.addObject("mORb", "mid");
				mav.addObject("inputId", id);
			}			
			mav.setViewName("find/findPW");
		}else if(pwkey.equals("bpw")){
			bs.confirmBid(paramMap);
			ArrayList<HashMap<String, Object>>list
			=(ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			if(list.size()==0) {
				mav.addObject("findResult", "no");
			}else {
				mav.addObject("findResult", "yes");
				mav.addObject("mORb", "bid");
				mav.addObject("inputId", id);
			}
			mav.setViewName("find/findPW");
		}else {
			mav.addObject("message", "알 수 없는 오류입니다.");
			mav.setViewName("loginForm");
		}
		mav.addObject("pwkey", pwkey);
		return mav;
	}
	
	
	// 새 비번 설정
	@RequestMapping("/updateNewPw")
	public String updateNewPw(HttpServletRequest request) {
		String newPw = request.getParameter("nPw");
		if(request.getParameter("mid")!=null) {
			String mid = request.getParameter("mid");
			ms.updateNewPw(mid, newPw);
		}else if(request.getParameter("bid")!=null) {
			String bid = request.getParameter("bid");
			bs.updateNewPw(bid, newPw);
		}		
		return "redirect:/loginForm";
	}
	

}
