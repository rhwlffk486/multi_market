package com.shopping.mall.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.shopping.mall.service.ProductService;
import com.shopping.mall.utils.Criteria;
import com.shopping.mall.utils.PageMaker;
import com.shopping.mall.utils.UploadFileUtils;
import com.shopping.mall.vo.CartListVO;
import com.shopping.mall.vo.CategoryVO;
import com.shopping.mall.vo.OrderDetailVO;
import com.shopping.mall.vo.OrderVO;
import com.shopping.mall.vo.ProductVO;
import com.shopping.mall.vo.ReplyVO;
import com.shopping.mall.vo.ThumbnailVO;
import com.shopping.mall.vo.sellerUserVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/shopping")
public class ProductController {

	@Autowired
	ProductService service;

	@Resource(name = "uploadPath")
	private String uploadPath;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);	
	
	// カテゴリーのメソッド
	@ModelAttribute("category")
	public Model category(Model model) {
		logger.info("category메소드 실행");
		List<CategoryVO> category = null;
		category = service.category();

		return model.addAttribute("category", JSONArray.fromObject(category));
	}
	
	// 商品選択のメソッド
	@RequestMapping(value = "product", method = RequestMethod.GET)
	public ModelAndView product(Criteria cri, @RequestParam("name") String name, @RequestParam("orderBy") String orderBy, Model model, HttpSession session) {
		logger.info("ModelAndView메소드 실행");
		ModelAndView mav = new ModelAndView();
		PageMaker pageMaker = new PageMaker();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		String cateCodeRef = "";// 上位製品のコード
		String cateCode = "";// 下位製品のコード
		int code;// コード
		String p;// ページナンバー
		
		//　商品の番号と何ページかを処理
		if (name.length() > 5) {
			String[]array = name.split("\\?");
			p = array[1].replaceAll("[^0-9]","");
			code = Integer.parseInt(array[0]);
			int page = Integer.parseInt(p);
			cri.setPage(page);
		} else {
			code = Integer.parseInt(name);
		}
		
		cri.setPage(cri.getPage());
		if (code % 10 == 0) {
			cateCodeRef = Integer.toString(code);
		} else {
			cateCode = Integer.toString(code);
		}

			hash.put("orderBy", orderBy); 
			hash.put("cateCode", cateCode);
			hash.put("cateCodeRef", cateCodeRef);
			hash.put("criteria", cri);
			
			ArrayList<ProductVO> product = service.productShow(hash);
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.productCount(cateCode, cateCodeRef));
			
			mav.addObject("product", product);
			mav.addObject("pageMaker", pageMaker);
			mav.addObject("name", Integer.toString(code));
			mav.addObject("orderBy", orderBy);
			mav.setViewName("/shopping/product");
			return mav;
	}
	
	// 商品検索のメソッド
	@RequestMapping(value = "productSearch", method = RequestMethod.GET)
	public ModelAndView productSearch(Criteria cri, @RequestParam("searchType")String searchType, @RequestParam("keyWord")String keyWord, @RequestParam("orderBy")String orderBy, Model model, HttpSession session) {
		logger.info("productSearch메소드 실행");
		ModelAndView mav = new ModelAndView();
		PageMaker pageMaker = new PageMaker();
		HashMap<String, Object> hash = new HashMap<String, Object>();

		hash.put("searchType", searchType);
		hash.put("keyWord", keyWord);
		hash.put("criteria", cri);
		hash.put("orderBy", orderBy);
		
		ArrayList<ProductVO> product = service.productSearch(hash);
		int count = service.searchCount(hash);

		pageMaker.setCri(cri);
		pageMaker.setTotalCount(count);
		
		mav.addObject("product", product);
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("searchType", searchType);
		mav.addObject("keyWord", keyWord);
		mav.addObject("select", cri.getPage());
		mav.setViewName("/shopping/productSearch");
		
		return mav;
	}
	
	//　商品の詳細情報のメソッド
	@RequestMapping(value = "productView", method = RequestMethod.GET)
	public ModelAndView productView(@RequestParam("n") int n, Model model, HttpSession session) {
		logger.info("productView메소드 실행");
		String userID = (String)session.getAttribute("userID");
		ModelAndView mav = new ModelAndView();
		int productNum = n;

		ProductVO viewVO = service.productView(productNum);
		
		if (userID == null) {
			mav.addObject("userID", "로그인");
		} else {
			mav.addObject("userID", userID);
		}
		mav.addObject("viewVO", viewVO);
		mav.setViewName("/shopping/productView");
		
		return mav;
	}

	//　カートに追加するメソッド
	@ResponseBody
	@RequestMapping(value = "addCart", method = RequestMethod.POST)
	public int addCart(CartListVO cart) {
		logger.info("addCart메소드 실행");
		int result = 0;
		
		if(cart.getUserID() != null) {
			result = service.addCart(cart);
		}
		
		return result;
	}
	
	// コメント登録のメソッド
	@ResponseBody
	@RequestMapping(value = "productReply", method = RequestMethod.POST)
	public String productReply(@ModelAttribute("reply") ReplyVO reply, HttpSession session) throws Exception {
		logger.info("productReply메소드 실행");
		String userID = (String)session.getAttribute("userID");
		reply.setUserID(userID);
		
		boolean result = service.productReply(reply);
		
		if (result) {
			String data = "success";
			return data;
		} else {
			return "fail";
		}
	}
	
	//　コメント持ってくるメソッド
	@ResponseBody
	@RequestMapping(value = "getReplyList", method = RequestMethod.GET)
	public List<ReplyVO> getReplyList(Model model, int productNum) {
		logger.info("getReplyList메소드 실행");
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		hash.put("productNum", productNum);
		hash.put("start", 1);
		hash.put("cnt", 10);
		ArrayList<ReplyVO> reply = service.replyList(hash);
		
		
		return reply;
	}
	
	//　コメントのもっと見るメソッド
	@ResponseBody
	@RequestMapping(value = "replyMore", method = RequestMethod.GET)
	public List<ReplyVO> replyMore(@ModelAttribute("startNum") int startNum, int productNum) throws Exception {
		logger.info("replyMore메소드 실행");
		int cnt = startNum + 10;
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		hash.put("productNum", productNum);
		hash.put("start", startNum);
		hash.put("cnt", cnt);
		
		List<ReplyVO> reply = service.replyList(hash);
		
		return reply;
	}
	
	// コメント修正のメソッド
	@ResponseBody
	@RequestMapping(value = "modifyReply", method = RequestMethod.POST)
	public int modifyReply(ReplyVO reply,  HttpSession session) throws Exception {
		logger.info("modifyReply메소드 실행");
		int result = service.modifyReply(reply);
		
		return result;
	}
	
	//　コメントの削除のメソッド
	@ResponseBody
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	public int deleteReply(ReplyVO reply,  HttpSession session) throws Exception {
		logger.info("deleteReply메소드 실행");
		int result = service.deleteReply(reply.getRepNum());
		
		return result;
	}
	
	//　商品の管理のメソッド
	@RequestMapping(value = "productMGR", method = RequestMethod.GET)
	public ModelAndView productMGR(HttpSession session, Model model) {
		logger.info("productMGR메소드 실행");
		ModelAndView mav = new ModelAndView();
		String userID = (String)session.getAttribute("userID");
		HashMap<String, Object> hash = new HashMap<String, Object>();
		HashMap<String, String> hash2 = new HashMap<String, String>();
		
		hash.put("userID", userID);
		hash.put("start", 1);
		hash.put("cnt", 5);
		
		hash2.put("userID", userID);
		
		ArrayList<ProductVO> product = service.myProduct(hash);// 同録された商品
		List<OrderVO> OrderComesList = service.orderComesList(userID);//　注文が入った商品
		
		mav.addObject("myProduct", product);
		mav.addObject("OrderComesList", OrderComesList);
		mav.setViewName("/shopping/productMGR");
		return mav;
	}
	
	//　同録された製品のもっと見るメソッド
	@ResponseBody
	@RequestMapping(value = "myProductMore", method = RequestMethod.POST)
	public ArrayList<ProductVO> myProductMore(@ModelAttribute("startNum") int startNum, HttpSession session) throws Exception {
		logger.info("myProductMore메소드 실행");
		String userID = (String)session.getAttribute("userID");
		int cnt = startNum + 5;
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		//　５個ずつ持ってくる
		hash.put("userID", userID);
		hash.put("start", startNum);
		hash.put("cnt", cnt);
		
		ArrayList<ProductVO> product = service.myProduct(hash);
		return product;
	}
	
	//　製品登録ページのメソッド＆製品登録するとき必要なカテゴリーのメソッド
	@RequestMapping(value = "productUpload", method = RequestMethod.GET)
	public String productUpload(Model model, HttpSession session) {
		logger.info("productUpload페이지메소드 실행");
		ArrayList<CategoryVO> category = service.category();
		
		sellerUserVO userVO = (sellerUserVO)session.getAttribute("userVO");
		
		model.addAttribute(userVO);
		model.addAttribute("category", JSONArray.fromObject(category));
		return "/shopping/productUpload";
	}
	
	// 製品登録のメソッド
	@RequestMapping(value = "productUpload", method = RequestMethod.POST)
	public String productUpload(RedirectAttributes redirect, HttpSession session, @RequestParam MultipartFile productImg, String role, String category1,
			String category2, String category3, String productTitle, String productQty, String content,
			String productPrice) throws IOException, Exception {
		logger.info("productUpload메소드 실행");
		int price = Integer.parseInt(productPrice.replaceAll(",", ""));//　製品の価格処理
		int qty = Integer.parseInt(productQty.replaceAll(",", ""));//　製品の数量処理
		String userID = (String)session.getAttribute("userID");
		ProductVO productVO = new ProductVO();
		
		productVO.setRole(role);
		productVO.setProductID(userID);
		if (category3 == null) {
			productVO.setProductTitle(productTitle);
		} else {
			productVO.setProductTitle("사이즈는" + category3 + ": " + productTitle);//　製品がファッションだったらタイトルにサイズをつける
		}
		productVO.setCateCode(category2);
		productVO.setProductPrice(price);
		productVO.setProductQty(qty);
		productVO.setProductContent(content);

		//　サムネイルのイメージ
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (productImg != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, productImg.getOriginalFilename(),
					productImg.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}
		
		ThumbnailVO thumVO = new ThumbnailVO();
		thumVO.setOriginalImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		thumVO.setThumbNail(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		thumVO.setProductID(userID);
		productVO.setProductImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		boolean result1 = service.productUpload(productVO);//　商品登録
		boolean result2 = service.productImg(thumVO);//　サムネイルとオリジナルイメージ登録
		
		if (result1 && result2) {
			redirect.addFlashAttribute("productUpload", 1);//　商品登録に成功したらホームページに戻る
			return "redirect:/";
		} else {
			redirect.addFlashAttribute("productUpload", 2);//　商品登録に失敗したらproductUploadページで処理
			return "redirect:/shopping/productUpload";
		}
	}
	
	// 製品登録するときsummernoteで作成したコンテンツ処理のメソッド
	@ResponseBody
	@RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		logger.info("uploadSummernoteImageFile메소드 실행");
		JsonObject jsonObject = new JsonObject();
		String fileRoot = "C:\\summernote_image\\";
		String originalFileName = multipartFile.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		String savedFileName = UUID.randomUUID() + extension;
		File targetFile = new File(fileRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", "/summernote_image/" + savedFileName);
			jsonObject.addProperty("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		String a = jsonObject.toString();
		
		return a;
	}

	// 製品修正ページのメソッド
	@RequestMapping(value = "myProductView", method = RequestMethod.GET)
	public ModelAndView myProductView(@RequestParam("n") int n, HttpSession session) {
		logger.info("myProductView메소드 실행");
		ModelAndView mav = new ModelAndView();
		int productNum = n;
		
		ProductVO productVO = service.productView(productNum);//　修正する製品
		ThumbnailVO thum = service.productShowThum(productNum);//　修正する製品のサムネイル

		session.setAttribute("productModify", productVO);
		session.setAttribute("thumModify", thum);
		
		mav.addObject("thumModify", thum);
		mav.addObject("productVO", productVO);
		mav.setViewName("/shopping/myProductView");
		
		return mav;
	}

	//　製品修正のメソッド
	@RequestMapping(value = "productModify", method = RequestMethod.POST)
	public String productModify(HttpServletRequest request, @RequestParam MultipartFile productImg,
			@RequestParam("productNum") int productNum, String category1, String category2, String category3,
			String productTitle, String productQty, String content, String productPrice)
			throws IOException, Exception {
		logger.info("productModify메소드 실행");
		HttpSession session = request.getSession();
		ProductVO productModifyVO = (ProductVO) session.getAttribute("productModify");
		int price = Integer.parseInt(productPrice.replaceAll(",", ""));
		int qty = Integer.parseInt(productQty.replaceAll(",", ""));
		ProductVO productVO = new ProductVO();
		
		if (category3 == null) {
			productVO.setProductTitle(productTitle);
		} else {
			productVO.setProductTitle("사이즈는" + category3 + ": " + productTitle);
		}
		productVO.setProductNum(productNum);
		productVO.setCateCode(category2);
		productVO.setProductPrice(price);
		productVO.setProductQty(qty);
		productVO.setProductContent(content);
		productVO.getProductImg();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (productImg != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, productImg.getOriginalFilename(),
					productImg.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}
		productVO.setProductImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		ThumbnailVO thumVO = new ThumbnailVO();
		thumVO.setOriginalImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		thumVO.setThumbNail(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		if (productModifyVO.getProductImg() == thumVO.getThumbNail()) {
			new File(uploadPath + request.getParameter("productImg")).delete();
			new File(uploadPath + request.getParameter("thumbNail")).delete();
		}
		thumVO.setProductNum(productNum);

		boolean result = service.productModify(productVO);//　製品修正
		if (result) {
			return "redirect:/";
		} else {
			return "redirect:/shopping/myProductView";
		}
	}
	
	//　製品削除のメソッド
	@ResponseBody
	@RequestMapping(value = "productDelete", method = RequestMethod.GET)
	public String productDelete(@RequestParam("n") int n) throws Exception {
		logger.info("productDelete메소드 실행");
		int productNum = n;
		String result3;
		
		// 商品が削除されるとcascadeという一貫性制約で構成されたサムネイルも同時に削除される。
		boolean result = service.productDelete(productNum);//　製品削除

		if (result) {
			result3 = "success";
			return result3;
		} else {
			result3 = "fail";
			return result3;
		}
	}
	
	//　カートリストのメソッド
	@RequestMapping(value = "cartList", method = RequestMethod.GET)
	public ModelAndView cartList(HttpSession session) {
		logger.info("cartList메소드 실행");
		ModelAndView mav = new ModelAndView();
		
		String userID = (String)session.getAttribute("userID");
		List<CartListVO> cartList = service.cartList(userID);//　カートリスト
		
		if(cartList.size() > 0) {
			mav.addObject("cartList", cartList);
			mav.setViewName("/shopping/cartList");
		} else {
			mav.addObject("noCart", "장바구니가 비어있습니다.");
			mav.setViewName("/shopping/cartList");
		}
		
		return mav;
	}
	
	//　カートの製品削除のメソッド
	@ResponseBody
	@RequestMapping(value = "deleteCart", method = RequestMethod.POST)
	public int deleteCart(HttpSession session, @RequestParam(value = "check_box[]")List<String> chArr, CartListVO cart) {
		logger.info("deleteCart메소드 실행");
		String userID = (String)session.getAttribute("userID");
		int result = 0;
		int cartNum = 0;
		
		if(userID != null) {
			cart.setUserID(userID);
			for(String i : chArr) {
				cartNum = Integer.parseInt(i);
				cart.setCartNum(cartNum);
				result = service.deleteCart(cart);//　カートの製品削除
				if(result != 1) {
					return result;//　削除に失敗するとの処理
				}
			}
		}
		
		return result;
	}
	
	//　決済が終わったら実行する注文のメソッド
	@ResponseBody
	@RequestMapping(value = "order", method = RequestMethod.POST)
	public String order(RedirectAttributes redirect, HttpSession session, OrderVO orderVO) {
		logger.info("order메소드 실행");
		OrderDetailVO orderDetail = new OrderDetailVO();
		String userID = (String)session.getAttribute("userID");
		//　注文の明細書
		String uuid = UUID.randomUUID().toString();
		String rep = uuid.replaceAll("-", "");
		String orderID = rep.substring(0, 10);
		
		orderVO.setOrderID(orderID);
		orderVO.setUserID(userID);
		orderDetail.setOrderID(orderID);
		orderDetail.setUserID(userID);
		
		boolean result1 = service.orderInfo(orderVO);//　注文の明細書
		boolean result2 = service.orderDetailsInfo(orderDetail);//　詳しい注文の内容

		if(result1==true&&result2==true) {
			service.cartAllDelete(userID);//　すべてのカートリストの製品削除
			redirect.addFlashAttribute("orderResult",  1);
			String result = "y";
			return result;
		} else {
			redirect.addFlashAttribute("orderResult", 2);
			return "redirect:/shopping/cartList";
		}
		
	}
	
	//　注文した製品の明細書の状態のメソッド
	@RequestMapping(value = "orderComplete", method = RequestMethod.GET)
	public ModelAndView orderComplete(HttpSession session) {
		logger.info("orderComplete메소드 실행");
		ModelAndView mav = new ModelAndView();
		String userID = (String)session.getAttribute("userID");

		HashMap<String, String> hash = new HashMap<String, String>();
		
		hash.put("userID", userID);
		hash.put("productInfo", "환불요청");
		
		List<OrderVO> orderList = service.orderList(userID);//　注文した製品
		List<OrderVO> refundOrderList = service.refundOrderList(hash);//　返品した製品
		
		mav.addObject("orderList", orderList);
		mav.addObject("refundOrderList", refundOrderList);
		mav.setViewName("/shopping/orderComplete");
		
		return mav;
	}
	
	//　注文した明細書の詳しい製品の内容のメソッド
	@RequestMapping(value = "orderView", method = RequestMethod.GET)
	public ModelAndView orderView(@RequestParam("n")String orderID, @RequestParam("productInfo")String productInfo, HttpSession session) {
		logger.info("orderView메소드 실행");
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		hash.put("orderID", orderID);
		hash.put("productInfo", productInfo);//　製品の配送の状態に合わせて製品を出力する
		
		List<OrderVO> orderViewVO = service.orderView(hash);//　注文した製品の詳しい内容のリスト
		
		mav.addObject("orderViewVO", orderViewVO);
		mav.setViewName("/shopping/orderView");
		
		return mav;
	}
	
	//　製品の返品要請のメソッド
	@ResponseBody
	@RequestMapping(value = "refundPlz", method = RequestMethod.POST)
	public int refundPlz(Model model,  @RequestParam String jsonData) {
		logger.info("refundPlz메소드 실행");
		JSONArray array = JSONArray.fromObject(jsonData);
		HashMap<String, Object> hash = new HashMap<String, Object>();

		int result = 0;
		
		for(int i=0; i<array.size(); i++) {
			
			JSONObject obj = (JSONObject)array.get(i);

			hash.put("productNum", obj.get("productNum"));
			hash.put("orderID", obj.get("orderID"));
			hash.put("productInfo", obj.get("productInfo"));
			
			result = service.refundPlz(hash);//　orderViewからチェックした製品の返品要請
		}
		return result;
	}
	
	//　販売者：明細書の配送の状態に合わせて製品を持ってくるページ
	@RequestMapping(value = "delivery", method = RequestMethod.GET)
	public ModelAndView delivery(HttpSession session, Model model, @RequestParam("orderID") String orderID, @RequestParam("productInfo") String productInfo) {
		logger.info("delivery메소드 실행");
		ModelAndView mav = new ModelAndView();
		String userID = (String)session.getAttribute("userID");
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		hash.put("userID", userID);// どのような販売者か
		hash.put("orderID", orderID);//　どのような明細書か
		hash.put("productInfo", productInfo);//　製品の配送の状態に合わせて持ってくる
		
		List<OrderVO> orderDelivery = service.orderDelivery(hash);//　販売者：明細書の配送の状態に合わせて製品を持ってくる
		mav.addObject("orderDelivery", orderDelivery);
		mav.setViewName("/shopping/delivery");
		
		return mav;
	}
	
	// 配送の状態を決定するメソッド
	@RequestMapping(value = "deliveryInfo", method = RequestMethod.POST)
	public String deliveryInfo(HttpSession session, String delivery, String orderID) {
		logger.info("deliveryInfo메소드 실행");
		HashMap<String, Object> hash = new HashMap<String, Object>();
		String userID = (String)session.getAttribute("userID");
		
		hash.put("userID", userID);
		hash.put("productInfo", delivery);
		hash.put("orderID", orderID);
		service.deliveryInfo(hash);// 配送の状態を決める
		
		
		if (delivery.equals("배송완료")) {
			List<OrderVO> orderVO = service.orderView(hash);//　注文が入った製品を持ってきて
			ProductVO productVO = new ProductVO();
			
			for (OrderVO i : orderVO) {
				productVO.setProductNum(i.getProductNum());
				productVO.setProductQty(i.getProductQty());
				service.productDown(productVO);//　配送が完了すると注文が入った数分だけ製品から抜く
			}
		}
		
		return "redirect:/shopping/productMGR";
	}
	
	// 返品完了メソッド
	@ResponseBody
	@RequestMapping(value = "refund", method = RequestMethod.POST)
	public int refund(Model model,  @RequestParam String jsonData) {
		logger.info("refund메소드 실행");
		JSONArray array = JSONArray.fromObject(jsonData);
		HashMap<String, Object> hash = new HashMap<String, Object>();
		int result = 0;
		
		
		System.out.println(array);
		
		for(int i=0; i<array.size(); i++) {
			JSONObject obj = (JSONObject)array.get(i);

			hash.put("productNum", obj.get("productNum"));
			hash.put("productQty", obj.get("productQty"));
			hash.put("orderID", obj.get("orderID"));

			result = service.refund(hash);//　返品完了すると製品の数を返品された数分だけ増加
			
			hash.put("productInfo", obj.get("refund"));
			service.refundPlz(hash);//　購入者に返品完了の処理
			if(result != 1) {
				return result;
			}
		}
		
		/*
		 * for(int i=0; i<array.size(); i++) { JSONObject obj =
		 * (JSONObject)array.get(i); String numQty = (String) obj.get("productNum");
		 * String array1 []; array1 = numQty.split(","); int productNum =
		 * Integer.parseInt(array1[0]); int productQty = Integer.parseInt(array1[1]);
		 * 
		 * hash.put("productNum", productNum); hash.put("productQty", productQty);
		 * hash.put("orderID", obj.get("orderID"));
		 * 
		 * result = service.refund(hash);// 返品完了すると製品の数を返品された数分だけ増加
		 * 
		 * hash.put("productInfo", obj.get("refund")); service.refundPlz(hash);//
		 * 購入者に返品完了の処理 if(result != 1) { return result; } }
		 */
			return result;
	}
	
	//　当日入った製品をホームページに表示するメソッド
	@ResponseBody
	@RequestMapping(value = "todayProduct", method = RequestMethod.POST)
	public List<ProductVO> todayProduct(Model model, @RequestParam("day")Date day) {
		logger.info("todayProduct메소드 실행");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yy/MM/dd");
		String date = format1.format(day);
		List<ProductVO> list = service.todayProduct(date);//　当日入った製品をホームページに表示するメソッド
		
		model.addAttribute("todayProduct", list);
		return list;
	}
}
