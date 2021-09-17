package com.shopping.mall.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CartListVO {
	private int cartNum;
	private String userID;
	private int productNum;
	private int productQty;
	private Date addDate;
	
	private int num;
	private String productTitle;
	private int productPrice;
	private String productImg;
	private String productID;
}
