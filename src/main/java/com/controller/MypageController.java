package com.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.dto.MyOrderSheetDTO;
import com.dto.PostDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.FavoriteService;
import com.service.MemberService;
import com.service.OrderSheetService;
import com.service.PostService;
import com.service.TransactionService;

@Controller
public class MypageController {
	@Autowired
	MemberService mService;
	@Autowired
	FavoriteService fService;
	@Autowired
	PostService pService;
	@Autowired
	OrderSheetService oService;
	@Autowired
	TransactionService tService;
	
	
	
	@RequestMapping(value = "/loginCheck/mypage")
	public String myPage(HttpSession session) {
		//System.out.println("myPage호출====");
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid(); //세션에서 id 얻기
		dto= mService.mypage(userid);
		session.setAttribute("login", dto);
		return "redirect:../mypage"; // 주소에 해당하는 페이지를 servlet-context에 등록사용
		//return "mypage";// 주소에 해당하는 페이지를 servlet-context에 등록사용
	}//mypage
	
	@RequestMapping(value = "/loginCheck/MemberUpdate", produces = "text/plain;charset=UTF-8") 
	public String memberUpdate(HttpServletRequest request, HttpSession session) throws IOException {
		MemberDTO mdto =(MemberDTO)session.getAttribute("login");
		String path = "c://images/profile"; // 업로드할 위치
		int maxSize = 1024*1024*10; //업로드 받을 최대 크기 -> 10mb
		String enc = "UTF-8";
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy(); // 덮어씌우기 방지(같은이름방지)
		MultipartRequest multi = new MultipartRequest(request,path,maxSize,enc,policy);
		
		// user가 프로필사진을 변경한 경우 새로운 이미지파일 이름을받아온다.
		String fileName = multi.getFilesystemName("photo");
		//String originFileName = multi.getOriginalFileName("photo");
		
		// 기존 이미지파일을 받아온다.
		String basicFile = multi.getParameter("basic_photo");
		
		String userid = multi.getParameter("userid");
		String passwd = mdto.getPasswd(); // mypage.jsp에서 넘겨주는 값이 없어서 dto에서 뽑아왔어요!(어차피 수정되는부분이아니라 null들어가도 상관없긴함)
		String username = multi.getParameter("username");
		
		String nickName = multi.getParameter("resultNick");
		String addr = multi.getParameter("addr");
		String phone = multi.getParameter("phone");
		String email1 = multi.getParameter("email1");
		String email2 = multi.getParameter("email2");
		String userImage = "";
		if(fileName == null) {
			// 새로들어온 파일이 없는경우 --> user가 프로필사진은 변경하지 않은경우
			userImage = basicFile;
		} else {
			// 새로들어온 파일이 있는경우 --> user가 프로필사진을 변경한 경우
			userImage = fileName;
		}
		MemberDTO dto2 =
				new MemberDTO(userid,passwd,username,nickName,
						addr,phone,email1,email2,userImage);
		
		mService.memberUpdate(dto2);
		session.setAttribute("mesg", "회원정보가 수정되었습니다."); 
		return "redirect:../loginCheck/mypage";
	}//memberUpdate
	
	
	@RequestMapping(value = "/loginCheck/confirmNickC", produces = "text/plain;charset=UTF-8")
	public String confirmNick(@RequestParam("nickName") String nickName, Model m) {
		int n = mService.nickCheck(nickName);
		m.addAttribute("nickCheck", n);
		m.addAttribute("nickName", nickName);
		return "confirmNick";
	}//닉네임체크  중복확인
	
	@RequestMapping(value = "/loginCheck/nickUpdate", produces = "text/plain;charset=UTF-8")
	public String nickUpdate(@RequestParam("nickName") String nickName, HttpSession session, Model m) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		MemberDTO dto2 = new MemberDTO();
		dto2.setUserid(dto.getUserid());
		dto2.setNickName(nickName);
		dto2.setAddr(dto.getAddr());
		dto2.setEmail1(dto.getEmail1());
		dto2.setEmail2(dto.getEmail2());
		dto2.setPasswd(dto.getPasswd());
		dto2.setPhone(dto.getPhone());
		dto2.setUserimage(dto.getUserimage());
		dto2.setUsername(dto.getUsername());
		mService.nickUpdate(dto2);
		
