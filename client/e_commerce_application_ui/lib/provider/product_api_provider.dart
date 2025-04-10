import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../core/routes/app_pages.dart';
import '../features/auth/models/get_storage_key.dart';
import '../features/home/models/product_model.dart';

class ProductApiProvider {
  final GetStorage _getStorage = GetStorage();
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'http://192.168.29.10:8080/api/v1/',
        connectTimeout: const Duration(seconds: 6000),
        receiveTimeout: const Duration(seconds: 6000),
        responseType: ResponseType.json,
        contentType: "application/json"),
  );

  Future<String?> refreshToken() async {
    try {
      final refreshToken = _getStorage.read(GetStorageKey.refreshToken);
      final response = await _dio
          .post('auth/refreshToken', data: {'refreshToken': refreshToken});
      final newAccessToken = response.data['accessToken'];
      _getStorage.write(GetStorageKey.accessToken, newAccessToken);
      return newAccessToken;
    } catch (exception) {
      _getStorage.erase();
      Get.offAllNamed(Routes.login);
    }
    return null;
  }

  ProductApiProvider() {
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

  /// Fetch all products
  Future<ProductModel> fetchAllProducts() async {
    try {
      final response = await _dio.get("products");

      if (response.data != null) {
        // Assuming the response contains a single paginated ProductModel
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        return Future.error("No products found");
      }
    } on DioException catch (err) {
      // Use a detailed error message
      final errorMessage = err.response?.data?['message'] ??
          err.message ??
          "Failed to fetch products";
      return Future.error(errorMessage);
    } catch (e) {
      // Handle unexpected errors
      return Future.error("An unexpected error occurred: $e");
    }
  }




  /// Fetch a single product by ID
  Future<ProductModel> fetchProductById(String productId) async {
    try {
      final response = await _dio.get("products/$productId");
      return ProductModel.fromJson(response.data);
    } on DioException catch (err) {
      return Future.error(err.message ?? "Failed to fetch product");
    }
  }

  /// Add a new product
  Future<ProductModel> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _dio.post("products", data: productData);
      return ProductModel.fromJson(response.data);
    } on DioException catch (err) {
      return Future.error(err.message ?? "Failed to add product");
    }
  }

  /// Update an existing product
  Future<ProductModel> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      final response = await _dio.put("products/$productId", data: productData);
      return ProductModel.fromJson(response.data);
    } on DioException catch (err) {
      return Future.error(err.message ?? "Failed to update product");
    }
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _dio.delete("products/$productId");
    } on DioException catch (err) {
      return Future.error(err.message ?? "Failed to delete product");
    }
  }
}