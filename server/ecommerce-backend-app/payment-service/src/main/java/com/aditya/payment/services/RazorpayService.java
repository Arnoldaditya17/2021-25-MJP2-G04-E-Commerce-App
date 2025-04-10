package com.aditya.payment.services;

import com.razorpay.*;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

@Service
public class RazorpayService {

	@Value("${rzp_key_id}")
	private String keyId;

	@Value("${rzp_key_secret}")
	private String secret;

	public JSONObject createOrder(int amount, String currency) throws RazorpayException {
		RazorpayClient razorpay = new RazorpayClient(keyId, secret);

		JSONObject orderRequest = new JSONObject();
		orderRequest.put("amount", amount * 100); // Convert to smallest unit (e.g., INR -> Paisa)
		orderRequest.put("currency", currency);
		orderRequest.put("receipt", "txn_" + System.currentTimeMillis());
		orderRequest.put("payment_capture", 1);

		Order order = razorpay.orders.create(orderRequest);
		return order.toJson();
	}

	public boolean verifySignature(String orderId, String paymentId, String razorpaySignature) {
		try {
			String payload = orderId + "|" + paymentId;
			Mac sha256Hmac = Mac.getInstance("HmacSHA256");
			SecretKeySpec secretKey = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
			sha256Hmac.init(secretKey);
			String expectedSignature = Base64.getEncoder().encodeToString(sha256Hmac.doFinal(payload.getBytes()));

			return expectedSignature.equals(razorpaySignature);
		} catch (Exception e) {
			return false;
		}
	}

	public Refund processRefund(String paymentId, int amount) throws RazorpayException {
		RazorpayClient razorpay = new RazorpayClient(keyId, secret);

		JSONObject refundRequest = new JSONObject();
		refundRequest.put("amount", amount * 100); // Convert to smallest unit
		refundRequest.put("speed", "optimum");

		return razorpay.payments.refund(paymentId, refundRequest);
	}
}
