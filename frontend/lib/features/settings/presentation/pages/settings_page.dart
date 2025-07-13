import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_setting_item.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';

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
          AppSettingItem(title: '', subtitle: '', onTap: () {}),
          AppSettingItem(title: '', subtitle: '', onTap: () {}),
          Text('Preferences', style: context.bodyLarge.w600),
          AppSettingItem(title: '', subtitle: '', onTap: () {}),
          AppSettingItem(title: '', subtitle: '', onTap: () {}),
        ],
      ),
    );
  }
}
