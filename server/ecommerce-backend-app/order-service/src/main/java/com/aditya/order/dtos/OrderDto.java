package com.aditya.order.dtos;

import com.aditya.order.enums.OrderStatus;
import lombok.Data;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Data
public class OrderDto {

	private UUID id;

	private UUID userId;

	private Date orderDate;

	private Double mrpGrossAmount;

	private Double spGrossAmount;

	private Double totalDiscountAmount;

	private Double finalBillAmount;

	private String paymentMethod;

	private OrderStatus status;

	private String razorPayOrderId;

	private int active;

	private int itemCount;

	private List<OrderItemDto> orderItems;

}
