import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:makeupflutter/features/category_features/model/category_model.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';
import 'package:makeupflutter/features/category_features/services/category_api_services.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryApiRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CallCategoryProducts>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        CategoryModel categoryModel = await repository.callCategoryApiServices(
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
