import 'package:flutter/material.dart';

import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';

class SnackbarHelper {
  static setDefault({
    // Style
    FlutterSnackBarStyle? style,
    // Configuration
    FlutterSnackBarConfiguration? configuration,
  }) =>
      FlutterSnackBar().initialize(configuration: configuration, style: style);

  static showTemplated(
    BuildContext context, {
    // Leading
    Widget? leading,
    // Main Content
    required String title,
    String? message,
    Widget? content,
    // Trailing
    Widget? trailing,
    // Style
    FlutterSnackBarStyle? style,
    // Configuration
    FlutterSnackBarConfiguration? configuration,
  }) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlutterSnackBar.showTemplated(context,
            title: title,
            leading: leading,
            message: message,
            content: content,
            trailing: trailing,
            style: style,
            configuration: configuration);
      });

  static showCustom(
    BuildContext context, {
    required Widget child,
    // Style
    FlutterSnackBarStyle? style = const FlutterSnackBarStyle(),
    // Configuration
    FlutterSnackBarConfiguration? configuration =
        const FlutterSnackBarConfiguration(),
  }) =>
      FlutterSnackBar.showCustom(context,
          child: child, configuration: configuration, style: style);
}
