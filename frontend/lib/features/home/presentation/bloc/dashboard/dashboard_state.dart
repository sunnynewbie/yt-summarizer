import 'package:equatable/equatable.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:frontend/network/api_service.dart';

class DashboardState extends Equatable {
  ApiStatus apiStatus;
  UserModel? userModel;

  DashboardState({required this.apiStatus, this.userModel});

  @override
  List<Object?> get props => [apiStatus, this.userModel];

  DashboardState copyWith({ApiStatus? apiStatus, UserModel? userModel}) {
    return DashboardState(
      apiStatus: apiStatus ?? ApiStatus.initial,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is DashboardState &&
          runtimeType == other.runtimeType &&
          apiStatus == other.apiStatus &&
          userModel == other.userModel;

  @override
  int get hashCode => Object.hash(super.hashCode, apiStatus, userModel);

  factory DashboardState.initial() =>
      DashboardState(apiStatus: ApiStatus.initial);
}
