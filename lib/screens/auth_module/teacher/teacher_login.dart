import 'package:appwrite/appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/stores/auth/auth_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';


class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool select_account = false;
  bool passwordVisible = true;

  //store
  late AuthStore _authStore;

  @override
  void didChangeDependencies() {
    _authStore = Provider.of<AuthStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
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
                      // SizedBox(
                      //   height: 48.3,
                      // ),

                      Image.asset("assets/logo/idea_logo.png",height: 200,width: 260,),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome!",
                        style: CustomTextStyle.WelcomeBig.copyWith(color: CustomColors.White),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Choose Account Type",
                        style: CustomTextStyle.subtitle.copyWith(color: CustomColors.White),
                      ),
                      SizedBox(
                        height: 47,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              select_account = !select_account;
                              Navigator.pushReplacementNamed(context, Routes.studentLogin);
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 72,
                                  width: 72,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1,color: Color(0xffF2F2F2)),
                                      //color: Colors.white
                                  ),
                                  child: Center(
                                      child:
                                     Image.asset("assets/logo/student.png",height: 50,width: 50,),
                                    //   SvgPicture.asset(
                                    //     "assets/logo/student.svg",
                                    //     height: 32,
                                    //     width: 32,
                                    //     color: Colors.white,
                                    //   )
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Student",
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              select_account = !select_account;
                             Navigator.pushReplacementNamed(context, Routes.teacherLogin);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Container(
                                    height: 72,
                                    width: 72,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 1,color: Color(0xffF2F2F2)),
                                        color: Colors.white
                                      //color: Color(0xffF2F2F2)
                                    ),
                                    child: Center(
                                        child: Image.asset("assets/logo/teacher.png",height: 50,width: 50,),
                                        // SvgPicture.asset(
                                        //   "assets/logo/teacher.svg",
                                        //   height: 32,
                                        //   width: 35.27,
                                        // )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Teacher",
                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                          headerName: 'User name',
                          hint: "Type Your Username",
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          //maxLength: 11,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your username";
                            }
                          }),
                      SizedBox(
                        height: 18,
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

                      const SizedBox(
                        height: 44,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "No Account? ",
                              style: CustomTextStyle.icontitle
                                  .copyWith(color: Colors.white),
                              children: [
                                TextSpan(
                                    text: 'Signup',
                                    style: CustomTextStyle.field
                                        .copyWith(color: Colors.white),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, Routes.teacherSignup);
                                      })
                              ])),
                      SizedBox(
                        height: 150,
                      ),
                      CustomButton(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              print("All fields are valid");
                              // try{
                              //   _authStore.createEmailSession(_emailController.text, _passwordController.text);
                              //   //Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                              // }catch(e){
                              //   print("Login Exception ::: $e");
                              // }
                              try{
                                Client client = Client()
                                    .setEndpoint("http://penciltech001.penciltech.xyz:9080/v1")
                                    .setProject("652e291be0c85ef77871")
                                    .setSelfSigned(status: true);
                                final account = Account(client);

                                final session = await account.createEmailSession(
                                    email: _emailController.text,
                                    password: _passwordController.text
                                );
                                Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                              }catch(e){
                                print("Login Exception ::: $e");
                              }

                            } else {
                              //_showErrorMessage("Please fill all the data");
                            }
                          },
                          //onTap: login,

                          buttonText: 'Login'),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
