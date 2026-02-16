import 'package:makeupflutter/features/home_features/model/category_model.dart';
import 'package:makeupflutter/features/home_features/model/popular_products_model.dart';
import 'package:makeupflutter/features/home_features/services/home_api_services.dart';

class HomeApiRepository {
  final HomeApiServices homeApiServices = HomeApiServices();
  Future<CategoryModel>callCategoriesRowApi()async{
    final response = await homeApiServices.callCategoriesRowApi();
    return CategoryModel.fromJson(response.data);
  }
  Future<PopularProductsModel>callPopularProductsApi()async{
    final response = await homeApiServices.callPopularProductsApi();
    return PopularProductsModel.fromJson(response.data);
  }
}