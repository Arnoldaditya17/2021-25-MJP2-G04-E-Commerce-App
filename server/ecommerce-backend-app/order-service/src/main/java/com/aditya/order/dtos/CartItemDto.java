package com.aditya.order.dtos;

import lombok.Data;

@Data
public class CartItemDto {

	private String skuCode;

	private int quantity;

	private Double salePrice;

	private Double finalAmount;
}
