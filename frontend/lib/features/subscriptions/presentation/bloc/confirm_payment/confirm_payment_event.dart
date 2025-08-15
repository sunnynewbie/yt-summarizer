import 'package:equatable/equatable.dart';

sealed class ConfirmPaymentEvent extends Equatable {}

class GetSinglePlanEvent extends ConfirmPaymentEvent {
  String id;

  GetSinglePlanEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class StartSubscriptionEvent extends ConfirmPaymentEvent {
  String id;
  String userid;

  StartSubscriptionEvent(this.id, this.userid);

  @override
  List<Object?> get props => [id, userid];
}
