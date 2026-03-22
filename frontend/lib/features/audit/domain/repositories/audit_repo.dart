import 'package:frontend/features/audit/data/models/audit_log_query_model.dart';
import 'package:frontend/features/audit/domain/entities/audit_log_model.dart';
import 'package:frontend/network/api_response.dart';

abstract class AuditRepository {
  Future<ApiResponse<List<AuditLogModel>>?> getAuditLogs({
    AuditLogQueryModel? query,
  });

  Future<ApiResponse<AuditLogModel?>?> getAuditLogById({
    required String auditId,
  });
}
