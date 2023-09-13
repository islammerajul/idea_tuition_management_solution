
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/constants/preferences.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScreen> {
  //
  // late SplashStore splashStore;
  // late OrderStore orderStore;
  // late SharedPreferenceHelper sharedPreferenceHelper;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.studentLogin);
    });
  }
  @override
  void didChangeDependencies() {
    // splashStore = Provider.of<SplashStore>(context);
    // orderStore = Provider.of<OrderStore>(context);
    //
    // splashStore.getProductList();
    // splashStore.getAppSettings();

    super.didChangeDependencies();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: CustomColors.codeGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo/idea_logo.png",height: 200,width: 300,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Dholaimama",
                  //       style: CustomTextStyle.SplashTextColor,
                  //     ),
                  //     Text(
                  //       "Admin",
                  //       style: CustomTextStyle.SplashTextColor,
                  //     ),
                  //   ],
                  // ),
                  // Observer(
                  //   builder: (context) {
                  //     return splashStore.loading
                  //         ?  Container(
                  //            height: 50,
                  //            width: 50,
                  //            margin: const EdgeInsets.only(top: 50), child: const CircularProgressIndicator(color: Colors.white,))
                  //            : const SizedBox(height: 50,width: 50,);
                  //   },
                  // ),


                ],
              ),
            ),
            // Observer(
            //   builder: (context) {
            //     var data=splashStore.success;
            //     print("successdata::${data}");
            //     return splashStore.success
            //         ? navigate(context)
            //         : const SizedBox.shrink();
            //   },
            // ),


          ],
        ),
    );
  }


  // Widget navigate(BuildContext context) {
  //   print("init navigate");
  //   Future.delayed(const Duration(milliseconds: 2000), () async {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     print(preferences.getBool(Preferences.is_logged_in));
  //
  //     if (preferences.getBool(Preferences.is_logged_in) ?? false) {
  //       if(preferences.getBool(Preferences.local_auth_status) ?? false) {
  //         //Navigator.of(context).pushReplacementNamed(Routes.localAuthScreen);
  //       }else{
  //         //Navigator.of(context).pushReplacementNamed(Routes.coreNavigation);
  //       }
  //     } else {
  //       //Navigator.of(context).pushReplacementNamed(Routes.login);
  //     }
  //   });
  //   return Container();
  // }
}

