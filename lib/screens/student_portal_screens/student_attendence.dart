import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/class_details_box.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/successfull_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/unsuccessfull_dialog.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  SuccessfullDialog dialog = SuccessfullDialog();
  UnsuccessfullDialog unsuccessfullDialog = UnsuccessfullDialog();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Attendance',
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today’s Class",
                          style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                        ),
                        Text(
                          "2 May 2023",
                          style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                        )                    ],
                    ),
                    SizedBox(
                      height: 31,
                    ),
                    InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, Routes.scheduleOfToday);
                        // dialog.successDialog(context,
                        //     headerTitle: 'Attendance',
                        //     message: 'attendance on (Bangla 10) successfully ',
                        //     headerTitleColor: Color(0xff0BC974),
                        //     callbackForCancled: (){
                        //   Navigator.pop(context);
                        //     });
                        unsuccessfullDialog.unSuccessfullDialog(context,
                            headerTitle: 'Unsuccessful',
                            message: 'Please go to to turion center first',
                            callbackForOK: (){
                              Navigator.pop(context);
                            },
                            callbackForCancled: (){
                              Navigator.pop(context);
                            });
                      },
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
                                  present_status: 'Present',
                                  status_needed: true,
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
