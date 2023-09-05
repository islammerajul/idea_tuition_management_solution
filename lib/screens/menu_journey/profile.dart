import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/custom_image_picker_for_profile.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<String> gender = ['Male', 'Female'];
  String? select_gender = 'Male';

  AddMoreDialog dialog = AddMoreDialog();
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImagePickerForProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                      headerName: 'Full name',
                      hint: "Please enter your Full name",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCDADC),
                      ),
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      //maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your full name";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                      headerName: 'User name',
                      hint: "Please enter your user name",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCDADC),
                      ),
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      //maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your username";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                      headerName: 'Phone number',
                      hint: "Type Your phone number",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCDADC),
                      ),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your username";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                      headerName: 'Email',
                      hint: "Please enter your Email",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCDADC),
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Email";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: CustomColors.White),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              DropdownButtonFormField(
                                  iconEnabledColor: CustomColors.White,
                                  value: select_gender,
                                  dropdownColor: CustomColors.AppBarColor,
                                  decoration: InputDecoration(
                                    hintText: 'Select',
                                    hintStyle: CustomTextStyle.icontitle
                                        .copyWith(color: CustomColors.White),
                                    filled: true,
                                    fillColor: const Color(0xff492E51),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                  ),
                                  items: gender
                                      ?.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color:
                                              CustomColors.White))))
                                      .toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      select_gender = item;
                                    });
                                  }),
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: TextFormFieldWidget(
                            headerName: 'Dob',
                            hint: "DD-MM-YYYY",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffCCDADC),
                            ),
                            controller: _dateController,
                            keyboardType: TextInputType.datetime,
                            maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your username";
                              }
                            },
                            suffixIcon: IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                  DateFormat('dd-MM-yyyy')
                                      .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    _dateController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },

                              icon: Icon(Icons.calendar_month_outlined,color: CustomColors.White,),

                            ),
                          )),


                    ],
                  ),

                  SizedBox(
                    height: 100,
                  ),
                  CustomButton(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          print("All fields are valid");
                          Navigator.pushNamed(context, Routes.navigationBarScreen);
                          // dialog.addMoreCustomDialog(context,
                          //     headerTitle: 'Congratulation',
                          //     desTitle: 'Student added',
                          //     headerTitleColor: Color(0xff0BC974),
                          //     callbackForAdd: (){
                          //       Navigator.pushNamed(context, Routes.createStudent);
                          //     }, callbackForCancled: (){
                          //       Navigator.pushNamed(context, Routes.navigationBarScreen);
                          //     });
                          //Navigator.pushNamed(context, Routes.navigationBarScreen);
                        } else {
                          //_showErrorMessage("Please fill all the data");
                        }
                      },
                      //onTap: login,

                      buttonText: 'Update Profile')
                ],
              ),
            ),
          ),
        ));
  }
}
