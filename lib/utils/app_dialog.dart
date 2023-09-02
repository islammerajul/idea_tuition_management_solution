
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog{

  showDialog({
    required BuildContext context,
    required VoidCallback onOkPress,
    required VoidCallback onDismissCallBack,
    required String title,
    required String decs,
    required DialogType dialogType,
    required AnimType animType,
    required IconData icon
  }) {
    AwesomeDialog(
        context: context,
        animType: animType,
        headerAnimationLoop: false,
        dialogType: dialogType,
        showCloseIcon: false,
        title: title,
        desc: decs,
        btnOkOnPress: onOkPress,
        btnOkIcon: icon,
        onDismissCallback: (type) {onDismissCallBack;})
      ..show();
    return SizedBox.shrink();
  }
}