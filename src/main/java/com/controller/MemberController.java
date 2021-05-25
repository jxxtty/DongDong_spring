package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;


@Controller
public class MemberController {
	@Autowired
	MemberService mService;
	
	@RequestMapping(value = "/nicknameDuplicateCheck", produces = "text/plain;charset=UTF-8") // 한글처리
	public @ResponseBody String nicknameDuplicateCheck(@RequestParam("nickName") String nickName) {
		// 비동기 방식 요청에 대한 mesg를 문자열로 전송
		MemberDTO dto = mService.mypage(nickName);
		String mesg = "닉네임 사용가능";
		if (dto != null) {// db에 같은 id가 존재
			mesg = "닉네임 중복";
		}
		return mesg; // view페이지가 아닌 mesg문자열 전송
	}

	// 아이디 중복검사
	@RequestMapping(value = "/idDuplicateCheck", produces = "text/plain;charset=UTF-8") // 한글처리
	public @ResponseBody String idDuplicatedCheck(@RequestParam("id") String userid) {
		// 비동기 방식 요청에 대한 mesg를 문자열로 전송
		MemberDTO dto = mService.mypage(userid);
		String mesg = "아이디 사용가능";
		if (dto != null) {// db에 같은 id가 존재
			mesg = "아이디 중복";
		}
		return mesg; // view페이지가 아닌 mesg문자열 전송
	}
	
	//회원가입 
	@RequestMapping(value = "/memberAdd") // 회원가입 기능
	public String memberAdd(MemberDTO m,Model model) {
		mService.memberAdd(m);
		// m 값이 1인경우 회원가입 가능하면 좋은데
		model.addAttribute("success", "회원가입성공");
		return "main";
	}
	
	
}

