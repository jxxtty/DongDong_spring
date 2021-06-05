package com.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.Alarm;
import com.dto.MemberDTO;
import com.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired
	SimpMessagingTemplate simpMessageTemplate;
	@Autowired
	AlarmService aService;
	
	@MessageMapping("/reply/{userid}")
	public void sendAlarm(Alarm alarm) throws IOException{
		int aNumPK = aService.newAlarm(alarm); // alarm DB에 데이터 쌓고, 방금insert한 레코드의 PK값을 받아온다.
		alarm.setaNum(aNumPK);
		String urlSubscribe = "/subscribe/alarm/"+alarm.getReceiver(); // receiver = 글작성자
		simpMessageTemplate.convertAndSend(urlSubscribe, alarm);
	}
	
	
	@RequestMapping(value="/loginCheck/alarmDeleteOne", method=RequestMethod.GET)
	public String alarmDeleteOne(@RequestParam("aNum") String aNum, HttpSession session) {
		
		MemberDTO mDto = (MemberDTO)session.getAttribute("login");
		String userid = mDto.getUserid();
		Alarm aDto = aService.getAlarm(Integer.parseInt(aNum));
		
		if(userid.equals(aDto.getReceiver())) { // 로그인되어있는 회원과 해당알림을 받은 회원이 동일할때
			int n = aService.deleteAlarmOne(Integer.parseInt(aNum));
		}
		
		return "redirect:../loginCheck/myAlarm"; //내알림함으로 이동
	}
	
	@RequestMapping(value="/loginCheck/alarmReadOne", method=RequestMethod.GET)
	public String alarmReadOne(@RequestParam("aNum") String aNum, HttpSession session) {
		
		MemberDTO mDto = (MemberDTO)session.getAttribute("login");
		String userid = mDto.getUserid();
		Alarm aDto = aService.getAlarm(Integer.parseInt(aNum));
		
		if(userid.equals(aDto.getReceiver())) { // 로그인되어있는 회원과 해당알림을 받은 회원이 동일할때
			int n = aService.readAlarmOne(Integer.parseInt(aNum));
		}
		
		return "redirect:../loginCheck/myAlarm"; //내알림함으로 이동
	}
	
}
