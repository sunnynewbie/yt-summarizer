import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState._();

  @override
  List<Object?> get props => [];

  ///create init constructor
  factory AuthState.init() {
    return AuthState._();
  }
}
