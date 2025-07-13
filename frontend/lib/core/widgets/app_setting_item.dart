import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';

import 'app_button.dart';

class AppSettingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AppSettingItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      titleTextStyle: context.labelLarge.w600,
      subtitleTextStyle: context.labelMedium.grey,
      subtitle: Text(subtitle),
      trailing:
          trailing ??
          AppButton(
            label: 'Update',
            elevation: 0,
            type: CustomButtonType.filled,
            color: AppColors.input,
            textStyle: context.labelSmall.s10.black.w600,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            height: 30,
            borderRadius: BorderRadius.circular(100),
            onPressed: onTap,
          ),
    );
  }
}
