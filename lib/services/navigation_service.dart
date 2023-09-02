
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/utils/locale/app_localization.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<void> navigateToDashBoard(route) {
    return navigatorKey.currentState!.pushNamed(route);
  }

  void showMyDialogTokenError(String message, String? title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        navigatorKey.currentState!.pop();
        navigateToLogout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title == null ? "Token Error" : title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showMyDialogCustomMgs(
      BuildContext context, String message, String? title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(AppLocalizations.of(context).translate('ok_button_text')),
      onPressed: () {
        navigatorKey.currentState!.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title == null ? "Token Error" : title,
        style: TextStyle(color: CustomColors.PrimaryColor),
      ),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<dynamic> navigateToLogout() {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil("", (Route<dynamic> route) => false);
  }
}
