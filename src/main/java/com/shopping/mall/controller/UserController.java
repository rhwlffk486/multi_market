package com.shopping.mall.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.shopping.mall.service.ProductService;
import com.shopping.mall.service.UserService;
import com.shopping.mall.vo.CategoryVO;
import com.shopping.mall.vo.nomalUserVO;
import com.shopping.mall.vo.sellerUserVO;

import net.sf.json.JSONArray;



@Controller
@RequestMapping(value="/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	UserService service;
	
	@Autowired
	ProductService Pservice;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value = "/home", method=RequestMethod.GET)
	public String home() {
		
		return "home";	
	}

	
	// カテゴリーのメソッド
	@ModelAttribute("category")
	public Model category(Model model) {
		logger.info("category메소드 실행");
		List<CategoryVO> category1 = null;
		List<CategoryVO> category2 = null;
		
		category1 = Pservice.category1();
		category2 = Pservice.category2();
		
		System.out.println("category1" + category1);
		System.out.println("category2" + category2);
		
		model.addAttribute("category1", category1);
		model.addAttribute("category2", category2);
		
		return model;
	}
	 
	
	// 会員登録ページに移動
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String join() {
		logger.info("join페이지 메소드 실행");
		return "/user/join";
	}
	
	// 一般会員ページに移動
	@RequestMapping(value="nomalJoin", method=RequestMethod.GET)
	public String nomalJoin() {
		logger.info("nomalJoin페이지 메소드 실행");
		return "/user/nomalJoin";
	}
	
	// 企業ページに移動
	@RequestMapping(value="sellerJoin", method=RequestMethod.GET)
	public String sellerJoin() {
		logger.info("sellerJoin페이지 메소드 실행");
		return "/user/sellerJoin";
	}
	
	// ID重複検査
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public String idCheck(String userID) {
		logger.info("idCheck 메소드 실행");
		String idCheck = service.idCheck(userID);
		String result = "yes";

		if (idCheck != null) {
			result = "no";
		}
		return result;
	}
	
	// 加入
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String Join(RedirectAttributes redirect, String role, 
			String userName, String userID, String userPW, String phone, 
			String userAddress1, String userAddress2, String userAddress3, 
			String email, String businessNumber, String BKname, String account) {
		logger.info("Join 메소드 실행");
		String pw = pwdEncoder.encode(userPW);
		sellerUserVO sellerUser = new sellerUserVO();
		nomalUserVO nomalUser = new nomalUserVO();
		
		// 一般会員の登録と企業会員の登録
		if (role.equals("중고")) {
			nomalUser.setRole(role);
			nomalUser.setUserName(userName);
			nomalUser.setUserID(userID);
			nomalUser.setUserPW(pw);
			nomalUser.setPhone(phone);
			nomalUser.setAddress1(userAddress1);
			nomalUser.setAddress2(userAddress2);
			nomalUser.setAddress3(userAddress3);
			nomalUser.setEmail(email);
			boolean result = service.nomalJoin(nomalUser);
			
			if (result) {
				redirect.addFlashAttribute("joinResult", 1);
				return "redirect:/";
			} else {
				redirect.addFlashAttribute("result", 2);
				return "redirect:/user/nomalJoin";
			} 
		} else {
			sellerUser.setRole(role);
			sellerUser.setUserName(userName);
			sellerUser.setUserID(userID);
			sellerUser.setUserPW(pw);
			sellerUser.setPhone(phone);
			sellerUser.setAddress1(userAddress1);
			sellerUser.setAddress2(userAddress2);
			sellerUser.setAddress3(userAddress3);
			sellerUser.setEmail(email);
			sellerUser.setBusinessNumber(businessNumber);
			sellerUser.setBank(BKname);
			sellerUser.setAccountNumber(account);
			boolean result = service.sellerJoin(sellerUser);
			
			if (result) {
				redirect.addFlashAttribute("joinResult", 1);
				return "redirect:/";
			} else {
				redirect.addFlashAttribute("result", 2);
				return "redirect:/user/sellerJoin";
			}
		}
		
	}
	
	//　会員ページに移動
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String mypage(HttpSession session, Model model) {
		logger.info("mypage페이지 메소드 실행");
		return "/user/mypage";
	}
	
	// 一般会員の情報変更
	@RequestMapping(value="nomalUpdate", method=RequestMethod.GET)
	public String nomalUpdate() {
		logger.info("nomalUpdate페이지 메소드 실행");
		return "/user/nomalUpdate";
	}
	
	// 企業会員の情報変更
	@RequestMapping(value="sellerUpdate", method=RequestMethod.GET)
	public String sellerUpdate() {
		logger.info("sellerUpdate페이지 메소드 실행");
		return "/user/sellerUpdate";
	}	
	
	// 会員の情報変更
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(HttpSession session, RedirectAttributes redirect, 
		   String role, String userPW, String phone, String userAddress1, 
		   String userAddress2, String userAddress3, String email, 
		   String businessNumber, String BKname, String account) {
		logger.info("udate 메소드 실행");
		sellerUserVO upUser = new sellerUserVO();
		String userID = (String) session.getAttribute("userID");
		String pw = pwdEncoder.encode(userPW);
		
		upUser.setUserID(userID);
		upUser.setRole(role);
		upUser.setUserPW(pw);
		upUser.setPhone(phone);
		upUser.setAddress1(userAddress1);
		upUser.setAddress2(userAddress2);
		upUser.setAddress3(userAddress3);
		upUser.setEmail(email);
		upUser.setBusinessNumber(businessNumber);
		upUser.setBank(BKname);
		upUser.setAccountNumber(account);
		
		upUser = service.updateInfo(upUser);// 会員の情報変更
		
		if (upUser.getUserPW()=="n") {
			redirect.addFlashAttribute("result", 0);
			return "redirect:/user/nomalUpdate";
		} else {
			redirect.addFlashAttribute("result", 2);
			session.invalidate();
			return "redirect:/";
		}
			
	}

	//　会員削除
	@RequestMapping(value="deleteUser", method=RequestMethod.GET)
	public String deleteUser(HttpSession session, RedirectAttributes redirect) {
		logger.info("deleteUser 메소드 실행");
		String userID = (String)session.getAttribute("userID");
		
		boolean result = service.deleteUser(userID);//　会員削除
		
		if (result) {
			session.invalidate();
			return "redirect:/";
		} else {
			redirect.addFlashAttribute("result", 3);
			return "redirect:/user/mypage";
		}
		
	}
	
	//　会員の情報検索のページに移動
	@RequestMapping(value="findUserInfo", method=RequestMethod.GET)
	public String findUserInfo() {
		logger.info("findUserInfo페이지 메소드 실행");
		return "/user/findUserInfo";
	}
	
	// ID検索
	@RequestMapping(value="findID", method=RequestMethod.POST)
	public String findID(RedirectAttributes redirect, String userName, String email) throws Exception {
		logger.info("findID 메소드 실행");
		HashMap<String, String> hash = new HashMap<String, String>();
		
		hash.put("userName", userName);
		hash.put("email", email);
		
		ArrayList<String> userIDarr = service.findUserID(hash);// ID検索
		
		for (int i=0; i<userIDarr.size(); i++) {
			hash.put("user_ID" + i, userIDarr.get(i));
		}
		
		if (userIDarr.isEmpty()) {
			
			redirect.addFlashAttribute("msg", 2);
			return "redirect:/user/findUserInfo";
			
		} else {
			
			sendEmail(userIDarr, hash, "findID");
			redirect.addFlashAttribute("msg", 1);
			return "redirect:/";
			
		}
	}
	
	
	// PW検索
	@RequestMapping(value="findPW", method=RequestMethod.POST)
	public String findPW(RedirectAttributes redirect, String userID, String email) throws Exception {
		logger.info("findPW 메소드 실행");
		HashMap<String, String> hash = new HashMap<String, String>();
		System.out.println(userID);
		System.out.println(email);
		hash.put("userID", userID);
		hash.put("email", email);
		
		String result = service.findUserPW(hash);// PW検索
		System.out.println(result);
		
		if (userID.equals(result)) {
			String temporaryPW = RandomStringUtils.randomAlphanumeric(10);// 臨時暗証番号
			String newPW = pwdEncoder.encode(temporaryPW);
			hash.put("newPW", newPW);
			hash.put("temporaryPW", temporaryPW); 
			
			service.newPW(hash);//　臨時暗証番号で変更
			sendEmail(null, hash, "findpw");//　臨時暗証番号を会員のメールに送る
		} else {
			redirect.addFlashAttribute("msg", 3);
		
			return "redirect:/user/findUserInfo";
		}
		redirect.addFlashAttribute("msg", 4);
		
		return "redirect:/";
	}
	
	//　IDとPW検索結果物メールに送る	
	public void sendEmail(ArrayList<String> userIDarr, HashMap<String, String> hash, String div) throws Exception {
		logger.info("sendEmail 메소드 실행");
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "rhwlffk486@gmail.com";
		String hostSMTPpwd = "Dlxogns65143!";
		
		String fromEmail = "rhwlffk486@gmail.com";
		String fromName = "멀티마켓";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "멀티마켓 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += hash.get("userID") + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += hash.get("temporaryPW") + "</p></div>";
		} else {
			subject = "멀티마켓 아이디 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += "<p>귀하의 아이디 : ";
			msg += userIDarr + "</p></div>";
		}

		String mail = hash.get("email");
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
		
	}
	
	//　ログイン
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(Model model, HttpSession session, String userID, String userPW) {
		logger.info("login 메소드 실행");
		sellerUserVO vo = service.login(userID, userPW);//　ログイン
		
		if (vo!=null&&vo.getUserID().equals("n")==false) {
			session.setAttribute("userVO", vo);
			session.setAttribute("userID", vo.getUserID());
			return "redirect:/";
		} else {
			model.addAttribute("result", 1);
			return "/home";
		}
	}
	
	//　ログアウト
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		logger.info("logout 메소드 실행");
		session.invalidate();
		return "redirect:/";
	}
	
}
