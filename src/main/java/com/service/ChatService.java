package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChatDAO;
import com.dto.ChatMessage;

@Service
public class ChatService{
	
	@Autowired
	ChatDAO dao;
	
	@Autowired
	PostService pService;

	public void appendMessage(ChatMessage chatMessage) {
		// TODO Auto-generated method stub
		
	}

	

}
