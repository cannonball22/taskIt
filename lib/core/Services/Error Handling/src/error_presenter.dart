import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';

import '../../../../presentation/utils/SnackBar/snackbar.helper.dart';
import '../../Contexter/contexter.service.dart';
import 'error_model.dart';

class ErrorPresenter {
  static Future<void> present(AppError error) async {
    if (error.type == AppErrorType.generic) {
      //t2 Generic Error Presenting
      //
      return await SnackbarHelper.showTemplated(
        Contexter.currentContext,
        title: error.code,
        message: "A Generic error has occurred!",
        configuration: const FlutterSnackBarConfiguration(
          showDuration: Duration(seconds: 5),
        ),
        style: const FlutterSnackBarStyle(backgroundColor: Colors.red),
      );
      //
    } else if (error.type == AppErrorType.presentable) {
      //t2 Presentable Error Presenting
      //
      return await SnackbarHelper.showTemplated(
        Contexter.currentContext,
        title: error.code,
        message: error.msg,
        configuration: const FlutterSnackBarConfiguration(
          showDuration: Duration(seconds: 5),
        ),
        style: const FlutterSnackBarStyle(backgroundColor: Colors.red),
      );
      //
    }
  }
}
