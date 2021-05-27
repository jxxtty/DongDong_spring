package com.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.dto.GoogleOAuthRequest;
import com.dto.GoogleOAuthResponse;
import com.dto.KakaoProfileDTO;
import com.dto.MemberDTO;
import com.dto.OAuthTokenDTO;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
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
	
	
	@RequestMapping(value = "/google", method = RequestMethod.GET)
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode,HttpServletRequest request,HttpSession session)
			throws Exception {
		
		//HTTP Request를 위한 RestTemplate
		RestTemplate restTemplate = new RestTemplate();
 
		//Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleOAuthRequest googleOAuthRequestParam =  new GoogleOAuthRequest();
		googleOAuthRequestParam.setClientId("898782990200-vm6qpl53536ad2r2i8h65q7jme7ig993.apps.googleusercontent.com");
		googleOAuthRequestParam.setClientSecret("r-8T6achLwgybjvsrmiNdQMs");
		googleOAuthRequestParam.setCode(authCode);
		googleOAuthRequestParam.setRedirectUri("http://localhost:8079/google");
		googleOAuthRequestParam.setGrantType("authorization_code");
		
		//JSON 파싱을 위한 기본값 세팅
		//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);
 
		//AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token", googleOAuthRequestParam, String.class);
 
		//Token Request
		GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
		});
 
		//ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
		String jwtToken = result.getIdToken();
		//System.out.println("토큰은"+jwtToken);
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo").queryParam("id_token", jwtToken).toUriString();
		
		String resultJson = restTemplate.getForObject(requestUrl, String.class);
		
		Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
		model.addAllAttributes(userInfo);
		model.addAttribute("token", result.getAccessToken());
		//System.out.println("유저인포"+userInfo);
		//System.out.println("네임"+userInfo.get("name"));
		//System.out.println("메일"+userInfo.get("email"));
		String userid = "google_"+userInfo.get("name");
		String passwd = "google_"+userInfo.get("name");
		String username = userInfo.get("name");
		String email = userInfo.get("email");
		String nickName = "google_"+userInfo.get("name");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		
		MemberDTO dto = service.login(map);
		
		if(dto != null) {
			session.setAttribute("login", dto);
		}else { //회원정보 없으면 회원가입 진행
			MemberDTO newGoogle 
				= new MemberDTO(userid, passwd, username, nickName, "0", "0",email.split("@")[0],email.split("@")[1],"default_userImg.PNG");
			
			service.memberAdd(newGoogle);
			session.setAttribute("mesg", "회원가입이 완료되었습니다. 재로그인 후  Mypage에서 추가 정보를 입력해주세요");
			session.setAttribute("login", newGoogle);
		}
		
		return "redirect:/";
	}
	
	
	
}
