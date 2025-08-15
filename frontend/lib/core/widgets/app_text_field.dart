import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool collapsed;
  final bool filled;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final TextStyle? textStyle;

  const AppTextField({
    Key? key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.textStyle,
    this.filled = true,
    this.prefix,
    this.suffixIcon,
    this.fillColor = const Color(0xfff2f2f2),
    this.borderColor,
    this.contentPadding,
    this.collapsed = false,
    this.validator,
    this.maxLines = 1,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: textStyle??context.labelLarge,
      decoration: InputDecoration.collapsed(hintText: hintText).copyWith(
        labelText: label,
        border: Theme.of(context).inputDecorationTheme.border,
        disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        focusedErrorBorder: Theme.of(
          context,
        ).inputDecorationTheme.focusedErrorBorder,
        fillColor: fillColor,
        hintStyle: textStyle,
        filled: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : prefix,
        suffixIcon: suffixIcon,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
