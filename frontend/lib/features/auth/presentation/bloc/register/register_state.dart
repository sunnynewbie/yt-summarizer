import 'package:equatable/equatable.dart';
import 'package:frontend/network/api_service.dart';

class RegisterState extends Equatable {
  final String? message;
  final ApiStatus apiStatus;
  final bool passwordVisible;

  const RegisterState(this.message, this.apiStatus, this.passwordVisible);

  @override
  List<Object?> get props => [message, apiStatus,passwordVisible];


  RegisterState copyWith({
    String? message,
    ApiStatus? apiStatus,
    bool? passwordVisible,
  }) {
    return RegisterState(
      message ?? this.message,
      apiStatus ?? ApiStatus.initial,
      passwordVisible ?? this.passwordVisible,
    );
  }

  RegisterState togglepass({bool? passwordVisible}) {
    return copyWith(passwordVisible: passwordVisible);
  }

  @override
  String toString() {
    return '''RegisterState {
      message: $message,
      apiStatus: $apiStatus,
      passwordVisible: $passwordVisible,
    }''';
  }

  factory RegisterState.initial() {
    return RegisterState(null, ApiStatus.initial, false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RegisterState &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          passwordVisible == other.passwordVisible &&
          apiStatus == other.apiStatus;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, message, apiStatus, passwordVisible);
}
