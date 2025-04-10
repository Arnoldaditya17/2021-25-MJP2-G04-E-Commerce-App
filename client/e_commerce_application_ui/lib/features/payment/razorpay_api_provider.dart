import 'package:dio/dio.dart';
import 'package:e_commerce_application_ui/core/routes/app_pages.dart';
import 'package:e_commerce_application_ui/features/auth/models/get_storage_key.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayApiProvider {
  final GetStorage _getStorage = GetStorage();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.29.10:8080/api/v1/',
      connectTimeout: const Duration(seconds: 6000),
      receiveTimeout: const Duration(seconds: 6000),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  );

  final Razorpay _razorpay = Razorpay();

  RazorpayApiProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = "application/json";
          final unprotectedPaths = [
            'auth/login',
            'auth/signup',
            'auth/refreshToken'
          ];
          bool isUnprotectedRoute =
          unprotectedPaths.any((path) => options.path.contains(path));
          if (!isUnprotectedRoute) {
            String? token = _getStorage.read(GetStorageKey.accessToken);
            if (token != null) {
              options.headers["Authorization"] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          const loginPath = 'auth/login';
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains(loginPath)) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              _dio.options.headers["Authorization"] = 'Bearer $newAccessToken';
              return handler.resolve(await _dio.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = _getStorage.read(GetStorageKey.refreshToken);
      final response = await _dio.post(
        'auth/refreshToken',
        data: {'refreshToken': refreshToken},
      );
      final newAccessToken = response.data['accessToken'];
      _getStorage.write(GetStorageKey.accessToken, newAccessToken);
      return newAccessToken;
    } catch (exception) {
      _getStorage.erase();
      Get.offAllNamed(Routes.login);
    }
    return null;
  }

  /// Create a new order in Razorpay (API Call)
  Future<Map<String, dynamic>> createOrder(int amount, String currency) async {
    try {
      print("🔄 Creating Razorpay Order...");
      final response = await _dio.post(
        "payment/order",
        data: {
          "amount": amount,
          "currency": currency,
        },
      );

      print("✅ Order Created: ${response.data}");
      return response.data;
    } on DioException catch (err) {
      final errorMessage =
          err.response?.data?['message'] ?? err.message ?? "Failed to create order";
      return Future.error(errorMessage);
    } catch (e) {
      return Future.error("An unexpected error occurred: $e");
    }
  }

  /// Open Razorpay checkout UI
  void openRazorpay(Map<String, dynamic> orderData) {
    print("🚀 Opening Razorpay Checkout...");

    var options = {
      "key": "rzp_test_BMXb16WdMYmYzH", // Your Razorpay test/live key
      "amount": orderData["amount"],
      "currency": orderData["currency"],
      "name": "Apni Dukaan",
      "order_id": orderData["id"],
      "prefill": {
        "contact": "9999999999",  // Replace with the user's phone number
        "email": "apniDukaan@example.com", // Replace with the user's email
      },
      "theme": {"color": "#000000"},
    };

    try {
      _razorpay.open(options);
      print("✅ Razorpay Checkout Opened Successfully!");
    } catch (e) {
      print("❌ Error Opening Razorpay Checkout: $e");
    }
  }

  /// Payment Success Callback
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("🎉 Payment Successful!");
    print("🆔 Payment ID: ${response.paymentId}");
    print("📝 Order ID: ${response.orderId}");
    print("🔑 Signature: ${response.signature}");
    // Call API to verify payment (if needed)
  }

  /// Payment Failure Callback
  void _handlePaymentError(PaymentFailureResponse response) {
    print("❌ Payment Failed: ${response.message}");
  }

  /// External Wallet Callback
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("💳 External Wallet Selected: ${response.walletName}");
  }
}
