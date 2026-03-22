import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/audit/domain/entities/audit_log_model.dart';
import 'package:frontend/features/audit/domain/usecases/audit_usecase.dart';
import 'package:frontend/network/api_response.dart';
import 'package:gap/gap.dart';

class AuditLogsPage extends StatefulWidget {
  const AuditLogsPage({super.key});

  @override
  State<AuditLogsPage> createState() => _AuditLogsPageState();
}

class _AuditLogsPageState extends State<AuditLogsPage> {
  final GetAuditLogsUsecase _getAuditLogsUsecase = GetAuditLogsUsecase();
  late Future<ApiResponse<List<AuditLogModel>>?> _future;

  @override
  void initState() {
    super.initState();
    _future = _getAuditLogsUsecase.call(null);
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _getAuditLogsUsecase.call(null);
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Audit Logs',
        titleSpacing: 0,
        showBorder: false,
        textStyle: context.headlineSmall.w600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Administrative view of backend audit events.',
              style: context.labelMedium.grey,
            ),
            const Gap(16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<ApiResponse<List<AuditLogModel>>?>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final response = snapshot.data;
                    final logs = response?.data ?? const <AuditLogModel>[];

                    if (logs.isEmpty) {
                      return ListView(
                        children: [
                          const Gap(120),
                          Center(
                            child: Text(
                              response?.message ??
                                  'No audit logs available. This page expects an admin audit API at /audit-logs.',
                              textAlign: TextAlign.center,
                              style: context.bodyMedium.grey,
                            ),
                          ),
                        ],
                      );
                    }

                    return ListView.separated(
                      itemCount: logs.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '${log.action} • ${log.outcome}',
                            style: context.labelLarge.w600,
                          ),
                          subtitle: Text(
                            '${log.http_method} ${log.route_path ?? ''}\n'
                            '${log.feature_area ?? 'unknown'} • ${log.created_at.toLocal()}',
                            style: context.labelMedium.grey,
                          ),
                          isThreeLine: true,
                          trailing: log.status_code == null
                              ? null
                              : Text(
                                  '${log.status_code}',
                                  style: context.labelMedium.w600,
                                ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
