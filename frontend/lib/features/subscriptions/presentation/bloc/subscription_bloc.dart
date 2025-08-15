import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/subscriptions/domain/usecases/subs_usecase.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/Subscription_state.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/subscription_event.dart';
import 'package:frontend/network/api_service.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  GetPlansUsecase getPlansUsecase = GetPlansUsecase();
  GetSinglePlanUsecase getSinglePlanUsecase = GetSinglePlanUsecase();
  GetSubscriptionsHistoryUsecase getSubscriptionsHistoryUsecase =
      GetSubscriptionsHistoryUsecase();
  GetSubscriptionUsecase getSubscriptionUsecase = GetSubscriptionUsecase();
  CancelSubscriptionUsecase cancelSubscriptionUsecase =
      CancelSubscriptionUsecase();
  StartSubscriptionUsecase startSubscriptionUsecase =
      StartSubscriptionUsecase();

  SubscriptionBloc() : super(SubscriptionState.initial()) {
    on<SubscriptionEvent>((event, emit) async {
      print('object ${event}');

      switch (event) {
        case CreateSubscriptionEvent():
        case UnsubscribeEvent():
          return;
        case GetPlans():
          await _getPlans(event, emit);
          return;
        case GetSinglePlan():
        case GetActiveSubscription():
          return;
      }
    }, transformer: droppable());
  }

  Future<void> _createSubscription(
    CreateSubscriptionEvent event,
    Emitter<SubscriptionState> emit,
  ) async {}

  Future<void> _unsubscribe(
    UnsubscribeEvent event,
    Emitter<SubscriptionState> emit,
  ) async {}

  Future<void> _getPlans(
    GetPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit.call(state.copyWith(apiStatus: ApiStatus.loading));
    var response = await getPlansUsecase.call(NoParams());
    if (response != null) {
      emit.call(state.copyWith(apiStatus: ApiStatus.success));
      emit(state.copyWith(plans: response.data ?? []));
    } else {
      emit.call(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  Future<void> _getSinglePlan(
    GetSinglePlan event,
    Emitter<SubscriptionState> emit,
  ) async {}

  Future<void> _getActiveSubscription(
    GetActiveSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {}
}
