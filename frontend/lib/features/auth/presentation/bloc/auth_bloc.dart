import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_event.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.init()) {
    on<LoginEvent>((event, emit) {
      emit(AuthState.init());
    });
    on<RegisterEvent>((event, emit) {
      emit(AuthState.init());
    });
    on<LogoutEvent>((event, emit) {
      emit(AuthState.init());
    });
    on<CheckTokenEvent>((event, emit) {
      emit(AuthState.init());
    });
    on<RefreshTokenEvent>((event, emit) {
      emit(AuthState.init());
    });
  }
}
