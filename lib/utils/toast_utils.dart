import 'package:control_stock_web_admin/core/theme.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class ToastUtils {
  static showToast(BuildContext context, String title, String message, ToastType type) {
    if (type == ToastType.success) {
      ElegantNotification.success(
        width: 600,
        showProgressIndicator: false,
        animationCurve: Curves.ease,
        position: Alignment.bottomRight,
        animation: AnimationType.fromRight,
        title: Text(title),
        description: Text(message),
        shadow: BoxShadow(
          color: colorScheme.primary.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4), // changes position of shadow
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadiusCornerInside),
        ),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ).show(context);
    } else if (type == ToastType.error) {
      ElegantNotification.error(
        width: 600,
        showProgressIndicator: false,
        animationCurve: Curves.ease,
        position: Alignment.bottomRight,
        animation: AnimationType.fromRight,
        title: Text(title),
        description: Text(message),
        shadow: BoxShadow(
          color: colorScheme.error.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4), // changes position of shadow
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadiusCornerInside),
        ),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
      ).show(context);
    } else if (type == ToastType.warning) {
      ElegantNotification.info(
        width: 600,
        showProgressIndicator: false,
        animationCurve: Curves.ease,
        position: Alignment.bottomRight,
        animation: AnimationType.fromRight,
        title: Text(title),
        description: Text(message),
        shadow: BoxShadow(
          color: colorScheme.tertiary.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4), // changes position of shadow
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadiusCornerInside),
        ),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.tertiary,
            width: 2,
          ),
        ),
      ).show(context);
    } else if (type == ToastType.info) {
      ElegantNotification.info(
        width: 600,
        showProgressIndicator: false,
        animationCurve: Curves.ease,
        position: Alignment.bottomRight,
        animation: AnimationType.fromRight,
        title: Text(title),
        description: Text(message),
        shadow: BoxShadow(
          color: colorScheme.secondary.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4), // changes position of shadow
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadiusCornerInside),
        ),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.secondary,
            width: 2,
          ),
        ),
      ).show(context);
    }
  }
}
