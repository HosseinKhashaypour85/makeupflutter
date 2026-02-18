part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CallCategoryProducts extends CategoryEvent{
  final String categoryId;
  CallCategoryProducts({required this.categoryId});
}
