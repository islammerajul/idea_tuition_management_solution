import 'package:another_flushbar/flushbar_helper.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_login.dart';
import 'package:idea_tuition_managment_app/stores/auth/auth_store.dart';
import 'package:idea_tuition_managment_app/stores/teacher_store/teacher_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

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

  String? userID;

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  CustomSEdialog dialog = CustomSEdialog();

  //store
  late AuthStore _authStore;
  late TeacherStore teacherStore;

  @override
  void didChangeDependencies() {
    _authStore = Provider.of<AuthStore>(context);
    teacherStore = Provider.of<TeacherStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: mainBody(context)),
        Observer(
          builder: (context) {
            disableErrorBoundaries: false;
            print("success-obj for Signup :: ${_authStore.success}");
            return _authStore.success
                ? _navigate(context)
                : _showErrorMessage(_authStore.noDataFound);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _authStore.loading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  mainBody(BuildContext context){
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
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    // Client client = Client()
                                    //     .setEndpoint("http://penciltech001.penciltech.xyz:9080/v1")
                                    //     .setProject("652e291be0c85ef77871")
                                    //     .setSelfSigned(status: true);
                                    // Account account = Account(client);
                                    // final user = await account.create(
                                    //   userId: ID.unique(),
                                    //   name: _nameController.text,
                                    //   email: _emailController.text,
                                    //   password: _passwordController.text,
                                    // );

                                    //teacherStore.teacher_email = _emailController.text;
                                    print("User Name : ${_nameController.text}");
                                    print("Email : ${_emailController.text}");
                                    print("Password : ${_passwordController.text}");
                                    userID = "6548a${DateTime.now().year}${DateTime.now().month}d${DateTime.now().day}f${DateTime.now().minute}e${DateTime.now().millisecond}";
                                    _authStore.createSignUp(_nameController.text, _emailController.text, _passwordController.text);
                                    // if(_authStore.signup_status == true){
                                    //   Navigator.pushReplacementNamed(context, Routes.teacherLogin);
                                    // }
                                  }
                                  // Navigator.pushReplacementNamed(
                                  //     context, Routes.navigationBarScreen);
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

  // General Methods:-----------------------------------------------------------

  Widget _navigate(context){
    print("success SignUP");
    WidgetsBinding.instance.addPostFrameCallback((_){

      // Add Your Code here.
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const TeacherLoginScreen()));
    });
    return SizedBox.shrink();
  }
  _showErrorMessage(String message) {
    print('error-$message');
    if (message.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: "Error",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    _setStoreValueAgain();


    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setStoreValueAgain() {
    _authStore.noDataFound="";
  }
}
