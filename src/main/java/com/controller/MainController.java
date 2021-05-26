package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.PostDTO;
import com.service.MemberService;
import com.service.PostService;

@Controller
public class MainController {
	@Autowired
	PostService pService;


	@RequestMapping(value= "/")
	public String postList(HttpSession session,HttpServletRequest request,Model model) {
	MemberDTO member = (MemberDTO)session.getAttribute("login");
	String curPage = request.getParameter("curPage");
	String addr = null;
	if(member != null) {
		addr = member.getAddr();
	}
	if(curPage == null) {
		curPage = "1";
	}
	PageDTO pDTO = pService.selectAllPostPage(Integer.parseInt(curPage),(member==null?false:true),addr);
	List<PostDTO> list = null;
	list = pDTO.getList();
	model.addAttribute("postList", list);
	model.addAttribute("blockPerPage", pDTO.getBlockPerPage());
	model.addAttribute("offset", pDTO.getOffset());
	model.addAttribute("curPage", curPage);
	model.addAttribute("prevPageBlock", pDTO.getPrevPageBlock());
	model.addAttribute("nextPageBlock", pDTO.getNextPageBlock());
	model.addAttribute("totalCount", pDTO.getTotalCount());
	model.addAttribute("totalPage", pDTO.getTotalCount()/pDTO.getPerPage());
	
	  return "/main";	  
	}
	
	

}
