import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/features/auth/domain/usecases/auth_usecase.dart';
import 'package:frontend/features/home/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:frontend/features/home/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:frontend/network/api_service.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  RefreshTokenUsecase checkTokenUsecase = RefreshTokenUsecase();
  FetchUser fetchUser = FetchUser();

  DashboardBloc() : super(DashboardState.initial()) {
    on<BootstrapEvent>(onBootStrapCalled);
  }

  onBootStrapCalled(BootstrapEvent event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));

    var user = await fetchUser.call(NoParams());
    if (user == null) {
      emit(state.copyWith(apiStatus: ApiStatus.unAuthenticated));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.success, userModel: user.data));
      if (user.data != null) {
        SharedPrefsHelper.setUser(user.data!);
      } // var response = await checkTokenUsecase.call(NoParams());
      // if (response == null) {
      //   emit(state.copyWith(apiStatus: ApiStatus.error));
      // } else {
      //   emit(state.copyWith(apiStatus: ApiStatus.success));
      // }
    }
  }
}
