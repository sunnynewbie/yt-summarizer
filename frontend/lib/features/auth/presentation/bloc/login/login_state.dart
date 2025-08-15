import 'package:equatable/equatable.dart';
import 'package:frontend/network/api_service.dart';

class LoginState extends Equatable {
  String? message;
  ApiStatus apiStatus;
  bool showPassword;

  LoginState({
    this.message,
    this.apiStatus = ApiStatus.initial,
    this.showPassword = false,
  });

  @override
  List<Object?> get props => [message, showPassword, apiStatus];

  LoginState copyWith({
    String? message,
    ApiStatus? apiStatus,
    bool? showPassword,
  }) {
    return LoginState(
      message: message ?? this.message,
      apiStatus: apiStatus ?? ApiStatus.initial,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  LoginState togglePassword({bool? showPassword}) {
    return copyWith(showPassword: showPassword);
  }

  factory LoginState.initial() {
    return LoginState(
      message: null,
      apiStatus: ApiStatus.initial,
      showPassword: false,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is LoginState &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          apiStatus == other.apiStatus &&
          showPassword == other.showPassword;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, message, apiStatus, showPassword);
}
