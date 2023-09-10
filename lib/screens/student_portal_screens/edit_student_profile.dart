import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/student_id_box.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class EditStudentProfile extends StatefulWidget {
  const EditStudentProfile({super.key});

  @override
  State<EditStudentProfile> createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _motherNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Edit Profile',
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
                child: Form(
                  key: _formkey,
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
                      TextFormFieldWidget(
                          headerName: 'Date Of Birth',
                          hint: "Put your Date Of Birth",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _dateController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Put your Date Of Birth";
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: 'Gender',
                          hint: "Gender",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _genderController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Put your Gender";
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: "Father's Name",
                          hint: "Put your Father's Name",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _fatherNameController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Put your Father's Name";
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: "Mother's Name",
                          hint: "Put your Mother's Name",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _motherNameController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Put your Mother's Name";
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: "Parent's Phone",
                          hint: "Put your Parent's Phone number",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _phoneController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Put your Parent's Phone number";
                            }
                          }),
                      SizedBox(
                        height: 150,
                      ),

                      CustomButton(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              print("All fields are valid");
                              //Navigator.pushNamed(context, Routes.studentNavigationBar);
                              Navigator.pushNamed(context, Routes.studentNavigationBar);
                              //_authStore.createEmailSession(_emailController.text, _passwordController.text);
                            } else {
                              //_showErrorMessage("Please fill all the data");
                            }
                          },
                          //onTap: login,

                          buttonText: 'Login')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
