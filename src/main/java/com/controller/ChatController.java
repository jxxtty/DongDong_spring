package com.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.dto.ChatMessage;
import com.dto.ChatRoom;
import com.dto.MemberDTO;
import com.service.ChatService;

@Controller
public class ChatController {

	private SimpMessagingTemplate simpMessageTemplate;
	private ChatService cService;

	@Autowired
	public ChatController(SimpMessagingTemplate simpMessageTemplate, ChatService cService) {
		super();
		this.simpMessageTemplate = simpMessageTemplate;
		this.cService = cService;
	}

	// 채팅 접속
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chatMessage(Model model, HttpSession session, String pNum, String bUserid, String sUserid)
			throws IOException {
		// 로그인 여부 확인
		if (session.getAttribute("login") == null) {
			return "redirect:/login";
		}

		String chatId = pNum + bUserid + sUserid;
		String chatHistory = chatId + ".txt";

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("chatId", chatId);
		map.put("chatHistory", chatHistory);
		map.put("bUserid", bUserid);
		map.put("sUserid", sUserid);

		List<String> lines = new ArrayList<String>();

		if (cService.checkFile(chatId)) { // 채팅방 없으면 히스토리 생성
			cService.creatRoom(map);
		} else { // 채팅방 있으면 히스토리 가져오기
			try {
				// 파일 객체 생성
				File file = new File("C:/chatHistory/" + chatId + ".txt");
				// 입력 스트림 생성
				FileReader fr = new FileReader(file);
				// 입력 버퍼 생성
				BufferedReader br = new BufferedReader(fr);
				String line = "";
				while ((line = br.readLine()) != null) {
					lines.add(line);
				}
				// .readLine()은 끝에 개행문자를 읽지 않는다.
				model.addAttribute("lines", lines);
				br.close();
			} catch (FileNotFoundException e) {
				// TODO: handle exception
			} catch (IOException e) {
				System.out.println(e);
			}

		}

		model.addAttribute("chatId", chatId);

		return "chat/chatMessage";
	}

	@MessageMapping("/chatMessage")
	public void send(ChatMessage chatMessage) throws IOException {
		cService.appendMessage(chatMessage);
		// System.out.println(chatMessage);
		String urlSubscribe = "/subscribe/" + chatMessage.getChatId();
		simpMessageTemplate.convertAndSend(urlSubscribe, chatMessage);
	}
	

	@RequestMapping(value = "/chatList", method = RequestMethod.GET)
	public ModelAndView getChatList(HttpSession session) {
		//chatRoom 정보 긁어와서 모델에 보내주기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = mDTO.getUserid();
		List<ChatRoom> list = cService.getChatList(userid);
		ModelAndView mav = new ModelAndView("chat/chatList");
		mav.addObject("chatList", list);
		return mav;
	}

}
