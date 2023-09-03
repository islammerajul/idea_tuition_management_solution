import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();

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
                            keyboardType: TextInputType.emailAddress,
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
                            keyboardType: TextInputType.emailAddress,
                            //maxLength: 11,
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
                            obscureText: true,
                            obscuringCharacter: '*',
                            maxLines: 1,
                            //maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
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
                            obscureText: true,
                            obscuringCharacter: '*',
                            maxLines: 1,
                            //maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Confirmed password";
                              }
                            }),
                        SizedBox(
                          height: 150,
                        ),
                        CustomButton(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                print("All fields are valid");
                                if(_passwordController != _confirmPasswordController){
                                  dialog.seCustomDialog(context,
                                      headerTitle: 'ERROR',
                                      desTitle: 'Password doesnot match',
                                      headerTitleColor: Colors.red,
                                      callback: (){
                                    Navigator.pop(context);
                                      }
                                  );
                                }
                                //_authStore.createEmailSession(_emailController.text, _passwordController.text);
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
                                          Navigator.pushNamed(context, Routes.studentLogin);
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
