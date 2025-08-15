import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static final ToastUtil _instace = ToastUtil._internal();

  ToastUtil._internal();

  factory ToastUtil() => _instace;

  showSuccessToast(String msg) {
    Toastification().show(
      title: Text(msg),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
    );
  }

  showFailedToast(String msg) {
    Toastification().show(
      title: Text(msg),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
    );
  }

  showWarningToast(String msg) {
    Toastification().show(
      title: Text(msg),
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
    );
  }

  showInfoToast(String msg) {
    Toastification().show(
      title: Text(msg),
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
    );
  }
}
