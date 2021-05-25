package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dto.OrderSheetDTO;
import com.service.OrderSheetService;
@Controller
public class OrderController {
	
	
	@RequestMapping(value = "/AddOrderSheet", method =RequestMethod.GET)
	public String AddOrderSheet(int pNum, String sUserid, String bUserid
						, String oAddr, int oPrice, String oMessage) {
		
		OrderSheetDTO dto = new OrderSheetDTO();
		dto.setpNum(pNum);
		dto.setsUserid(sUserid);
		dto.setbUserid(bUserid);
		dto.setoAddr(oAddr);
		dto.setoPrice(oPrice);
		dto.setoMessage(oMessage);
		
		OrderSheetService service = new OrderSheetService();
		int num = service.OrderSheetAdd(dto);
		
		return "redirect:/orderEndSheet";
	}
	
}
