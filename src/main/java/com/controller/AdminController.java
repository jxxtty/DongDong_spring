package com.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CommentsDTO;
import com.dto.ComplaintDTO;
import com.dto.MemberDTO;
import com.dto.PostDTO;
import com.dto.SanctionDTO;
import com.service.CommentsService;
import com.service.ComplaintService;
import com.service.MemberService;
import com.service.PostService;
import com.service.SanctionService;
import com.service.StatisticService;

@Controller
public class AdminController {
	@Autowired
	ComplaintService coService;
	@Autowired
	MemberService mService;
	@Autowired
	PostService pService;
	@Autowired
	CommentsService cService;
	@Autowired
	SanctionService saService;
	@Autowired
	StatisticService stService;
	
	@RequestMapping(value = "/admin")
	public ModelAndView adminPage(Model model) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH");
		String currentTime = sdf.format(cal.getTime());
		Map<String, List> complaintChartData = stService.getComplaintChartData(currentTime,"H", 7);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dailyChartLabel",complaintChartData.get("complaintChartLabel"));
		mav.addObject("dailyChartData",complaintChartData.get("complaintChartData"));
		mav.setViewName("admin/adminMain");
		return mav;
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
	@Transactional
	@RequestMapping(value = "/admin/complaintEnd")
	public ModelAndView complaintEnd(HttpSession session,  @RequestParam Map<String, String> map) {
		int coNum = Integer.parseInt(map.get("coNum"));
		int saType = Integer.parseInt(map.get("saType"));
		int saDate = Integer.parseInt(map.get("saDate"));
		
		
		ComplaintDTO coDTO = coService.getComplaint(coNum);
		SanctionDTO saDTO = new SanctionDTO();
		saDTO.setCoNum(coNum);
		saDTO.setSaType(saType);
		saDTO.setSaDate(saDate);
		
		ModelAndView mav = new ModelAndView();
		
		switch (coDTO.getCoType()) {
		case 1:
			saDTO.setUserid(coDTO.getCoTarget());
			mav.setViewName("redirect:/admin/complaintMember");
			break;
		case 2:
			saDTO.setUserid(coDTO.getTargetUserid());
			mav.setViewName("redirect:/admin/complaintPost");
			break;
		case 3:
			saDTO.setUserid(coDTO.getTargetUserid());
			mav.setViewName("redirect:/admin/complaintComment");
			break;
		default:
			mav.setViewName("redirect:/admin");
			break;
		}

		if(saService.isSanctioned(saDTO.getUserid())==true) {
			saDTO.setEndDate(saService.getEndDateByUserid(saDTO.getUserid()));
		}
		if(saDate==0) {
			int complaintResult = coService.complaintEnd(coNum);
			return mav;
		}
		int complaintResult = coService.complaintEnd(coNum);
		int sanctionResult = saService.insertSanction(saDTO);
		
		
		return mav;
	}
	
	
	@RequestMapping(value = "/admin/complaintHandlingDetail")
	public ModelAndView complaintHandlingDetail(HttpSession session, @RequestParam("coNum") int coNum) {
		ModelAndView mav = new ModelAndView();
		MemberDTO mDTO = null;
		PostDTO pDTO = null;
		CommentsDTO cDTO = null;
		ComplaintDTO coDTO = coService.getComplaint(coNum);
		
		switch (coDTO.getCoType()) {
		case 1:
			mDTO = mService.mypage(coDTO.getTargetUserid());
			if(mDTO==null) {
				mav.addObject("isDeleted", true);
			} else {
				mav.addObject("isDeleted", false);
			}
			mDTO = new MemberDTO();
			
			mDTO.setUserid(coDTO.getTargetUserid());
			mDTO.setUserimage(coDTO.getTargetImage());
			mDTO.setNickName(coDTO.getTargetUserid());
			mDTO.setUserid(coDTO.getTargetUserid());
			mav.setViewName("admin/complaintMemberDetail");
			break;
		case 2:
			pDTO = pService.getPostByPNum(Integer.parseInt(coDTO.getCoTarget()));
			if(pDTO==null) {
				mav.addObject("isDeleted", true);
			} else {
				mav.addObject("isDeleted", false);
			}
			pDTO = new PostDTO();
			pDTO.setUserid(coDTO.getTargetUserid());
			pDTO.setpTitle(coDTO.getTargetTitle());
			pDTO.setpImage(coDTO.getTargetImage());
			pDTO.setpContent(coDTO.getTargetContent());
			mav.addObject("pDTO", pDTO);
			mav.setViewName("admin/complaintPostDetail");
			break;
		case 3:
			cDTO = cService.getCommentByCNum(Integer.parseInt(coDTO.getCoTarget()));
			if(cDTO==null) {
				mav.addObject("isDeleted", true);
			} else {
				mav.addObject("isDeleted", false);
			}
			cDTO = new CommentsDTO();
			cDTO.setUserid(coDTO.getTargetUserid());
			cDTO.setUserimage(coDTO.getTargetImage());
			cDTO.setcContent(coDTO.getTargetContent());
			cDTO.setNickName(coDTO.getTargetTitle());
			mav.addObject("cDTO", cDTO);
			mav.setViewName("admin/complaintCommentDetail");
			break;
		default:
			mav.setViewName("admin");
			break;
		}
		mDTO = mService.mypage(coDTO.getTargetUserid());
		mav.addObject("mDTO", mDTO);
		mav.addObject("coDTO", coDTO);
		mav.addObject("sanctionList", saService.sanctionList((String)mDTO.getUserid()));
		mav.addObject("isSanctioned", saService.isSanctioned((String)mDTO.getUserid()));
		mav.addObject("endSanctionDate", saService.getEndDateByUserid((String)mDTO.getUserid()));
		mav.addObject("isAlreadyCompleted", coService.isAlreadyCompleted(coDTO)==0?false:true);
		return mav;
	}
	
	@RequestMapping(value = "/admin/targetDelete")
	public @ResponseBody void targetDelete(HttpSession session, @RequestParam Map<String, String> map) {
		ComplaintDTO coDTO = coService.getComplaint(Integer.parseInt(map.get("target")));
		if(coDTO.getCoType()==1) {
			
		} else if(coDTO.getCoType()==2) {
			pService.deletePostByPNum(Integer.parseInt(coDTO.getCoTarget()));
		} else if(coDTO.getCoType()==3) {
			cService.deleteCommentByCNum(Integer.parseInt(coDTO.getCoTarget()));
		}
	}
}
