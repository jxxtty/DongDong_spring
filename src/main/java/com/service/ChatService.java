package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChatDAO;

@Service
public class ChatService{
	
	@Autowired
	ChatDAO dao;
	
	@Autowired
	PostService pService;
	

}
