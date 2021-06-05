package com.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAO {
	
	@Autowired
	SqlSessionTemplate template;
	
	public int checkFile(String chatId) {
		return template.selectOne("OrderSheetMapper.checkChatRoom", chatId);
	}

	public void createRoom(HashMap<String, String> map) {
		System.out.println(map);
		template.insert("OrderSheetMapper.createChatRoom", map);
	}
	
	

}
