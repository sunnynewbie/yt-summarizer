import 'package:equatable/equatable.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/network/api_service.dart';

class ConfirmPaymentState extends Equatable {
  final ApiStatus apiStatus;
  final PlanModel? planModel;

  const ConfirmPaymentState({required this.apiStatus, required this.planModel});

  @override
  List<Object?> get props => [apiStatus, planModel];

  factory ConfirmPaymentState.initial() {
    return const ConfirmPaymentState(
      apiStatus: ApiStatus.initial,
      planModel: null,
    );
  }

  ConfirmPaymentState copyWith({ApiStatus? apiStatus, PlanModel? planModel}) {
    return ConfirmPaymentState(
      apiStatus: apiStatus ?? ApiStatus.initial,
      planModel: planModel ?? this.planModel,
    );
  }

  @override
  String toString() {
    return 'ConfirmPaymentState{apiStatus: $apiStatus, planModel: $planModel}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ConfirmPaymentState &&
          runtimeType == other.runtimeType &&
          apiStatus == other.apiStatus &&
          planModel == other.planModel;

  @override
  int get hashCode => Object.hash(super.hashCode, apiStatus, planModel);
}
