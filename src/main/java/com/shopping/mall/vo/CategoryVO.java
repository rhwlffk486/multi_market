package com.shopping.mall.vo;

import lombok.Data;

@Data
public class CategoryVO {
	private String cateName;
    private String cateCode;
    private String cateCodeRef;
    private int level;
}