		m.addAttribute("nickDTO", dto2.getNickName());
		return "okNick";
	}//닉네임 업데이트
	
	@RequestMapping(value = "/loginCheck/addrCheckC", produces = "text/plain;charset=UTF-8")
	public String addrCheck(@RequestParam("dong") String addr, HttpSession session, Model m) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		String userName = dto.getUsername();
		MemberDTO dto2 = new MemberDTO();
		dto2.setUsername(userName);
		dto2.setUserid(userid);
		dto2.setAddr(addr);
		int n = mService.addrAuth1(dto2);//db에저장된 주소랑 같은지 확인
		if(n==1) {
			m.addAttribute("auth1", addr);
		}else {
			 n = mService.addrAuth2(dto2);//현재위치로 주소 변경
			 m.addAttribute("auth2", addr);
		}
		return "addrauth";
	}//동네 인증
	
	@RequestMapping(value = "/loginCheck/Withdrawal")
	public String withdrawal(HttpSession session, Model m) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		mService.withdrawal(userid);
		session.setAttribute("withdrawal", "정상적으로 회원탈퇴되었습니다."); 
		return "main";
	}//회원탈퇴
	
	@RequestMapping(value = "loginCheck/FavoriteList", produces = "text/plain;charset=UTF-8")
	public String favoritList(HttpSession session,RedirectAttributes attr) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<PostDTO> list = fService.favoriteList(userid);
		attr.addFlashAttribute("favoriteList", list);
		return "redirect:../favoriteList";
	}//관심목록 리스트
	
	@RequestMapping(value = "loginCheck/favoriteDel")
	public String favoriteDel(@RequestParam("num") int num, HttpSession session) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		fService.favoriteDel(num);
		return "redirect:/loginCheck/FavoriteList";
	}//관심목록 개별삭제
	
	@RequestMapping(value = "loginCheck/MyPostList", produces = "text/plain;charset=UTF-8")
	public String mypostList(HttpSession session, RedirectAttributes attr) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<PostDTO> list = pService.mypostList(userid);
		attr.addFlashAttribute("mypostList", list);
		return "redirect:../mypostList";
	}//내 게시물 보기
	
	@RequestMapping(value = "loginCheck/MyOrdersheetList", produces = "text/plain;charset=UTF-8")
	public String MyOrdersheetList(HttpSession session, Model m) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<MyOrderSheetDTO> list = oService.myordersheetList(userid);
		m.addAttribute("ordersheetList", list);
		return "myordersheetList";
	}// 주문서 발신함
	
	@RequestMapping(value = "/loginCheck/myOrderDel")
	public String myOrderDel(@RequestParam("oNum") int num) {
		oService.orderDel(num);
		return "redirect:/loginCheck/MyOrdersheetList";
	}// 발신함 개별삭제
	
	@RequestMapping(value = "/loginCheck/myOrderDelAll")
	public String myOrderDelAll(@RequestParam("data") String data) {
		String [] x = data.split(",");
		List<String> list = Arrays.asList(x);
		oService.orderAllDel(list);
		return "redirect:/loginCheck/MyOrdersheetList";
	}// 발신함 체크삭제
	
	@RequestMapping(value = "loginCheck/OrdersheetList", produces = "text/plain;charset=UTF-8")
	public String OrdersheetList(HttpSession session, Model m) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<MyOrderSheetDTO> list = oService.ordersheetList(userid);
		m.addAttribute("ordersheetList", list);
		return "ordersheetList";
	}// 주문서 수신함
	
	@RequestMapping(value = "/loginCheck/OrderDel")
	public String OrderDel(@RequestParam("oNum") int num) {
		oService.orderDel(num);
		return "redirect:/loginCheck/OrdersheetList";
	}// 수신함 개별삭제
	
	@RequestMapping(value = "/loginCheck/OrderDelAll")
	public String OrderDelAll(@RequestParam("data") String data) {
		String [] x = data.split(",");
		List<String> list = Arrays.asList(x);
		oService.orderAllDel(list);
		return "redirect:/loginCheck/OrdersheetList";
	}// 수신함 체크삭제
	
	@RequestMapping(value = "/loginCheck/myPopupMessage", produces = "text/plain;charset=UTF-8")
	public String myPopupMessage(@RequestParam("oNum") String oNum, Model m) {
		List<MyOrderSheetDTO> list = oService.message(oNum);
		System.out.println(list);
		int saleCount = tService.saleCount(list.get(0).getbUserid());
		m.addAttribute("saleCount", saleCount);
		m.addAttribute("message", list);
		return "mypopupmessage";
	}//myPopupMessage 
	
	@RequestMapping(value = "/loginCheck/PopupMessage", produces = "text/plain;charset=UTF-8")
	public String PopupMessage(@RequestParam("oNum") String oNum, Model m) {
		List<MyOrderSheetDTO> list = oService.message(oNum);
		int saleCount = tService.saleCount(list.get(0).getbUserid());
		m.addAttribute("saleCount", saleCount);
		m.addAttribute("message", list);
		return "popupmessage";
	}//PopupMessage
	
	@RequestMapping(value = "/loginCheck/myPopupOrderDel")
	public String myPopupOrderDel(@RequestParam("oNum") int num, @RequestParam("popup") Integer popup) {
		oService.orderDel(num);
		if(popup == null) {
			return "loginCheck/MyOrdersheetList";
		}else {
			return "popupclose";
		}
	}// 메세지창에서 삭제(발신)  테스트해야함
	
	@RequestMapping(value = "/loginCheck/PopupOrderDel")
	public String PopupOrderDel(@RequestParam("oNum") int num, @RequestParam("popup") Integer popup) {
		oService.orderDel(num);
		if (popup == null) {
			return "loginCheck/OrdersheetList";
		} else {
			return "popupclose";
		}
	}// 메세지창에서 삭제(수신)  테스트해야함
	
	@RequestMapping(value = "/loginCheck/Sale")
	public String sale(@RequestParam("bUserid") String bUserid, 
			@RequestParam("sUserid") String sUserid, @RequestParam("pNum") int pNum,
			RedirectAttributes attr) {
		int n = oService.sale(bUserid, sUserid, pNum);
		attr.addFlashAttribute("sale", n);
		return "redirect:../salecomplete";
	}//구매확정  테스트해야함
	
	@RequestMapping(value = "loginCheck/BuyList", produces = "text/plain;charset=UTF-8")
	public String buyList(HttpSession session, RedirectAttributes attr) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<PostDTO> plist = tService.purchaseList(userid);
		attr.addFlashAttribute("purchaseList", plist);
		return "redirect:../BuyList";
	}//구매내역 
	
	@RequestMapping(value = "loginCheck/SaleList", produces = "text/plain;charset=UTF-8")
	public String saleList(HttpSession session, RedirectAttributes attr) {
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid();
		List<PostDTO> slist = tService.saleList(userid);
		attr.addFlashAttribute("saleList", slist);
		return "redirect:../SaleList";
	}//판매내역  
	
	
	
	
}//mService