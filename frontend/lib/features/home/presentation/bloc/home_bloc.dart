import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/home/data/datasources/home_source.dart';
import 'package:frontend/features/home/domain/repositories/home_repo_impl.dart';
import 'package:frontend/features/home/domain/usecases/submit_usecase.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SubmitUseCase submitUseCase = SubmitUseCase(HomeRepoImpl(HomeSource()));

  HomeBloc() : super(HomeState.init()) {
    on<SubmitForm>((event, emit) {
      return submitUseCase.call({'url': event.data});
    });
  }
}
