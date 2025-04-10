import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/routes/app_pages.dart';
import '../features/auth/models/get_storage_key.dart';
import '../features/auth/models/token_model.dart';
import '../features/auth/models/user_model.dart';

class MyApiProvider {
  final GetStorage _getStorage = GetStorage();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.29.10:8080/api/v1/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  );

  bool _isRefreshing = false;
  Future<String?>? _refreshFuture;

  MyApiProvider() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = "application/json";

          final unprotectedPaths = ['auth/login', 'auth/signup', 'auth/refreshToken'];
          bool isUnprotectedRoute = unprotectedPaths.any((path) => options.path.contains(path));

          if (!isUnprotectedRoute) {
            String? token = _getStorage.read(GetStorageKey.accessToken);
            if (token != null) {
              options.headers["Authorization"] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && !error.requestOptions.path.contains('auth/login')) {
            final newAccessToken = await _handleTokenRefresh();
            if (newAccessToken != null) {
              error.requestOptions.headers["Authorization"] = 'Bearer $newAccessToken';
              return handler.resolve(await _dio.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String?> _handleTokenRefresh() async {
    if (_isRefreshing) {
      return _refreshFuture;
    }

    _isRefreshing = true;
    _refreshFuture = _refreshToken();
    final newToken = await _refreshFuture;
    _isRefreshing = false;
    _refreshFuture = null;

    return newToken;
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = _getStorage.read(GetStorageKey.refreshToken);
      final response = await _dio.post('auth/refreshToken', data: {'refreshToken': refreshToken});
      final newAccessToken = response.data['accessToken'];
      _getStorage.write(GetStorageKey.accessToken, newAccessToken);
      return newAccessToken;
    } catch (exception) {
      _getStorage.erase();
      Get.offAllNamed(Routes.login);
      return null;
    }
  }

  Future<TokenModel> login(Map<String, dynamic> map) async {
    try {
      final response = await _dio.post("auth/login", data: map);
      return TokenModel.fromJson(response.data);  // Direct JSON parsing
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data["message"] ?? "Invalid Credentials");
      }
      return Future.error(err.response?.data["message"] ?? "Internal Server Error");
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get("users/me");
      return UserModel.fromJson(response.data);  // Direct JSON parsing
    } on DioException catch (err) {
      return Future.error(err.response?.data["message"] ?? "Failed to fetch profile");
    }
  }
}
