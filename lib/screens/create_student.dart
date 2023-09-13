import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/custom_image_picker_for_profile.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:intl/intl.dart';

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({super.key});

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _institutionNameController = TextEditingController();

  AddMoreDialog dialog = AddMoreDialog();

  List<String> gender = ['Male', 'Female'];
  String? select_gender = 'Male';
  List<String> batch = ['Class 10', 'Class 8', 'Class 9', 'Class 7'];
  String? select_batch = 'Class 10';
  List<String> timeSchedule = ['7:00 AM', '8:00 AM', '9:00 AM', '7:00 PM'];
  String? select_timeSchedule = '7:00 AM';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Create Student',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 16, right: 16),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Batch",
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
                                  value: select_batch,
                                    dropdownColor: CustomColors.AppBarColor,
                                    decoration: InputDecoration(
                                      hintText: 'Select Your Batch ',
                                      hintStyle: CustomTextStyle.icontitle
                                          .copyWith(color: CustomColors.White),
                                      filled: true,
                                      fillColor: const Color(0xff492E51),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none),
                                    ),
                                    items: batch
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
                                        select_batch = item;
                                      });
                                    }),
                              ],
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time schedule",
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
                                  value: select_timeSchedule,
                                    dropdownColor: CustomColors.AppBarColor,
                                    decoration: InputDecoration(
                                      hintText: 'Select Your time ',
                                      hintStyle: CustomTextStyle.icontitle
                                          .copyWith(color: CustomColors.White),
                                      filled: true,
                                      fillColor: const Color(0xff492E51),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none),
                                    ),
                                    items: timeSchedule
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
                                        select_timeSchedule = item;
                                      });
                                    }),
                              ],
                            )),
                      ],
                    ),
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
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        headerName: 'Instituation',
                        hint: "Select Your students",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _institutionNameController,
                        keyboardType: TextInputType.text,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your username";
                          }
                        }),
                    SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            print("All fields are valid");
                            dialog.addMoreCustomDialog(context,
                                headerTitle: 'Congratulation',
                                desTitle: 'Student added',
                                headerTitleColor: Color(0xff0BC974),
                                callbackForAdd: (){
                              Navigator.pushReplacementNamed(context, Routes.createStudent);
                                }, callbackForCancled: (){
                                  Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                            });
                            //Navigator.pushNamed(context, Routes.navigationBarScreen);
                          } else {
                            //_showErrorMessage("Please fill all the data");
                          }
                        },
                        //onTap: login,

                        buttonText: 'Add Student')
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
