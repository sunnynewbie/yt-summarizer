import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/app_icon_button.dart';

class PasswordIconButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClick;

  const PasswordIconButton({
    super.key,
    required this.isVisible,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onClick,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
    );
  }
}
