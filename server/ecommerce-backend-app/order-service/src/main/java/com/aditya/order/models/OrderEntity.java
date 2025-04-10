package com.aditya.order.models;

import com.aditya.order.constants.OrderConstants;
import com.aditya.order.enums.OrderStatus;
import com.aditya.user.models.User;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.DynamicUpdate;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Entity
@Data
@Table(name = OrderConstants.ORDER_TABLE_NAME)
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class OrderEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	private UUID id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id", nullable = false)
	private User user;

	@Column(name = "order_date")
	private Date orderDate;

	@Column(name = "mrp_gross_amount")
	private Double mrpGrossAmount = 0d;

	@Column(name = "sp_gross_amount")
	private Double spGrossAmount = 0d;

	@Column(name = "total_discount_amount")
	private Double totalDiscountAmount = 0d;

	@Column(name = "final_bill_amount")
	private Double finalBillAmount = 0d;

	@Column(name = "payment_method")
	private String paymentMethod;

	@Enumerated(EnumType.STRING)
	private OrderStatus status;

	@Column(name = "razor_pay_order_id")
	private String razorPayOrderId;

	@Column(name = "active", columnDefinition = "int default 1")
	private int active;

	@Column(name = "item_count")
	private int itemCount;

	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "shipping_address_id")
	private ShippingAddress shippingAddress;

	@OneToMany(mappedBy = "orderEntity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<OrderItemEntity> orderItems = new ArrayList<>();

}
