package com.shopping.mall.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.shopping.mall.dao.UserDAO;
import com.shopping.mall.vo.nomalUserVO;
import com.shopping.mall.vo.sellerUserVO;

@Service
public class UserService {

	@Autowired
	UserDAO dao;

	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	// ID重複検査
	public String idCheck(String userId) {
		return dao.idCheck(userId);
	}

	// 一般会員の登録
	public boolean nomalJoin(nomalUserVO nomalUser) {
		int result = dao.nomalJoin(nomalUser);

		switch (result) {
		case 1:
			return true;
		default:
			return false;
		}
	}
	
	// 企業会員の登録
	public boolean sellerJoin(sellerUserVO sellerUser) {
			int result = dao.sellerJoin(sellerUser);
			
			switch (result) {
			case 1:
				return true;
			default:
				return false;
			}
	}

	// 会員の情報変更
	public sellerUserVO updateInfo(sellerUserVO upUser) {
		return dao.updateInfo(upUser);
	}

	//　会員削除
	public boolean deleteUser(String userID) {
		return dao.deleteUser(userID);
	}
	
	// ID検索
	public ArrayList<String> findUserID(HashMap<String, String> hash) {
		return dao.findUserID(hash);
	}

	// PW検索
	public String findUserPW(HashMap<String, String> hash) {
		return dao.findUserPW(hash);
	}
	
	//　臨時暗証番号で変更
	public void newPW(HashMap<String, String> hash) {
		dao.newPW(hash);
	}
	
	//　ログイン
	public sellerUserVO login(String userID, String userPW) {
		return dao.login(userID, userPW);
	}

}
