import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/subscriptions/domain/usecases/subs_usecase.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/confirm_payment/confirm_payment_event.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/confirm_payment/confirm_payment_state.dart';
import 'package:frontend/network/api_service.dart';

class ConfirmPaymentBloc
    extends Bloc<ConfirmPaymentEvent, ConfirmPaymentState> {
  final GetSinglePlanUsecase _getSinglePlanUsecase = GetSinglePlanUsecase();
  final StartSubscriptionUsecase _startSubscriptionUsecase =
      StartSubscriptionUsecase();

  ConfirmPaymentBloc() : super(ConfirmPaymentState.initial()) {
    on<GetSinglePlanEvent>(getSinglePlanEvent, transformer: droppable());
    on<StartSubscriptionEvent>(
      startSubscriptionEvent,
      transformer: droppable(),
    );
  }

  getSinglePlanEvent(
    GetSinglePlanEvent event,
    Emitter<ConfirmPaymentState> emit,
  ) async {
    emit.call(state.copyWith(apiStatus: ApiStatus.loading));
    var response = await _getSinglePlanUsecase.call(event.id);
    if (response == null) {
      emit.call(state.copyWith(apiStatus: ApiStatus.error));
      return;
    }
    emit.call(
      state.copyWith(apiStatus: ApiStatus.success, planModel: response.data),
    );
  }

  startSubscriptionEvent(
    StartSubscriptionEvent event,
    Emitter<ConfirmPaymentState> emit,
  ) async {
    emit.call(state.copyWith(apiStatus: ApiStatus.userActionLoading));
    var response = await _startSubscriptionUsecase.call({});
    if (response == null) {
      emit.call(state.copyWith(apiStatus: ApiStatus.error));
      return;
    } else {
      emit.call(state.copyWith(apiStatus: ApiStatus.success));
    }
  }
}
