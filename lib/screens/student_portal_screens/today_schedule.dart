import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/widgets/class_details_box.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';

class TodaySchedulScreen extends StatefulWidget {
  const TodaySchedulScreen({super.key});

  @override
  State<TodaySchedulScreen> createState() => _TodaySchedulScreenState();
}

class _TodaySchedulScreenState extends State<TodaySchedulScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Today’s Schedule',
                needLeading: true,
              )),
          body: Container(
            decoration: BoxDecoration(
              gradient: CustomColors.codeGradient,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 420,
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white12),
                        color: Color(0xff492E51),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context,index){
                            var length = 3;
                            return Column(
                              children: [
                                ClassDetailsBox(
                                  day: 'sun',
                                  date: '01/Jan',
                                  class_details: 'English Class with CT Exam (Class Teacher :Sourob Hassan)',
                                  starting_time: '11:30 am',
                                  ending_time: '12:30 pm',
                                ),
                                index != length ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.white12,
                                  ),
                                ) : SizedBox.shrink()
                              ],
                            );

                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
