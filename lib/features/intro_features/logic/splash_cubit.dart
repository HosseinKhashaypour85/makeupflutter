import 'package:bloc/bloc.dart';
import 'package:makeupflutter/config/app_config/app_local_storage/app_local_storage.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  late LocalStorage localStorage;

  void checkToken()async{
    localStorage = await LocalStorage.getInstance();
    var token = localStorage.get('token');
    if(token == null || token.isEmpty){
      emit(DeviceHaveNotToken());
    }
    else{
      emit(DeviceHaveToken());
    }
  }
}
