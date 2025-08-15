import 'package:equatable/equatable.dart';
import 'package:frontend/features/subscriptions/data/models/cancel_sub_model.dart';
import 'package:frontend/features/subscriptions/data/models/create_sub_model.dart';

sealed class SubscriptionEvent extends Equatable {}

class CreateSubscriptionEvent extends SubscriptionEvent {
  CreateSubModel subModel;

  CreateSubscriptionEvent(this.subModel);

  @override
  List<Object?> get props => [this.subModel];
}

class UnsubscribeEvent extends SubscriptionEvent {
  CancelSubModel subModel;

  UnsubscribeEvent(this.subModel);

  @override
  List<Object?> get props => [this.subModel];
}

class GetPlans extends SubscriptionEvent {
  @override
  List<Object?> get props => [];
}

class GetSinglePlan extends SubscriptionEvent {
  String planId;

  GetSinglePlan(this.planId);

  @override
  List<Object?> get props => [planId];
}

class GetActiveSubscription extends SubscriptionEvent {
  String userId;

  GetActiveSubscription(this.userId);

  @override
  List<Object?> get props => [userId];
}
