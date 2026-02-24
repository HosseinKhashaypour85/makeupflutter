part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState{}

class CategoryCompletedState extends CategoryState{}

class CategoryErrorState extends CategoryState{
  final String msg;
  CategoryErrorState({required this.msg});
}
