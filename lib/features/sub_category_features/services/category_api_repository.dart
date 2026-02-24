import 'package:dio/dio.dart';

import '../../home_features/model/category_model.dart';
import '../model/sub_category_model.dart';
import 'category_api_services.dart';


class CategoryApiRepository {
  final CategoryApiServices _apiServices = CategoryApiServices();
  Future<SubCategoryModel>callCategoryApiServices(String categoryId)async{
    final Response response = await _apiServices.callCategoryApiServices(categoryId);
    return SubCategoryModel.fromJson(response.data);
  }
}