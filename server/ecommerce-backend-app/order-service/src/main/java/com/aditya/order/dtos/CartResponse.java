package com.aditya.order.dtos;

import lombok.Data;

import java.util.List;
import java.util.UUID;

@Data
public class CartResponse {

	private UUID id;

	private Double finalBillAmount;

	private Double totalDiscountAmount;

	private Double grossAmount;

	private List<CartItemDto> items;

	private String status;

}
