import 'package:dio/dio.dart';

import '../../../config/app_config/app_urls/app_api_urls.dart';

class HomeApiServices {
  final Dio _dio = Dio();

  Future<Response> callCategoriesRowApi() async {
    final apiUrl = AppApiUrls.categoriesRowApi;

    try {
      final response = await _dio.get(apiUrl);
      return response;
    } on DioException catch (e) {
      print('❌ DIO ERROR');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('HEADERS: ${e.response?.headers}');
      throw e;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> callPopularProductsApi() async {
    final apiUrl = AppApiUrls.popularProductsApi;
    try {
      final response = await _dio.get(apiUrl);
      return response;
    } on DioException catch (e) {
      print('❌ DIO ERROR');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('HEADERS: ${e.response?.headers}');
      throw e;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
