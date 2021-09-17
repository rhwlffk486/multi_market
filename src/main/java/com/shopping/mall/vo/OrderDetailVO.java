package com.shopping.mall.vo;

import lombok.Data;

@Data
public class OrderDetailVO {
	private int orderDetailsNum;
	private String orderID;
	private int productNum;
	private int productQty;
	private String userID;
	
	
}
