package com.aditya.payment.controller;

import com.aditya.payment.services.RazorpayService;
import com.razorpay.Refund;
import com.razorpay.RazorpayException;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/payment")
public class RazorpayController {

	private final RazorpayService razorpayService;

	public RazorpayController(RazorpayService razorpayService) {
		this.razorpayService = razorpayService;
	}

	@PostMapping("/order")
	public ResponseEntity<?> createOrder(@RequestBody Map<String, Object> data) {
		try {
			int amount = (int) data.get("amount");
			String currency = (String) data.get("currency");

			JSONObject order = razorpayService.createOrder(amount, currency);
			return ResponseEntity.ok(order.toString());
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("Order creation failed");
		}
	}

	@PostMapping("/verify")
	public ResponseEntity<?> verifyPayment(@RequestBody Map<String, String> data) {
		boolean isValid = razorpayService.verifySignature(
				data.get("order_id"),
				data.get("payment_id"),
				data.get("razorpay_signature")
		);

		return isValid ? ResponseEntity.ok("Payment verified") : ResponseEntity.badRequest().body("Invalid signature");
	}

	@PostMapping("/refund")
	public ResponseEntity<?> refund(@RequestBody Map<String, Object> data) {
		try {
			String paymentId = (String) data.get("paymentId");
			int amount = (int) data.get("amount");

			Refund refund = razorpayService.processRefund(paymentId, amount);
			return ResponseEntity.ok(refund.toJson().toString());
		} catch (RazorpayException e) {
			return ResponseEntity.badRequest().body("Refund failed");
		}
	}
}
