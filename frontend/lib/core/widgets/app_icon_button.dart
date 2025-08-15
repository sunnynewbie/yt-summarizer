import 'package:flutter/material.dart';

enum ButtonShape { round, roundedRectangle, rectangle }

class AppIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final ButtonShape shape;
  final double borderRadius;
  final BorderSide? border;
  final BoxShadow? boxShadow;
  final double? iconSize; // for when you're using an Icon in the child
  final bool disabledElevation;

  const AppIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor =Colors.white,
    this.foregroundColor,
    this.padding,
    this.shape = ButtonShape.roundedRectangle,
    this.borderRadius = 16.0,
    this.border,
    this.boxShadow,
    this.iconSize,
    this.disabledElevation = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    OutlinedBorder getShape() {
      switch (shape) {
        case ButtonShape.round:
          return const CircleBorder();
        case ButtonShape.roundedRectangle:
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          );
        case ButtonShape.rectangle:
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: border ?? BorderSide.none,
          );
      }
    }

    final effectivePadding = padding ??
        (shape == ButtonShape.round
            ? const EdgeInsets.all(8)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 12));

    final buttonStyle = IconButton.styleFrom(
      backgroundColor: backgroundColor ?? theme.colorScheme.primary,
      foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
      padding: effectivePadding,
      shape: getShape(),
      elevation:0,
      shadowColor: boxShadow?.color,
      splashFactory: NoSplash.splashFactory,
    );

    return IconButton(
      onPressed: onPressed,
      icon: child,
      style: buttonStyle,
      iconSize: iconSize,
      constraints: BoxConstraints(),
      padding: EdgeInsets.zero
      ,
    );
  }
}