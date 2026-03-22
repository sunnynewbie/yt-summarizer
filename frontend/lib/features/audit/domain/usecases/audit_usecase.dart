import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/audit/data/models/audit_log_query_model.dart';
import 'package:frontend/features/audit/data/repositories/audit_repository.dart';
import 'package:frontend/features/audit/domain/entities/audit_log_model.dart';
import 'package:frontend/features/audit/domain/repositories/audit_repo.dart';
import 'package:frontend/network/api_response.dart';

class GetAuditLogsUsecase
    extends UseCase<ApiResponse<List<AuditLogModel>>?, AuditLogQueryModel?> {
  final AuditRepository repository = AuditRepoImpl();

  @override
  Future<ApiResponse<List<AuditLogModel>>?> call(AuditLogQueryModel? params) {
    return repository.getAuditLogs(query: params);
  }
}

class GetAuditLogByIdUsecase
    extends UseCase<ApiResponse<AuditLogModel?>?, String> {
  final AuditRepository repository = AuditRepoImpl();

  @override
  Future<ApiResponse<AuditLogModel?>?> call(String params) {
    return repository.getAuditLogById(auditId: params);
  }
}
