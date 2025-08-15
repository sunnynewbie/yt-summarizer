import 'package:equatable/equatable.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/network/api_service.dart';

class SubscriptionState extends Equatable {
  ApiStatus apiStatus;
  List<PlanModel> plans;
  String? message;

  @override
  List<Object?> get props => [apiStatus, plans, message];

  factory SubscriptionState.initial() {
    return SubscriptionState(apiStatus: ApiStatus.initial, plans: []);
  }

  SubscriptionState({
    required this.apiStatus,
    required this.plans,
    this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is SubscriptionState &&
          runtimeType == other.runtimeType &&
          apiStatus == other.apiStatus &&
          message == other.message &&
          plans == other.plans;

  @override
  int get hashCode => Object.hash(super.hashCode, apiStatus, plans, message);

  SubscriptionState copyWith({
    ApiStatus? apiStatus,
    List<PlanModel>? plans,
    String? message,
  }) {
    return SubscriptionState(
      apiStatus: apiStatus ?? ApiStatus.initial,
      plans: plans ?? this.plans,
      message: message ?? this.message,
    );
  }
}
