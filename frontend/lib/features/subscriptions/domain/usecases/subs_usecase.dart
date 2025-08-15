import 'package:dio/dio.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/subscriptions/data/repositories/subs_repository.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/features/subscriptions/domain/repositories/subs_repo.dart';
import 'package:frontend/network/api_response.dart';

class GetPlansUsecase extends UseCase<ApiResponse<List<PlanModel>>?, NoParams> {
  SubsRepository subsRepository = SubsRepoImpl();

  @override
  Future<ApiResponse<List<PlanModel>>?> call(NoParams params) {
    return subsRepository.getPlans();
  }
}

class GetSinglePlanUsecase extends UseCase<ApiResponse<PlanModel?>?, String> {
  SubsRepository repository = SubsRepoImpl();

  @override
  Future<ApiResponse<PlanModel?>?> call(String params) {
    return repository.getSinglePlan(planId: params);
  }
}

class StartSubscriptionUsecase
    extends UseCase<Response?, Map<String, dynamic>> {
  SubsRepository repository = SubsRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.createSubscription(data: params);
  }
}

class CancelSubscriptionUsecase
    extends UseCase<Response?, Map<String, dynamic>> {
  SubsRepository repository = SubsRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.cancelSubscription(data: params);
  }
}

class GetSubscriptionUsecase extends UseCase<Response?, String> {
  SubsRepository repository = SubsRepoImpl();

  @override
  Future<Response?> call(String params) {
    return repository.getSubscription(subId: params);
  }
}

class GetSubscriptionsHistoryUsecase extends UseCase<Response?, String> {
  SubsRepository repository = SubsRepoImpl();

  @override
  Future<Response?> call(String params) {
    return repository.getSubscriptionHistory(usrtId: params);
  }
}
