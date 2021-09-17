package com.shopping.mall.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ProductVO {
	private int productNum;
	private String role;
	private String productID;
	private String cateCode;
	private String productTitle;
	private int productPrice;
	private int productQty;
	private String productImg;
	private String productContent;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date productDate;
	private String cateName;
    private String cateCodeRef;
}
