import 'package:flutter/material.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_setting_item.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Settings',
        titleSpacing: 0,
        showBorder: false,
        textStyle: context.headlineSmall.w600,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Account', style: context.bodyLarge.w600),
          AppSettingItem(
            title: 'Profile',
            subtitle: 'Basic account settings will live here.',
            onTap: () {},
          ),
          AppSettingItem(
            title: 'Security',
            subtitle: 'Authentication and session settings.',
            onTap: () {},
          ),
          Text('Preferences', style: context.bodyLarge.w600),
          AppSettingItem(
            title: 'Application',
            subtitle: 'Client-side preferences and defaults.',
            onTap: () {},
          ),
          AppSettingItem(
            title: 'Audit Logs',
            subtitle: 'Review backend audit events in the admin view.',
            onTap: () => context.go(AppRoutes.auditLogs),
          ),
        ],
      ),
    );
  }
}
