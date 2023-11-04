import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/teacher_model.dart';
import 'package:idea_tuition_managment_app/stores/teacher_store/teacher_store.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class TeacherForm extends StatefulWidget {
  const TeacherForm({super.key});

  @override
  State<TeacherForm> createState() => _TeacherFormState();
}

class _TeacherFormState extends State<TeacherForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _institutionController = TextEditingController();

  late TeacherStore teacherStore;
  TeacherModel teacherModel = TeacherModel();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumController.dispose();
    _addressController.dispose();
    _institutionController.dispose();
    //myFocusNode?.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    teacherStore = Provider.of<TeacherStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Observer(builder: (BuildContext context) {
                return teacherStore.loading
                    ? const Center(child: CustomProgressIndicatorWidget())
                    : _mainContent(context);
              }),
              Observer(builder: (BuildContext context){
                if (teacherStore.apicallstate == APICALLSTATE.LOADING){
                  return teacherStore.success
                      ? _showSuccessMessage(teacherStore.successMessage)
                      : _showErrorMessage(teacherStore.noDataFound);
                }else {
                  return const SizedBox.shrink();
                }

              }),


            ],
          ),
        ));
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
    teacherStore.noDataFound="";
    return const SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    print('Success-$message');
    if (message.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createSuccess(
            message: message,
            title: "Create Teacher Sucessfully",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    teacherStore.successMessage="";
    return const SizedBox.shrink();
  }


  _mainContent(context){
    return Container(
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
                      focusNode: nameFocusNode,
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
                      focusNode: phoneFocusNode,
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
                      focusNode: emailFocusNode,
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
                      focusNode: addressFocusNode,
                      //maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type Your address ";
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),

                  TextFormFieldWidget(
                    headerName: 'Institution',
                    hint: "Type Your institution ",
                    hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                    controller: _institutionController,
                    keyboardType: TextInputType.text,
                    //maxLength: 11,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please type Your institution ";
                    //   }
                    // }
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  CustomButton(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          print("All fields are valid");
                          try{
                            teacherModel = TeacherModel(
                              teacher_name: _nameController.text,
                              teacher_phone: _phoneNumController.text,
                              teacher_email: _emailController.text,
                              teacher_address: _addressController.text,
                              teacher_institution: _institutionController.text,
                            );
                            teacherStore.createTeacher(teacherModel);
                          }catch(e){
                            print("Teacher create exception ::: $e");
                          }
                          //Navigator.pushNamed(context, Routes.navigationBarScreen);
                        } else {
                          if(_nameController.text.isEmpty){
                            FocusScope.of(context).requestFocus(nameFocusNode);
                          }
                          else if(_phoneNumController.text.isEmpty){
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                          }else if(_emailController.text.isEmpty){
                            FocusScope.of(context).requestFocus(emailFocusNode);
                          }else if(_addressController.text.isEmpty){
                            FocusScope.of(context).requestFocus(addressFocusNode);
                          }

                          //print("Something wrong");
                          //print("DM${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().millisecond}");
                        }
                      },
                      buttonText: 'Submit'),

                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
