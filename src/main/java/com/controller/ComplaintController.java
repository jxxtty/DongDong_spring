package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.ComplaintDTO;
import com.dto.MemberDTO;
import com.service.ComplaintService;

@Controller
public class ComplaintController {
	@Autowired
	ComplaintService coService;
	
	@RequestMapping(value = "/admin")
	public String adminPage() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/admin/complaintMember")
	public ModelAndView complaintMemberPage() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", coService.memberComplaintList());
		mav.setViewName("admin/complaintMember");
		return mav;
	}
	
	@RequestMapping(value = "/admin/complaintPost")
	public ModelAndView complaintPostPage() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", coService.postComplaintList());
		mav.setViewName("admin/complaintPost");
		return mav;
	}
	
	@RequestMapping(value = "/admin/complaintComment")
	public ModelAndView complaintCommentPage() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", coService.commentComplaintList());
		mav.setViewName("admin/complaintComment");
		return mav;
	}
	
	@RequestMapping(value = "/loginCheck/complaintAccept")
	public @ResponseBody String ComplaintAccept(HttpSession session, @RequestParam Map<String, String> map) {
		MemberDTO dto = (MemberDTO)session.getAttribute("login");
		String coTarget = map.get("coTarget");
		String userid = map.get("userid");
		String coContent = map.get("coContent");
		int coType = Integer.parseInt(map.get("coType"));
		String returnValue = "";

		ComplaintDTO coDTO = new ComplaintDTO();
		coDTO.setCoTarget(coTarget);
		coDTO.setUserid(userid);
			
		if(coService.checkDuplication(coDTO)) {
			returnValue = "dup"; 
		} else {
			coDTO.setCoContent(coContent);
			coDTO.setCoType(coType);
				
			int insertResult = coService.insertComplaint(coDTO);
				
			if(insertResult!=1) { // 게시글 업데이트가 실패했을 경우 
				returnValue = "false"; 
		    } else {	
		    	returnValue = "true"; 
		    }	
		}	
		return returnValue;
	}
	
	@RequestMapping(value = "/loginCheck/complaintDetail")
	public ModelAndView complaintDetail(HttpSession session, @RequestParam Map<String, String> map) {
		String cNum = map.get("cNum");
		String coType = map.get("coType");
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("cNum",cNum);
		mav.addObject("coType",coType);
		mav.setViewName("complaint/complaintDetail");

		return mav;
	}
}
