import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/batch_details_box.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/student_id_box.dart';
import 'package:idea_tuition_managment_app/widgets/student_info_box.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Profile',
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
                    StudentIDBox(
                      name: 'Naimul Hassan Noor',
                      studentID: '123456',
                      //departmentAndclass: 'Science 10',
                      needBottomField: true,
                      extrafieldValue: 'Change Password',
                      onTap: (){},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Student Details",
                      style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 315,
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //border: Border.all(width: 2),
                        color: Color(0xff492E51),
                        //color: Colors.transparent
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: 'Date of Birth',
                              value: '16-09-2023',
                              icon: "assets/info_icon/Calendar.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: 'Gender',
                              value: 'Male',
                              icon: "assets/info_icon/share.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: 'Blood Group',
                              value: 'B+',
                              icon: "assets/info_icon/Blood.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: "Father's Name",
                              value: 'Mr.Alam',
                              icon: "assets/info_icon/User_cicrle_duotone_line.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: "Mother's Name",
                              value: 'Nasrin Sultana Ahmend Nib',
                              icon: "assets/info_icon/User_cicrle_duotone_line.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: "Parent's phone",
                              value: '01733433672',
                              icon: "assets/info_icon/Phone.svg",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StudentInfoBox(
                              title: 'Address',
                              value: '1659,Palashpur, Dani,Dhaka-1236',
                              icon: "assets/info_icon/Map.svg",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Batch Details",
                      style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(gridDelegate:

                        const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 21.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 1/1.2
                    ),
                        //physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true ,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                      return BatchDetailsBox();
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    CustomButton(
                        onTap: ()  {

                            Navigator.pushNamed(context, Routes.editStudentProfile);

                        },
                        //onTap: login,

                        buttonText: 'Edit Profile')
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
