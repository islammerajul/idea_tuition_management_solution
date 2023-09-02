import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'locale/app_localization.dart';

class AppToastMessage{


  static SizedBox showErrorMessage(String message,String title,Duration duration,BuildContext context) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: title,
          duration: duration,
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
  static SizedBox showSuccessMessage(String message,String title,Duration duration,BuildContext context) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: title,
          duration: duration,
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
  static SizedBox showInfoMessage(String message,String title,Duration duration,BuildContext context) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createInformation(
          message: message,
          title: title,
          duration: duration,
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
  static SizedBox showActionMessage(String message,String title,Duration duration,BuildContext context,{required Widget actionButton,required VoidCallback onClick}) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createAction(
          message: message,
          title: title,
          duration: duration,
          button: actionButton,
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
  static SizedBox showInputFlashBarMessage(String message,String title,Duration duration,BuildContext context,{required Widget actionButton,required VoidCallback onClick}) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createInputFlushbar(
          textForm: Form(child: Text("test"),),
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
  static SizedBox showLoaderMessage(String message,BuildContext context,) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createLoading(
            message: message,
            linearProgressIndicator: LinearProgressIndicator()

        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}
}

