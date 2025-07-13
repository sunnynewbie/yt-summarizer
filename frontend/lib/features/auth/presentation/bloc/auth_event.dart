import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class CheckTokenEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RefreshTokenEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
