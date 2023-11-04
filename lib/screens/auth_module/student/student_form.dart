import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff492E51),
                      Color(0xff181D2A),
                      Color(0xff252D52),
                    ])
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 31, right: 26),
                    child: Column(
                      children: [
                        Image.asset("assets/logo/idea_logo.png",height: 200,width: 260,),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Center(
                                child: Image.asset("assets/logo/student.png",height: 45,width: 45,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text("I am a , \nstudent",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23,color: CustomColors.White),),
                          ],
                        ),
                        SizedBox(
                          height: 34,
                        ),
                        TextFormFieldWidget(
                            headerName: 'Full name',
                            hint: "Please enter your Full name",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            //maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Full name";
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        TextFormFieldWidget(
                            headerName: 'Phone Number',
                            hint: "Type Your phone number",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _phoneNumController,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please type Your phone number";
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        TextFormFieldWidget(
                            headerName: 'Email',
                            hint: "Type Your Email ",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            //maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please type Your Email ";
                              }
                              if (!value.contains("@")) {
                                return "Invalid Email ";
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),

                        TextFormFieldWidget(
                            headerName: 'Address',
                            hint: "Type Your address ",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _addressController,
                            keyboardType: TextInputType.text,
                            //maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please type Your address ";
                              }
                            }),
                        SizedBox(
                          height: 150,
                        ),
                        CustomButton(
                            onTap: () async {

                            },
                            buttonText: 'Submit'),

                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
