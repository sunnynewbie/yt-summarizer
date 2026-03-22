import 'package:frontend/features/audit/data/datasources/audit_datasource.dart';
import 'package:frontend/features/audit/data/models/audit_log_query_model.dart';
import 'package:frontend/features/audit/domain/entities/audit_log_model.dart';
import 'package:frontend/features/audit/domain/repositories/audit_repo.dart';
import 'package:frontend/network/api_response.dart';

class AuditRepoImpl extends AuditRepository {
  final AuditDataSource dataSource = AuditDataSourceImpl();

  @override
  Future<ApiResponse<List<AuditLogModel>>?> getAuditLogs({
    AuditLogQueryModel? query,
  }) {
    return dataSource.getAuditLogs(query: query);
  }

  @override
  Future<ApiResponse<AuditLogModel?>?> getAuditLogById({
    required String auditId,
  }) {
    return dataSource.getAuditLogById(auditId: auditId);
  }
}
