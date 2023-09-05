import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/package_box.dart';

class PackageMenu extends StatefulWidget {
  const PackageMenu({super.key});

  @override
  State<PackageMenu> createState() => _PackageMenuState();
}

class _PackageMenuState extends State<PackageMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Package',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: PackageBox(
                            title: 'বিজয়',
                            numOfStudent: '100',
                            numOfBatch: '20',
                            fees: '100',
                          )),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        flex: 1,
                          child: PackageBox(
                            title: 'স্বাধীন',
                            numOfStudent: '900',
                            numOfBatch: '20',
                            fees: '500',
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: PackageBox(
                            title: 'স্বাধীন',
                            numOfStudent: '100',
                            numOfBatch: '20',
                            fees: '100',
                          )),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                          flex: 1,
                          child: PackageBox(
                            title: 'সীমাহীন',
                            numOfStudent: 'Unlimited',
                            numOfBatch: 'Unlimited',
                            fees: '1000',
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
