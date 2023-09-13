import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({super.key});

  @override
  State<TeacherSignupScreen> createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  CustomSEdialog dialog = CustomSEdialog();

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
                                child: Image.asset("assets/logo/teacher.png",height: 45,width: 45,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text("I am a , \nteacher",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23,color: CustomColors.White),),
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
                            headerName: 'Password',
                            hint: "Type Your Password",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _passwordController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: passwordVisible,
                            obscuringCharacter: '*',
                            maxLines: 1,
                            //maxLength: 11,
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: CustomColors.White,),
                              onPressed: () {
                                setState(
                                      () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value.isEmpty) {
                                return 'Please enter password';
                              } else {
                                if (value.toString().length < 8) {
                                  return 'Password must be 8 characters';
                                }
                                if (!regex.hasMatch(value)) {
                                  return 'Enter valid password';
                                }
                                else {
                                  return null;
                                }
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormFieldWidget(
                            headerName: 'Confirm Password',
                            hint: "Type Your Confirmed Password",
                            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: confirmPasswordVisible,
                            obscuringCharacter: '*',
                            maxLines: 1,
                            //maxLength: 11,
                            suffixIcon: IconButton(
                              icon: Icon(confirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: CustomColors.White,),
                              onPressed: () {
                                setState(
                                      () {
                                    confirmPasswordVisible = !confirmPasswordVisible;
                                  },
                                );
                              },
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value.isEmpty) {
                                return 'Please enter your Confirmed password';
                              } else {
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  return 'Enter valid password ';
                                }
                                else {
                                  return null;
                                }
                              }
                            }),
                        SizedBox(
                          height: 150,
                        ),
                        CustomButton(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                print("All fields are valid");
                                //_authStore.createEmailSession(_emailController.text, _passwordController.text);
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  dialog.seCustomDialog(context,
                                      headerTitle: 'ERROR',
                                      desTitle: 'Password doesnot match',
                                      headerTitleColor: Colors.red, callback: () {
                                        Navigator.pop(context);
                                      });
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.studentNavigationBar);
                                }
                              } else {
                                //_showErrorMessage("Please fill all the data");
                              }
                            },
                            //onTap: login,

                            buttonText: 'Sign Up'),
                        SizedBox(
                          height: 32,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "No Account? ",
                                style: CustomTextStyle.field
                                    .copyWith(color: Colors.white,fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                      text: 'Sign in',
                                      style: CustomTextStyle.field
                                          .copyWith(color: Colors.white),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context, Routes.teacherLogin);
                                        })
                                ])),
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
