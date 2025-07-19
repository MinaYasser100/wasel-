import 'package:dio/dio.dart';
import 'package:wasel/core/helper_network/app_const.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';

class DioHelper {
  static final DioHelper _instance =
      DioHelper._internal(); // Singleton instance
  late final Dio _dio;

  // Private constructor
  DioHelper._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConst.baseUrl,
        headers: {'Content-Type': 'application/json'},
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10), // إضافة timeout
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  // Factory constructor to return the same instance
  factory DioHelper() {
    return _instance;
  }

  // Getter for Dio instance
  Dio get dio => _dio;

  // Generic GET method
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: query);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  // Post data
  Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // Fetch products specifically
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await getData(url: 'products');
      final List<dynamic> data = response.data['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
