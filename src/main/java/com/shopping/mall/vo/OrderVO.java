package com.shopping.mall.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private String orderID;
	private String userID;
	private String orderATTN;
	private String address1;
	private String address2;
	private String address3;
	private String orderPhone;
	private int amount;
	private Date orderDate;
	
	private int orderDetailsNum;
	private int productNum;
	private int productQty;
	private String productInfo;
	
	private String productTitle;
	private String productImg;
	private int productPrice;
	private String productID;
}
