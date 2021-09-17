package com.shopping.mall.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.shopping.mall.vo.nomalUserVO;
import com.shopping.mall.vo.sellerUserVO;

@Repository
public class UserDAO {

	@Autowired
	SqlSession session;

	@Autowired
	BCryptPasswordEncoder pwdEncoder;

	// ID重複検査
	public String idCheck(String userId) {
		String result = null;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.idCheck(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 一般会員の登録
	public int nomalJoin(nomalUserVO nomalUser) {
		int result = 0;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.nomalJoin(nomalUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 企業会員の登録
	public int sellerJoin(sellerUserVO sellerUser) {
		int result = 0;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.sellerJoin(sellerUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 会員の情報変更
	public sellerUserVO updateInfo(sellerUserVO upUser) {
		sellerUserVO result = null;
		int up = 0;
		String role = upUser.getRole();
		
		try {
			if (role.equals("중고")) {
				UserMapper mapper = session.getMapper(UserMapper.class);
				up = mapper.nupdateInfo(upUser);// 一般会員の情報を変更
				result = mapper.getInfo(upUser.getUserID());// 会員の情報を持ってくる
				if (up < 1) {
					result.setUserPW("n");//　変更に失敗したら暗証番号を"ｎ"で処理（誰でも暗証番号を分かられないようにするため）
				}
			} else {
				UserMapper mapper = session.getMapper(UserMapper.class);
				up = mapper.gupdateInfo(upUser);// 企業の情報を変更
				result = mapper.getInfo(upUser.getUserID());//　会員の情報を持ってくる
				if (up < 1) {
					result.setUserPW("n");//　変更に失敗したら暗証番号を"ｎ"で処理（誰でも暗証番号を分かられないようにするため）
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//　会員削除
	public boolean deleteUser(String userID) {
		int result = 0;

		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.deleteUser(userID);
			
			if (result == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// ID検索
	public ArrayList<String> findUserID(HashMap<String, String> hash) {
		ArrayList<String> result = null;
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.findUserID(hash);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// PW検索
	public String findUserPW(HashMap<String, String> hash) {
		String result = null;
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.findUserPW(hash);// PW検索

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//　臨時暗証番号で変更
	public void newPW(HashMap<String, String> hash) {
		
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			mapper.newPW(hash);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//　ログイン
	public sellerUserVO login(String userID, String userPW) {
		sellerUserVO result = null;
		try {
			UserMapper mapper = session.getMapper(UserMapper.class);
			result = mapper.login(userID);//　ログイン
			boolean check = pwdEncoder.matches(userPW, result.getUserPW());//　pwdEncoderで構成されているのでデータベースにある暗証番号を解いて比べなければならない

			if (check) {
				result.setUserPW("");//　誰でも暗証番号を分かられないようにするため
			} else {
				result.setUserID("n");//　暗証番号が間違ったらの処理
				result.setUserPW("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
