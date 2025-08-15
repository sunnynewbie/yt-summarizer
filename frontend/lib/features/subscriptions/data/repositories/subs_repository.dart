import 'package:dio/src/response.dart';
import 'package:frontend/features/subscriptions/data/datasources/subs_datasource.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/features/subscriptions/domain/repositories/subs_repo.dart';
import 'package:frontend/network/api_response.dart';

class SubsRepoImpl extends SubsRepository {
  SubsDataSource dataSource = SubsDataSourceImpl();

  @override
  Future<Response?> cancelSubscription({required Map<String, dynamic> data}) {
    return dataSource.cancelSubscription(data: data);
  }

  @override
  Future<Response?> createSubscription({required Map<String, dynamic> data}) {
    return dataSource.createSubscription(data: data);
  }

  @override
  Future<ApiResponse<List<PlanModel>>?> getPlans() {
    return dataSource.getPlans();
  }

  @override
  Future<ApiResponse<PlanModel?>?>  getSinglePlan({required String planId}) {
    return dataSource.getSinglePlan(planId: planId);
  }

  @override
  Future<Response?> getSubscription({required String subId}) {
    return dataSource.getSubscription(subId: subId);
  }

  @override
  Future<Response?> getSubscriptionHistory({required String usrtId}) {
    return dataSource.getSubscriptionHistory(usrtId: usrtId);
  }
}
