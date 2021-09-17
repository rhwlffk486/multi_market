package com.shopping.mall.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shopping.mall.vo.CartListVO;
import com.shopping.mall.vo.CategoryVO;
import com.shopping.mall.vo.OrderDetailVO;
import com.shopping.mall.vo.OrderVO;
import com.shopping.mall.vo.ProductVO;
import com.shopping.mall.vo.ReplyVO;
import com.shopping.mall.vo.ThumbnailVO;

@Repository
public class ProductDAO {

	@Autowired
	private SqlSession session;
	
	//　選択した製品を持ってくる
	public ArrayList<ProductVO> productShow(HashMap<String, Object> hash) {
		ArrayList<ProductVO> result = null;

		if (hash.get("cateCodeRef") != "") {
				try {
					ProductMapper mapper = session.getMapper(ProductMapper.class);
					result = mapper.productPshow(hash);// 選択した上位製品のリスト
				} catch (Exception e) {
					e.printStackTrace();
				}
				return result;
				
			  
		} else {
			try {
				ProductMapper mapper = session.getMapper(ProductMapper.class);
				result = mapper.productCshow(hash);//　選択した下位製品のリスト
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
	}
	
	//　製品の合計がいくつか数えるメソッド
	public int productCount(String cateCode, String cateCodeRef) {
		int result = 0;

		if (cateCodeRef != "") {
			try {
				ProductMapper mapper = session.getMapper(ProductMapper.class);
				result = mapper.productPcount(cateCodeRef);//　選択した上位製品の数
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		} else {
			try {
				ProductMapper mapper = session.getMapper(ProductMapper.class);
				result = mapper.productCcount(cateCode);//　選択した下位製品の数
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
	}
	
	// 商品検索
	public ArrayList<ProductVO> productSearch(HashMap<String, Object> hash) {
		ArrayList<ProductVO> product = null;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			product = mapper.productSearch(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return product;
		
	}
	
	// 検索した商品の数
	public int searchCount(HashMap<String, Object> hash) {
		int count=0;
		
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			count = mapper.searchCount(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	//　商品の詳細情報　＆　修正する製品
	public ProductVO productView(int productNum) {
		ProductVO vo = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			vo = mapper.productView(productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	//　カートに追加
	public int addCart(CartListVO cart) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.addCart(cart);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	//　コメント登録
	public boolean productReply(ReplyVO reply) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productReply(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result == 1) {
			return true;
		}
		return false;
	}
	
	//　コメントリスト
	public ArrayList<ReplyVO> replyList(HashMap<String, Object> hash) {
		ArrayList<ReplyVO> result = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.replyList(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//　コメントの削除
	public int deleteReply(int repNum) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.deleteReply(repNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	//　コメント修正
	public int modifyReply(ReplyVO reply) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.modifyReply(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	//　登録された商品＆登録された商品のもっと見る
	public ArrayList<ProductVO> myProduct(HashMap<String, Object> hash) {
		ArrayList<ProductVO> result = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.myProduct(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//　注文された製品のリスト
	public List<OrderVO> orderComesList(String userID) {
		
		List<OrderVO> OrderComesList = null;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			OrderComesList = mapper.orderComesList(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return OrderComesList;
	}
	
	//　製品登録するときのカテゴリー
	public ArrayList<CategoryVO> category() {
		ArrayList<CategoryVO> result = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.category();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//　商品登録
	public boolean productUpload(ProductVO productVO) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productUpload(productVO);
			if (result == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//　サムネイルとオリジナルイメージ登録
	public boolean productImg(ThumbnailVO thumVO) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productImg(thumVO);
			if (result == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//　製品修正
	public boolean productModify(ProductVO productVO) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productModify(productVO);
			if (result == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public ThumbnailVO productShowThum(int productNum) {
		ThumbnailVO result = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productShowThum(productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//　製品削除
	public int productDelete(int productNum) {
		int result = 0;
		
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productDelete(productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//　カートリスト
		public List<CartListVO> cartList(String userID) {
			List<CartListVO> cartList = null;

			try {
				ProductMapper mapper = session.getMapper(ProductMapper.class);
				cartList = mapper.cartList(userID);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return cartList;
		}

	public boolean productImgModify(ThumbnailVO thumVO) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.productImgModify(thumVO);
			if (result == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//　カートの製品削除
	public int deleteCart(CartListVO cart) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.deleteCart(cart);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	//　注文の明細書
	public boolean orderInfo(OrderVO order) {
		int result = 0;
		
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.orderInfo(order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return true;
		}
		return false;
	}

	//　詳しい注文の内容
	public boolean orderDetailsInfo(OrderDetailVO orderDetail) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.orderDetailsInfo(orderDetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return true;
		}
		return false;
	}

	//　すべてのカートリストの製品削除
	public void cartAllDelete(String userID) {
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			mapper.cartAllDelete(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//　注文した製品
	public List<OrderVO> orderList(String userID) {
		List<OrderVO> oderList = null;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			oderList = mapper.orderList(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return oderList;
	}
	
	//　返品した製品
	public List<OrderVO> refundOrderList(HashMap<String, String> hash) {
		List<OrderVO> list = null;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			list = mapper.refundOrderList(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//　注文した製品の詳しい内容のリスト
	public List<OrderVO> orderView(HashMap<String, Object> hash) {
		List<OrderVO> orderView = null;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			orderView = mapper.orderView(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderView;
	}
	
	//　orderViewからチェックした製品の返品要請	
	public int refundPlz(HashMap<String, Object> hash) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.refundPlz(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return result;
		}
		return result;
	}

	//　販売者：明細書の配送の状態に合わせて製品を持ってくる
	public List<OrderVO> orderDelivery(HashMap<String, Object> hash) {
		List<OrderVO> OrderComesList = null;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			OrderComesList = mapper.orderDelivery(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return OrderComesList;
	}
	
	// 販売者：配送の状態を決める
	public void deliveryInfo(HashMap<String, Object> hash) {

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			mapper.deliveryInfo(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 配送が完了すると注文が入った数分だけ製品から抜く
	public void productDown(ProductVO productVO) {
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			mapper.productDown(productVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//　返品完了
	public int refund(HashMap<String, Object> hash) {
		int result = 0;

		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			result = mapper.refund(hash);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return result;
		}
		return result;
	}

	//　当日入った製品をホームページに表示するメソッド
	public List<ProductVO> todayProduct(String date) {
		List<ProductVO> list = null;
		List<ProductVO> list2 = null;
		ArrayList<ProductVO> listJoin = new ArrayList<ProductVO>();
		
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			list = mapper.todayProduct(date);//　当日入った一般製品をホームページに表示するメソッド
			list2 = mapper.todayUsedProduct(date);//　当日入った中古品をホームページに表示するメソッド
			listJoin.addAll(list);
			listJoin.addAll(list2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listJoin;
	}
}
