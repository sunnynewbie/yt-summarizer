import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';

class AppMenuItem extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback onTap;
  final bool selected;

  const AppMenuItem({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: context.bodyLarge),
      leading: leading,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.only(left: 10),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      tileColor: selected ? AppColors.primaryForeground : Colors.transparent,
    );
  }
}
