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
	
	private SimpMessagingTemplate simpMessageTemplate;
	private ChatService chatService;
	
	@Autowired
	public ChatController(SimpMessagingTemplate simpMessagingTemplate, ChatService chatService) {
		this.simpMessageTemplate = simpMessagingTemplate;
		this.chatService = chatService;
	}
	
	@RequestMapping(value="/chat/{pNum}&{bUserid}&{sUserid}", method=RequestMethod.GET)
	public String productChatMessage(Model model, HttpSession session, 
			@PathVariable("pNum") String pNum,  @PathVariable("bUserid") String bUserid,
			@PathVariable("sUserid") String sUserid) throws IOException {
		
		if (session.getAttribute("login") == null) {
			return "redirect:/login";
		}
		
		System.out.println(pNum);
		System.out.println(sUserid);
		System.out.println(bUserid);
		
		return "chat/chatmessage";
	}
	
	/*
	 * @MessageMapping("/chat") public void send(ChatMessage chatMessage) throws
	 * IOException { ChatMessage chatMessageInfo =
	 * null;//chatService.appendMessage(chatMessage); String urlSubscribe =
	 * "/subscribe/" + chatMessageInfo.getChatid();
	 * simpMessageTemplate.convertAndSend(urlSubscribe, new
	 * ChatMessage(chatMessageInfo.getMessage(), chatMessageInfo.getFromname(),
	 * chatMessageInfo.getSendtime(), chatMessageInfo.getFromid())); }
	 */

	@RequestMapping(value="/chatList", method=RequestMethod.GET)
	public ModelAndView getChatList(HttpSession session) {
		ModelAndView mav = new ModelAndView("chat/chatList");
		return mav;
	}
	
	

}
