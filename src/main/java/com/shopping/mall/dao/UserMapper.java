package com.shopping.mall.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.shopping.mall.vo.nomalUserVO;
import com.shopping.mall.vo.sellerUserVO;

public interface UserMapper {

	// ID重複検査
	String idCheck(String userId);

	// 一般会員の登録
	int nomalJoin(nomalUserVO nomalUser);

	// 企業会員の登録
	int sellerJoin(sellerUserVO sellerUser);

	// 一般会員の情報を変更
	int nupdateInfo(sellerUserVO upUser);

	// 企業の情報を変更
	int gupdateInfo(sellerUserVO upUser);

	//　会員の情報を持ってくる
	sellerUserVO getInfo(String userID);

	//　会員削除
	int deleteUser(String userID);

	// ID検索
	ArrayList<String> findUserID(HashMap<String, String> hash);

	// PW検索
	String findUserPW(HashMap<String, String> hash);
	
	//　臨時暗証番号で変更
	void newPW(HashMap<String, String> hash);
	
	//　ログイン
	sellerUserVO login(String userID);
	
}
