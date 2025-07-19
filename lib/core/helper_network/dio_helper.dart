import 'package:dio/dio.dart';
import 'package:wasel/core/helper_network/app_const.dart';

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
      ),
    );
  }

  // Factory constructor to return the same instance
  factory DioHelper() {
    return _instance;
  }

  // Getter for Dio instance
  Dio get dio => _dio;

  // to get data from url
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(url, queryParameters: query);
  }

  // post data
  Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    return await _dio.post(url, data: data);
  }
}
