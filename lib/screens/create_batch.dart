import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class CreateBatch extends StatefulWidget {
  const CreateBatch({super.key});

  @override
  State<CreateBatch> createState() => _CreateBatchState();
}

class _CreateBatchState extends State<CreateBatch> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _batchNameController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _institutionNameController = TextEditingController();
  List<String> timeSchedule = ['7:00 AM', '8:00 AM', '9:00 AM', '7:00 PM'];
  String? select_timeSchedule = '7:00 AM';
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
                appbarTitle: 'Create Batch',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldWidget(
                        headerName: 'Batch Name',
                        hint: "Please enter your Batch Name",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _batchNameController,
                        keyboardType: TextInputType.text,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your batch name";
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        headerName: 'Student ',
                        hint: "Please enter your Student Name",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _studentController,
                        keyboardType: TextInputType.text,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Student name";
                          }
                        }),
                    SizedBox(
                      height: 200,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            print("All fields are valid");
                            dialog.addMoreCustomDialog(context,
                                headerTitle: 'Congratulation',
                                desTitle: 'Create a batch successfully',
                                headerTitleColor: Color(0xff0BC974),
                                callbackForAdd: (){
                                  Navigator.pushReplacementNamed(context, Routes.createBatch);
                                }, callbackForCancled: (){
                                  Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                                });
                            //Navigator.pushNamed(context, Routes.navigationBarScreen);
                          } else {
                            //_showErrorMessage("Please fill all the data");
                          }
                        },
                        //onTap: login,

                        buttonText: 'Add Now')

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
