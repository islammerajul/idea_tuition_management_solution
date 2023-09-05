import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';

class CreateNotice extends StatefulWidget {
  const CreateNotice({super.key});

  @override
  State<CreateNotice> createState() => _CreateNoticeState();
}

class _CreateNoticeState extends State<CreateNotice> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  CustomSEdialog dialog = CustomSEdialog();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Create Notice',
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
                        headerName: 'Title',
                        hint: "Please enter your title",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your title";
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        headerName: 'Text message',
                        // hint: "Please enter your title",
                        // hintStyle: TextStyle(
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w400,
                        //   color: Color(0xffCCDADC),
                        // ),
                        controller: _messageController,
                        keyboardType: TextInputType.text,
                        //maxLength: 11,
                        maxLines: 20,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your message";
                          }
                        }),
                    SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            print("All fields are valid");
                            dialog.seCustomDialog(context,
                                headerTitle: 'Congratulation',
                                desTitle: 'Create a notice successfully',
                                headerTitleColor: Color(0xff0BC974),
                                 callback: () {
                                  //Navigator.pushNamed(context, Routes.navigationBarScreen);
                                  Navigator.pushNamed(context, Routes.noticeList);
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
