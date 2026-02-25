import '../model/popular_category_model.dart';
import 'category_api_services.dart';

class CategoryApiRepository {
  final PopCategoryServices _apiServices = PopCategoryServices();

  Future<List<PopularCategoryModel>> callCategoriesApi() async {
    final res = await _apiServices.callCategoriesApi();

    final list = res.data as List;

    return list
        .map((e) => PopularCategoryModel.fromJson(e))
        .toList();
  }
}