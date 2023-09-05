import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/support_box.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Support',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SupportBox(
                    icon: "assets/message_icon.svg",
                    title: "Messages",
                    onTap: (){
                      Navigator.pushNamed(context, Routes.navigationBarScreen);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SupportBox(
                    icon: "assets/call.svg",
                    title: "Call",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SupportBox(
                    icon: "assets/email.svg",
                    title: "Email",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
