package com.shopping.mall.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shopping.mall.vo.CartListVO;
import com.shopping.mall.vo.CategoryVO;
import com.shopping.mall.vo.OrderDetailVO;
import com.shopping.mall.vo.OrderVO;
import com.shopping.mall.vo.ProductVO;
import com.shopping.mall.vo.ReplyVO;
import com.shopping.mall.vo.ThumbnailVO;

public interface ProductMapper {
	
	//　選択した上位商品のリスト
	ArrayList<ProductVO> productPshow(HashMap<String, Object> hash);

	//　選択した下位商品のリスト
	ArrayList<ProductVO> productCshow(HashMap<String, Object> hash);
	
	// 選択した上位商品の数
	int productPcount(String cateCodeRef);
	
	// 選択した下位商品の数
	int productCcount(String cateCode);

	// 商品検索
	ArrayList<ProductVO> productSearch(HashMap<String, Object> hash);

	// 検索した商品の数
	int searchCount(HashMap<String, Object> hash);
	
	//　商品の詳細情報　＆　修正する商品
	ProductVO productView(int productNum);
	
	//　カートに追加
	int addCart(CartListVO cart);

	//　コメント同録
	int productReply(ReplyVO reply);
	
	//　コメントリスト
	ArrayList<ReplyVO> replyList(HashMap<String, Object> hash);
	
	//　コメント修正
	int modifyReply(ReplyVO reply);
	
	//　コメントの削除
	int deleteReply(int repNum);
	
	//　登録された商品＆登録された商品のもっと見る
	ArrayList<ProductVO> myProduct(HashMap<String, Object> hash);

	//　注文された商品のリスト
	List<OrderVO> orderComesList(String userID);

	//　商品登録するときのカテゴリー
	ArrayList<CategoryVO> category();
	
	//　商品登録するときのカテゴリー
	ArrayList<CategoryVO> category1();
	
	//　商品登録するときのカテゴリー
	ArrayList<CategoryVO> category2();
	
	//　商品登録
	int productUpload(ProductVO productVO);
	
	//　サムネイルとオリジナルイメージ登録
	int productImg(ThumbnailVO thumVO);
	
	//　商品修正
	int productModify(ProductVO productVO);

	ThumbnailVO productShowThum(int productNum);
	
	//　商品削除
	int productDelete(int productNum);
	
	//　カートリスト
	List<CartListVO> cartList(String userID);
	
	//　カートの商品削除
	int deleteCart(CartListVO cart);
	
	//　注文の明細書
	int orderInfo(OrderVO order);

	//　詳しい注文の内容
	int orderDetailsInfo(OrderDetailVO orderDetail);

	//　すべてのカートリストの商品削除
	void cartAllDelete(String userID);

	//　注文した商品
	List<OrderVO> orderList(String userID);

	//　返品した商品
	List<OrderVO> refundOrderList(HashMap<String, String> hash);
	
	//　注文した商品の詳しい内容のリスト
	List<OrderVO> orderView(HashMap<String, Object> hash);

	//　orderViewからチェックした商品の返品要請	
	int refundPlz(HashMap<String, Object> hash);
	
	//　販売者：明細書の配送の状態に合わせて商品を持ってくる
	List<OrderVO> orderDelivery(HashMap<String, Object> hash);

	// 配送の状態を決める
	void deliveryInfo(HashMap<String, Object> hash);
	
	//　配送が完了すると注文が入った数分だけ商品から抜く
	void productDown(ProductVO productVO);

	//　返品完了
	int refund(HashMap<String, Object> hash);
	
	//　当日入った一般商品をホームページに表示するメソッド
	List<ProductVO> todayProduct(String date);
	
	//　当日入った中古品をホームページに表示するメソッド
	List<ProductVO> todayUsedProduct(String date);

	int productImgModify(ThumbnailVO thumVO);
}
