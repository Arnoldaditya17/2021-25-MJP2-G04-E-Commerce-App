import 'package:e_commerce_application_ui/features/payment/razorpay_api_provider.dart';
import 'package:e_commerce_application_ui/features/payment/service/payment_service.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final RazorpayApiProvider razorpayApi = RazorpayApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Payment')),
      body: Center(
        child:  ElevatedButton(
          onPressed: () async {
            try {
              print("🛒 Initiating Payment...");

              // 🔄 Step 1: Create Order
              final orderData = await razorpayApi.createOrder(50000, "INR");

              // 🚀 Step 2: Open Razorpay Checkout
              razorpayApi.openRazorpay(orderData);
            } catch (e) {
              print("❌ Payment Error: $e");
            }
          },
          child: Text("Pay Now"),
        ),
      ),
    );
  }
}
