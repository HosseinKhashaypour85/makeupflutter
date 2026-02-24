import 'package:dio/dio.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_api_urls.dart';

class PopCategoryServices {
  final Dio _dio = Dio();

  Future<Response> callCategoriesApi() async {
    try {
      final url = AppApiUrls.getCategoryProductsApi;
      final Response response = await _dio.get(url);
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
