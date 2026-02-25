import '../model/popular_category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryCompletedState extends CategoryState {
  final List<PopularCategoryModel> categories;

  CategoryCompletedState({required this.categories});
}

class CategoryErrorState extends CategoryState {
  final String msg;

  CategoryErrorState({required this.msg});
}