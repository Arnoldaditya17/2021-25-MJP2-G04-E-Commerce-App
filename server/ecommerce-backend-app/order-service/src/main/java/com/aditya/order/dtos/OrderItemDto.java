package com.aditya.order.dtos;

import com.aditya.order.enums.OrderStatus;
import lombok.Data;

import java.util.UUID;

@Data
public class OrderItemDto {

	private UUID id;

	private String skuCode;

	private int quantity;

	private Double marketPrice;

	private Double salePrice;

	private Double mrpGrossAmount;

	private Double spGrossAmount;

	private Double finalAmount;

	private Double totalDiscountAmount;

	private OrderStatus itemStatus;

	private UUID orderId;

	private String createdAt;

	private String updatedAt;
}
