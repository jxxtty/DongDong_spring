package com.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dto.MemberDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.MemberService;


@Controller
public class MemberController {
	@Autowired
	MemberService mService;
	
	
	@RequestMapping(value = "/idSearch")
	public String idSerach(String username, String phone, String email, Model model ) {
		MemberDTO dto = new MemberDTO();
		String email1 = email.split("@")[0];
		String email2 = email.split("@")[1];
		
		dto.setUsername(username);
		dto.setPhone(phone);
		dto.setEmail1(email1);
		dto.setEmail2(email2);
		String userid = mService.idSearch(dto);
		
		if(userid == null) {
			model.addAttribute("mesg", "등록되지 않은  회원 정보");
			return "redirect:/idSerach";
		}else {
			//이메일 전송
		}
		
		return "redirect:/main";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}

