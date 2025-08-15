import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/features/auth/domain/usecases/auth_usecase.dart';
import 'package:frontend/features/auth/presentation/bloc/login/login_state.dart';
import 'package:frontend/network/api_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final emailCtrl = TextEditingController(), passCtrl = TextEditingController();
  final LoginUsecase loginUsecase = LoginUsecase();

  LoginCubit() : super(LoginState.initial());

  togglePassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  login() async {
    emit(state.copyWith(apiStatus: ApiStatus.userActionLoading));
    var data = {'email': emailCtrl.text, 'password': passCtrl.text};
    var response = await loginUsecase.call(data);
    if (response == null) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    } else if (response.status) {
      if (response.data == null) {
        emit(state.copyWith(apiStatus: ApiStatus.error));
      } else {
        SharedPrefsHelper.saveToken(response.data!);
        emit(state.copyWith(apiStatus: ApiStatus.success));
      }
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }
}
