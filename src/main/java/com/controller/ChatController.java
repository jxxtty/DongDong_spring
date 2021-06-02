package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.ChatMessage;
import com.dto.ChatRoom;
import com.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	SimpMessagingTemplate simpMessageTemplate;
	
	@Autowired
	ChatService cService;
	
	//채팅 접속
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String productChatMessage(Model model, HttpSession session, int pNum, String bUserid, String sUserid)
			throws IOException {
		//로그인 여부 확인
		if (session.getAttribute("login") == null) {
			return "redirect:/login";
		}
		return "chat/chatMessage";
	}

	@MessageMapping("/chatMessage")
	public void send(ChatMessage chatMessage) throws IOException {
		cService.appendMessage(chatMessage);
		String urlSubscribe = "/subscribe/" + chatMessage.getChatId();
		simpMessageTemplate.convertAndSend(urlSubscribe, new ChatMessage(chatMessage.getUserId(), chatMessage.getMessage(), 
				chatMessage.getSendTime(), chatMessage.getChatId()));
	}

	@RequestMapping(value = "/chatList", method = RequestMethod.GET)
	public ModelAndView getChatList(HttpSession session) {
		ModelAndView mav = new ModelAndView("chat/chatList");
		return mav;
	}

}
