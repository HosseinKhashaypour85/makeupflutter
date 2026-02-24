import 'package:makeupflutter/features/category_features/model/popular_category_model.dart';
import 'package:makeupflutter/features/sub_category_features/services/category_api_services.dart';

import 'category_api_services.dart';

class CategoryApiRepository {
  final PopCategoryServices _apiServices = PopCategoryServices();
  Future<PopularCategoryModel>callCategoriesApi()async{
    final response = await _apiServices.callCategoriesApi();
    return PopularCategoryModel.fromJson(response.data);
  }
}