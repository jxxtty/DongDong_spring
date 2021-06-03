package com.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.dto.Alarm;
import com.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired
	SimpMessagingTemplate simpMessageTemplate;
	@Autowired
	AlarmService aService;
	
	@MessageMapping("/reply/{userid}")
	public Alarm sendAlarm(Alarm alarm) throws IOException{
		aService.newAlarm(alarm); // alarm DB에 데이터 쌓기
		String urlSubscribe = "/subscribe/alarm/"+alarm.getReceiver(); // receiver = 글작성자
		return alarm;
	}
}
