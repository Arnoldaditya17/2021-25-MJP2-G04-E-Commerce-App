import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dio/dio.dart';

class PaymentService {
  final Razorpay _razorpay = Razorpay();
  final Dio _dio = Dio();
  final String serverBaseUrl = "http://192.168.29.10/api/payment";

  PaymentService() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> createOrder(int amount, String currency) async {
    print("Creating order...");
    try {
      final response = await _dio.post("$serverBaseUrl/order", data: {
        "amount": amount,
        "currency": currency
      });

      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final orderData = response.data;
        openRazorpay(orderData);
      } else {
        print("API call failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error creating order: $e");
    }
  }


  void openRazorpay(Map<String, dynamic> orderData) {
    var options = {
      "key": "rzp_test_BMXb16WdMYmYzH",
      "amount": orderData["amount"],
      "currency": orderData["currency"],
      "name": "Your App Name",
      "order_id": orderData["id"],
      "theme": {"color": "#F37254"}
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");

    await _dio.post("$serverBaseUrl/verify", data: {
      "order_id": response.orderId,
      "payment_id": response.paymentId,
      "razorpay_signature": response.signature
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
