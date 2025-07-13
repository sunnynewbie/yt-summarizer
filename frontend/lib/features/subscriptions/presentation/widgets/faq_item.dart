import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';

class FaqItem extends StatelessWidget {
  const FaqItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('data'),
      children: [],
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.border, width: .5),
      ),
      iconColor: AppColors.mutedForeground,
      collapsedIconColor: AppColors.mutedForeground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.border, width: .5),
      ),
    );
  }
}
