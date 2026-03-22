import 'package:frontend/features/audit/data/models/audit_log_query_model.dart';
import 'package:frontend/features/audit/domain/entities/audit_log_model.dart';
import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/api_response.dart';
import 'package:frontend/network/api_service.dart';

abstract class AuditDataSource {
  Future<ApiResponse<List<AuditLogModel>>?> getAuditLogs({
    AuditLogQueryModel? query,
  });

  Future<ApiResponse<AuditLogModel?>?> getAuditLogById({
    required String auditId,
  });
}

class AuditDataSourceImpl implements AuditDataSource {
  @override
  Future<ApiResponse<List<AuditLogModel>>?> getAuditLogs({
    AuditLogQueryModel? query,
  }) async {
    try {
      final response = await ApiService().get(
        path: ApiPath.auditLogs,
        queryParameter: query?.toJson(),
      );
      if (response == null) {
        return null;
      }

      return ApiResponse.fromResponse(
        response,
        fromJson: (data) {
          if (data is Map && data['data'] is List) {
            return (data['data'] as List)
                .whereType<Map>()
                .map(
                  (e) => AuditLogModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList();
          }
          return <AuditLogModel>[];
        },
      );
    } on Exception {
      return null;
    }
  }

  @override
  Future<ApiResponse<AuditLogModel?>?> getAuditLogById({
    required String auditId,
  }) async {
    try {
      final response = await ApiService().get(path: ApiPath.getAuditLog(auditId));
      if (response == null) {
        return null;
      }

      return ApiResponse.fromResponse(
        response,
        fromJson: (data) {
          if (data is Map && data['data'] is Map) {
            return AuditLogModel.fromJson(
              Map<String, dynamic>.from(data['data']),
            );
          }
          return null;
        },
      );
    } on Exception {
      return null;
    }
  }
}
