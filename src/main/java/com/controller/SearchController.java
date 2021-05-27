package com.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.PostService;

@Controller
public class SearchController {
	@Autowired
	PostService serivce;
	
	@RequestMapping(value="/keywordSearch", method=RequestMethod.POST)
	public String keywordSearch(String keyword, HttpSession session) {
		MemberDTO mDto = (MemberDTO)session.getAttribute("login");
		String addr = "null";
		if(mDto != null) { // 로그인 된 상태
			addr = mDto.getAddr();
		}
		HashMap<String,String> map = new HashMap<>();
		map.put("addr", addr);
		map.put("keyword", keyword);
		
		
		// 키워드도 같이 넘겨야됨!
		return "";
	}
	
	@RequestMapping(value="/categorySearch")
	public String categorySearch(@RequestParam("category") String category, HttpSession session, Model m){
		MemberDTO mDto = (MemberDTO)session.getAttribute("login");
		String addr = "null";
		if(mDto != null) { // 로그인 된 상태
			addr = mDto.getAddr();
		}
		HashMap<String,String> map = new HashMap<>();
		map.put("addr", addr);
		map.put("category", category);
		
		
		
		HashMap<String,String> categoryMap = new HashMap<>();
		categoryMap.put("D","디지털, 가전");
		categoryMap.put("H","가구, 인테리어");
		categoryMap.put("BY","유아동");
		categoryMap.put("L","생활, 가공식품");
		categoryMap.put("S","스포츠, 레저");
		categoryMap.put("W","여성의류, 여성잡화");
		categoryMap.put("M","남성의류, 남성잡화");
		categoryMap.put("G","게임, 취미");
		categoryMap.put("BT","뷰티, 미용");
		categoryMap.put("PET","반려동물용품");
		categoryMap.put("BK","도서");
		categoryMap.put("T","티켓");
		categoryMap.put("P","식물");
		categoryMap.put("E","기타");
		
		// 넘어온 카테고리로 해당 카테고리 이름 얻어옴
		String categoryName = categoryMap.get(category);
		
		
		m.addAttribute("categoryName", categoryName); //"category이름" 으로 검색된결과 뿌려줘야됨
		return "";
	}
}
