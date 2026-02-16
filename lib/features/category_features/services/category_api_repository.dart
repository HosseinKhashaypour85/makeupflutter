import 'package:dio/dio.dart';
import 'package:makeupflutter/features/category_features/model/category_model.dart';
import 'package:makeupflutter/features/category_features/services/category_api_services.dart';

class CategoryApiRepository {
  final CategoryApiServices _apiServices = CategoryApiServices();
  Future<CategoryModel>callCategoryApiServices(String categoryId)async{
    final Response response = await _apiServices.callCategoryApiServices(categoryId);
    return CategoryModel.fromJson(response.data);
  }
}