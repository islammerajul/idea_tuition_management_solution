import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
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
  late TextEditingController _genderController;
  late TextEditingController _fatherNameController;
  late TextEditingController _motherNameController;
  late TextEditingController _dateController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                        readOnly: true,
                          headerName: 'Date Of Birth',
                          //hint: "${data['DOB']}",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _dateController = TextEditingController(
                              text: "${data['DOB']}"
                          ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        readOnly: true,
                          headerName: 'Gender',
                          //hint: "${data['gender']}",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _genderController = TextEditingController(
                              text: "${data['gender']}"
                          ),
                          // keyboardType: TextInputType.text,
                          // //maxLength: 11,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Put your Gender";
                          //   }
                          // }
                          ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Gender",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 16,
                      //           color: CustomColors.White),
                      //     ),
                      //     SizedBox(
                      //       height: 11,
                      //     ),
                      //     DropdownButtonFormField(
                      //         iconEnabledColor: CustomColors.White,
                      //         value: select_gender,
                      //         dropdownColor: CustomColors.AppBarColor,
                      //         decoration: InputDecoration(
                      //           hintText: '${data['gender']}',
                      //           hintStyle: CustomTextStyle.icontitle
                      //               .copyWith(color: CustomColors.White),
                      //           filled: true,
                      //           fillColor: const Color(0xff492E51),
                      //           border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(5),
                      //               borderSide: BorderSide.none),
                      //         ),
                      //         items: gender
                      //             ?.map((item) => DropdownMenuItem(
                      //             value: item,
                      //             child: Text(item,
                      //                 style: TextStyle(
                      //                     fontSize: 14.0,
                      //                     fontWeight: FontWeight.w400,
                      //                     color: CustomColors.White))))
                      //             .toList(),
                      //         onChanged: (item) {
                      //           setState(() {
                      //             select_gender = item;
                      //           });
                      //         }),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          readOnly: true,
                          headerName: "Father's Name",
                          //hint: "${data['father_name']}",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _fatherNameController = TextEditingController(
                              text: "${data['father_name']}"
                          ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        readOnly: true,
                          headerName: "Mother's Name",
                          //hint: "${data['mother_name']}",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                          controller: _motherNameController = TextEditingController(
                              text: "${data['mother_name']}"
                          ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          readOnly: true,
                          headerName: "Parent's Phone",
                          //hint: "${data['phone_number']}",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCCDADC),
                          ),
                           controller: _phoneController = TextEditingController(
                               text: "${data['phone_number']}"
                           ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: 'Address',
                          hint: "Type Your address",
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                          controller: _addressController = TextEditingController(
                              text: "${data['address']}"
                          ),
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          ),
                      SizedBox(
                        height: 150,
                      ),

                      CustomButton(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              print("All fields are valid");
                              //Navigator.pushNamed(context, Routes.studentNavigationBar);
                              //Navigator.pushNamed(context, Routes.studentNavigationBar);
                              //_authStore.createEmailSession(_emailController.text, _passwordController.text);
                            print(_phoneController.text);
                            print(_fatherNameController.text);
                            print(_motherNameController.text);
                            print(_genderController.text);
                            print(_dateController.text);
                            print(_addressController.text);
                            } else {
                              //_showErrorMessage("Please fill all the data");
                            }
                          },
                          //onTap: login,

                          buttonText: 'Save')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
