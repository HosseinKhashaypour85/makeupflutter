import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../services/category_api_repository.dart';
import '../model/sub_category_model.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryApiRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CallCategoryProducts>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        SubCategoryModel subCategoryModel = await repository.callCategoryApiServices(
          event.categoryId,
        );
        emit(CategoryCompletedState());
      } on DioException catch (e) {
        emit(CategoryErrorState(msg: e.toString()));
      } catch (e) {
        emit(CategoryErrorState(msg: e.toString()));
      }
    });
  }
}
