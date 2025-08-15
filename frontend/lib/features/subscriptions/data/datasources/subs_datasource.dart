import 'package:dio/dio.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/api_response.dart';
import 'package:frontend/network/api_service.dart';

abstract class SubsDataSource {
  Future<ApiResponse<List<PlanModel>>?> getPlans();

  Future<ApiResponse<PlanModel?>?> getSinglePlan({required String planId});

  Future<Response?> createSubscription({required Map<String, dynamic> data});

  Future<Response?> cancelSubscription({required Map<String, dynamic> data});

  Future<Response?> getSubscription({required String subId});

  Future<Response?> getSubscriptionHistory({required String usrtId});
}

class SubsDataSourceImpl implements SubsDataSource {
  @override
  Future<Response?> cancelSubscription({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await ApiService().delete(path: ApiPath.subscribe);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Response?> createSubscription({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await ApiService().post(
        path: ApiPath.subscribe,
        data: data,
      );
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<ApiResponse<List<PlanModel>>?> getPlans() async {
    try {
      var response = await ApiService().get(path: ApiPath.getPlans);
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(
        response,
        fromJson: (data) {
          print(data);
          if (data['data'] is List) {
            return (data['data'] as List)
                .map((e) => PlanModel.fromJson(e))
                .toList();
          }
          return [];
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<ApiResponse<PlanModel?>?> getSinglePlan({
    required String planId,
  }) async {
    try {
      var response = await ApiService().get(
        path: ApiPath.getSinglePlan(planId),
      );
      if (response != null) {
        return ApiResponse.fromResponse(
          response,
          fromJson: (data) {
            if (data['data'] is Map) {
              return PlanModel.fromJson(data['data']);
            }
            return null;
          },
        );
      }
    } catch (e) {}
  }

  @override
  Future<Response?> getSubscription({required String subId}) async {
    try {
      var response = await ApiService().get(path: ApiPath.getActiveSubs(subId));
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Response?> getSubscriptionHistory({required String usrtId}) async {
    try {
      var response = await ApiService().get(
        path: ApiPath.getSubsHistory(usrtId),
      );
      return response;
    } catch (e) {
      print(e);
    }
  }
}
