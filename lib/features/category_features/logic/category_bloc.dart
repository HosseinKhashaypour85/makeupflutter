import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:makeupflutter/features/category_features/model/popular_category_model.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{
  final CategoryApiRepository repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CallCategoryEvent>((event, emit) async{
      emit(CategoryLoadingState());
      try{
        PopularCategoryModel categoryModel = await repository.callCategoriesApi();
        emit(CategoryCompletedState());
      }
          on DioException catch(e){
        emit(CategoryErrorState(msg: 'خطا در بارگذاری دسته بندی ها محبوب'));
          }
    });
  }
}
