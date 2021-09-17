package com.shopping.mall.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mall.dao.ProductDAO;
import com.shopping.mall.vo.CartListVO;
import com.shopping.mall.vo.CategoryVO;
import com.shopping.mall.vo.OrderDetailVO;
import com.shopping.mall.vo.OrderVO;
import com.shopping.mall.vo.ProductVO;
import com.shopping.mall.vo.ReplyVO;
import com.shopping.mall.vo.ThumbnailVO;

@Service
public class ProductService {

	@Autowired
	private ProductDAO dao;
	
	//　選択した製品リストを持ってくる
	public ArrayList<ProductVO> productShow(HashMap<String, Object> hash) {
		return dao.productShow(hash);
	}
	
	//　製品の合計がいくつか数える
	public int productCount(String cateCode, String cateCodeRef) {
		return dao.productCount(cateCode, cateCodeRef);
	}
	
	// 商品検索
	public ArrayList<ProductVO> productSearch(HashMap<String, Object> hash) {
		return dao.productSearch(hash);
	}
	
	// 検索した商品の数
	public int searchCount(HashMap<String, Object> hash) {
		return dao.searchCount(hash);
	}
	
	// 商品の詳細情報　＆　修正する製品
	public ProductVO productView(int productNum) {
		return dao.productView(productNum);
	}
	
	//　カートに追加
	public int addCart(CartListVO cart) {
		return dao.addCart(cart);
	}
	
	//　コメント登録
	public boolean productReply(ReplyVO reply) {
		 return dao.productReply(reply);
	}

	//　コメントもえってくる
	public ArrayList<ReplyVO> replyList(HashMap<String, Object> hash) {
		return dao.replyList(hash);
	}

	//　コメントの削除
	public int deleteReply(int repNum) {
		return dao.deleteReply(repNum);
	}
	
	//　コメント修正
	public int modifyReply(ReplyVO reply) {
		return dao.modifyReply(reply);
	}
	
	//　登録された商品＆登録された商品のもっと見る
	public ArrayList<ProductVO> myProduct(HashMap<String, Object> hash) {
		return dao.myProduct(hash);
	}
	
	//　注文された製品リスト
	public List<OrderVO> orderComesList(String userID) {
		return dao.orderComesList(userID);
	}
	
	//　製品登録するときのカテゴリー
	public ArrayList<CategoryVO> category() {
		return dao.category();
	}
	
	//　商品登録
	public boolean productUpload(ProductVO productVO) {
		return dao.productUpload(productVO);
	}

	//　サムネイルとオリジナルイメージ登録
	public boolean productImg(ThumbnailVO thumVO) {
		return dao.productImg(thumVO);
	}
	
	//　サムネイルを持ってくる
	public ThumbnailVO productShowThum(int productNum) {
		return dao.productShowThum(productNum);
	}
	
	// 製品修正
	public boolean productModify(ProductVO productVO) {
		return dao.productModify(productVO);
	}
	
	public boolean productImgModify(ThumbnailVO thumVO) {
		return dao.productImgModify(thumVO);
	}

	//　製品削除
	public boolean productDelete(int productNum) {
		int result = dao.productDelete(productNum);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	
	// カートリスト
	public List<CartListVO> cartList(String userID) {
		return dao.cartList(userID);
	}
	
	//　カートの製品削除
	public int deleteCart(CartListVO cart) {
		return dao.deleteCart(cart);
	}

	//　注文の明細書
	public boolean orderInfo(OrderVO order) {
		return dao.orderInfo(order);
	}
	
	//　詳しい注文の内容
	public boolean orderDetailsInfo(OrderDetailVO orderDetail) {
		return dao.orderDetailsInfo(orderDetail);
	}

	//　すべてのカートリストの製品削除
	public void cartAllDelete(String userID) {
		dao.cartAllDelete(userID);
	}

	//　注文した製品
	public List<OrderVO> orderList(String userID) {
		return dao.orderList(userID);
	}
	
	//　返品した製品
	public List<OrderVO> refundOrderList(HashMap<String, String> hash) {
		return dao.refundOrderList(hash);
	}

	//　注文した製品の詳しい内容のリスト
	public List<OrderVO> orderView(HashMap<String, Object> hash) {
		return dao.orderView(hash);
	}

	//　注文リストからチェックした製品の返品要請
	public int refundPlz(HashMap<String, Object> hash) {
		return dao.refundPlz(hash);
	}
	
	//　販売者：明細書の配送の状態に合わせて製品を持ってくる
	public List<OrderVO> orderDelivery(HashMap<String, Object> hash) {
		return dao.orderDelivery(hash);
	}
	
	// 配送の状態を決める
	public void deliveryInfo(HashMap<String, Object> hash) {
		 dao.deliveryInfo(hash);
	}
	
	//　配送が完了すると注文が入った数分だけ製品から抜く
	public void productDown(ProductVO productVO) {
		dao.productDown(productVO);
	}
	
	//　返品完了	
	public int refund(HashMap<String, Object> hash) {
		return dao.refund(hash);
	}

	//　当日入った製品をホームページに表示するメソッド
	public List<ProductVO> todayProduct(String date) {
		return dao.todayProduct(date);
	}

	/*
	 * public List<OrderVO> refundOrderView(HashMap<String, Object> hash) { return
	 * dao.refundOrderView(hash); }
	 * 
	 * 
	 * 
	 * public List<OrderVO> refundDelivery(HashMap<String, Object> hash) { return
	 * dao.refundDelivery(hash); }
	 */
	
	



}
