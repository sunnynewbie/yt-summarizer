import 'package:flutter/material.dart';

// Enum for button type
enum CustomButtonType {
  filled,
  text,
  filledWithIcon,
  textWithIcon,
  outline,
  outlineWithIcon,
  elevated,
}

class AppButton extends StatelessWidget {
  final CustomButtonType type;
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final IconAlignment? iconAlignment;
  final double? height;
  final bool isLoading;
  final double? width;

  const AppButton({
    Key? key,
    required this.label,
    this.type = CustomButtonType.elevated,
    this.onPressed,
    this.icon,
    this.color,
    this.textColor,
    this.padding,
    this.elevation,
    this.borderSide,
    this.borderRadius,
    this.iconAlignment,
    this.textStyle,
    this.height,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = this.height ?? 38;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final TextStyle defaultTextStyle =
        textStyle ??
        textTheme.labelMedium!.copyWith(
          color: textColor ?? _getDefaultTextColor(theme),
          fontWeight: FontWeight.w600,
        );

    final EdgeInsetsGeometry effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0);

    final Widget? iconWidget = icon;
    final widget = isLoading
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              constraints: BoxConstraints(
                minHeight: 20,
                minWidth: 20,
                maxHeight: 20,
                maxWidth: 20,
              ),
            ),
          )
        : Text(label);
    switch (type) {
      case CustomButtonType.filled:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? theme.primaryColor,
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              ),
            ),
            child: widget,
          ),
        );

      case CustomButtonType.filledWithIcon:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? theme.primaryColor,
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              ),
            ),
            icon: iconWidget,
            iconAlignment: iconAlignment,
            label: widget,
            clipBehavior: Clip.hardEdge,
          ),
        );

      case CustomButtonType.textWithIcon:
        return SizedBox(
          height: height,
          width: width,
          child: TextButton.icon(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
            ),
            icon: iconWidget,
            iconAlignment: iconAlignment,
            label: widget,
          ),
        );
      case CustomButtonType.text:
        return SizedBox(
          height: height,
          width: width,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
            ),
            child: widget,
          ),
        );

      case CustomButtonType.outline:
        return SizedBox(
          height: height,
          width: width,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
              side: borderSide ?? BorderSide(color: theme.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              ),
            ),
            child: widget,
          ),
        );

      case CustomButtonType.outlineWithIcon:
        return SizedBox(
          height: height,
          width: width,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
              side: borderSide ?? BorderSide(color: theme.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              ),
            ),
            icon: iconWidget,
            iconAlignment: iconAlignment,
            label: widget,
          ),
        );

      case CustomButtonType.elevated:
      default:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? theme.primaryColor,
              foregroundColor: defaultTextStyle.color,
              textStyle: defaultTextStyle,
              padding: effectivePadding,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              ),
            ),
            child: widget,
          ),
        );
    }
  }

  Color _getDefaultTextColor(ThemeData theme) {
    switch (type) {
      case CustomButtonType.textWithIcon:
        return theme.primaryColor;
      case CustomButtonType.outline:
      case CustomButtonType.outlineWithIcon:
        return theme.primaryColor;
      case CustomButtonType.filled:
      case CustomButtonType.filledWithIcon:
      case CustomButtonType.elevated:
      default:
        return Colors.white;
    }
  }

  Color _getDefaultIconColor(ThemeData theme) {
    if ([
      CustomButtonType.textWithIcon,
      CustomButtonType.outline,
      CustomButtonType.outlineWithIcon,
    ].contains(type)) {
      return theme.primaryColor;
    }
    return Colors.white;
  }
}
