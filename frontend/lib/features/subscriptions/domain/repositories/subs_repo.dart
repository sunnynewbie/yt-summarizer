import 'package:dio/dio.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/network/api_response.dart';

abstract class SubsRepository {
  Future<ApiResponse<List<PlanModel>>?> getPlans();

  Future<ApiResponse<PlanModel?>?> getSinglePlan({required String planId});

  Future<Response?> createSubscription({required Map<String, dynamic> data});

  Future<Response?> cancelSubscription({required Map<String, dynamic> data});

  Future<Response?> getSubscription({required String subId});

  Future<Response?> getSubscriptionHistory({required String usrtId});
}
