import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:gap/gap.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;
  final TextStyle? textStyle;
  final double? titleSpacing;
  final bool showBorder;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.titleWidget,
    this.textStyle,
    this.titleSpacing,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ?? Text(title, style: textStyle ?? TextStyle().s16.w600),
      actions: [...?actions, Gap(20)],
      leading: leading,
      titleSpacing: titleSpacing,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: showBorder
          ? Border(bottom: BorderSide(color: AppColors.border, width: .5))
          : Border(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
