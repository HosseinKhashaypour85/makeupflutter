import 'package:flutter/cupertino.dart';
import '../app_local_storage/app_local_storage.dart';

class AppCheckToken {
  Future<void> checkToken(
      BuildContext context, {
        String authenticatedRoute = '/home',
        String unauthenticatedRoute = '/login',
      }) async {
    try {
      final localStorage = await LocalStorage.getInstance();
      final getToken = await localStorage.get('token');

      if (getToken == null || getToken.isEmpty) {
        _navigateToRoute(context, unauthenticatedRoute);
      } else {
        _navigateToRoute(context, authenticatedRoute);
      }
    } catch (e) {
      // در صورت خطا به صفحه لاگین برو
      print('Error checking token: $e');
      _navigateToRoute(context, unauthenticatedRoute);
    }
  }

  void _navigateToRoute(BuildContext context, String routeName) {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
            (route) => false,
      );
    }
  }
}