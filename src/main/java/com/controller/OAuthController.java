package com.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dto.KakaoProfileDTO;
import com.dto.MemberDTO;
import com.dto.OAuthTokenDTO;
import com.google.gson.Gson;
import com.service.MemberService;

@Controller
public class OAuthController {
	
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/kakao")
	public String kakaoLogin(String code, HttpSession session) {
		String pUrl = "https://kauth.kakao.com/oauth/token";
		//System.out.println(code);
		
		String bodyData="grant_type=authorization_code&";
		bodyData += "client_id=9516c7a8850f5616c0e63b831800b6a9&";
		bodyData += "redirect_uri=http://localhost:8079/kakao&";
		bodyData += "code="+code;
		
		try {
			URL url = new URL(pUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setDoOutput(true);
	        
	        BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));
			bw.write(bodyData);
			bw.flush();
	        
			BufferedReader br = new BufferedReader(
					new InputStreamReader(conn.getInputStream(), "UTF-8")
					);
			String input="";
			StringBuilder sb=new StringBuilder();
			while((input=br.readLine())!=null){
				sb.append(input);
			}
			
			Gson gson=new Gson();
			
			OAuthTokenDTO oAuthToken=gson.fromJson(sb.toString(), OAuthTokenDTO.class);
			
			//profile 받기(Resource Server)
			String endpoint2="https://kapi.kakao.com/v2/user/me";
			URL url2 =new URL(endpoint2);
			
			HttpsURLConnection conn2=(HttpsURLConnection)url2.openConnection();
			
			//header 값 넣기
			conn2.setRequestProperty("Authorization", "Bearer "+oAuthToken.getAccess_token());
			conn2.setDoOutput(true);
			
			//request 하기
			BufferedReader br2=new BufferedReader(new InputStreamReader(conn2.getInputStream(),"UTF-8"));
			String input2="";
			StringBuilder sb2=new StringBuilder();
			while((input2=br2.readLine())!=null) {
				sb2.append(input2);
			}
			
			//System.out.println("sb2.toString() : "+sb2.toString());
			
			Gson gson2=new Gson();
			KakaoProfileDTO kakaoProfile=gson2.fromJson(sb2.toString(), KakaoProfileDTO.class);
			
			
			//로그인 하기
			String userid = kakaoProfile.getId() + "_kakao";
			String passwd = kakaoProfile.getId();
			String nickName = "익명" + kakaoProfile.getId();
			String email = kakaoProfile.getKakao_account().getEmail();
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", userid);
			map.put("passwd", passwd);
			
			MemberDTO dto = service.login(map);
			
			if(dto != null) {
				session.setAttribute("login", dto);
			}else { //회원정보 없으면 회원가입 진행
				MemberDTO newMem 
					= new MemberDTO(userid, passwd, "0", nickName, "0", "0",email.split("@")[0],email.split("@")[1],"default_userImg.PNG");
				
				service.memberAdd(newMem);
				session.setAttribute("mesg", "회원가입이 완료되었습니다. 재로그인 후  Mypage에서 추가 정보를 입력해주세요");
				session.setAttribute("login", newMem);
			}
			
			return "redirect:/";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/loginForm";
		
	}
}
