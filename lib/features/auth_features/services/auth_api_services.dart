import 'package:dio/dio.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_api_urls.dart';

class AuthApiServices {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> callSendOtpApi(String phoneNum) async {
    // final apiUrl = AppApiUrls.sendOtpApi;
    final apiUrl = 'http://10.0.2.2:6436/api/auth/send-otp';
    print('👉 SEND OTP REQUEST');
    print('URL: $apiUrl');
    print('BODY: {"mobile": "$phoneNum"}');

    try {
      final response = await dio.post(apiUrl, data: {"mobile": phoneNum});

      print('✅ RESPONSE STATUS: ${response.statusCode}');
      print('✅ RESPONSE DATA: ${response.data}');
      return response;
    } on DioException catch (e) {
      print('❌ DIO ERROR');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('HEADERS: ${e.response?.headers}');
      throw e; // خیلی مهم
    } catch (e) {
      print('❌ UNKNOWN ERROR: $e');
      rethrow;
    }
  }

  Future<Response> callConfirmOtpApi(String mobile, String otp) async {
    final apiUrl = 'http://10.0.2.2:6436/api/auth/confirm-otp';

    print('👉 SEND OTP REQUEST');
    print('URL: $apiUrl');
    print('BODY: {"mobile": "$mobile"}');
    print('BODY: {"otp": "$otp"}');

    try {
      final response = await dio.post(
        apiUrl,
        data: {"mobile": mobile, "otp": otp},
      );
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
      print('❌ UNKNOWN ERROR: $e');
      rethrow;
    }
  }
}
