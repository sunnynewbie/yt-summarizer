import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/domain/usecases/auth_usecase.dart';
import 'package:frontend/features/auth/presentation/bloc/register/register_state.dart';
import 'package:frontend/network/api_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final emailController = TextEditingController(),
      nameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController();

  final RegisterUsecase _registerUsecase = RegisterUsecase();

  RegisterCubit() : super(RegisterState.initial());

  void register() async {
    emit(state.copyWith(apiStatus: ApiStatus.userActionLoading));
    var data = <String, String>{
      'email': emailController.text,
      'name': nameCtrl.text,
      'password': passwordCtrl.text,
    };
    var response = await _registerUsecase.call(data);
    if (response == null) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
      return;
    }

    if (response.status) {
      emit(state.copyWith(apiStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  void changePasswordVisibility() {
    if (state.passwordVisible) {
      emit(state.togglepass(passwordVisible: false));
    } else {
      emit(state.togglepass(passwordVisible: true));
    }
  }
}
