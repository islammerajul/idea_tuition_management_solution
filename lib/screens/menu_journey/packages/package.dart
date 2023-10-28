import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/package_model.dart';
import 'package:idea_tuition_managment_app/stores/package/package_store.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _packageTitleController = TextEditingController();
  final TextEditingController _packageDesController = TextEditingController();
  final TextEditingController _packageFeeController = TextEditingController();
  late PackageStore packageStore;
  late PackageModel packageModel = PackageModel();
  AddMoreDialog dialog = AddMoreDialog();

  FocusNode packageTitleFocusNode = FocusNode();
  FocusNode packageDesFocusNode = FocusNode();
  FocusNode packageFeeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _packageTitleController.dispose();
    _packageDesController.dispose();
    _packageFeeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    packageStore = Provider.of<PackageStore>(context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (BuildContext context) {
          return packageStore.loading
              ? const Center(child: CustomProgressIndicatorWidget())
              : _mainContent(context);
        }),
        Observer(builder: (BuildContext context){
          if (packageStore.apicallstate == APICALLSTATE.LOADING){
            return packageStore.success
                ? _showSuccessMessage(packageStore.successMessage)
                : _showErrorMessage(packageStore.noDataFound);
          }else {
            return const SizedBox.shrink();
          }

        }),


      ],
    );
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
    packageStore.noDataFound="";
    return const SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    print('Success-$message');
    if (message.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createSuccess(
            message: message,
            title: "Create Customer Sucessfully",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    packageStore.successMessage="";
    return const SizedBox.shrink();
  }


  _mainContent(context){
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: 'Package',
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
                        headerName: 'Package Title',
                        hint: "Please enter package title",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _packageTitleController,
                        keyboardType: TextInputType.text,
                        focusNode: packageTitleFocusNode,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter package title";
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        headerName: 'Description',
                        hint: "Please enter description",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _packageDesController,
                        keyboardType: TextInputType.text,
                        focusNode: packageDesFocusNode,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter description";
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        headerName: 'Package fee',
                        hint: "Please enter package fee",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCCDADC),
                        ),
                        controller: _packageFeeController,
                        keyboardType: TextInputType.number,
                        focusNode: packageFeeFocusNode,
                        //maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter package fee";
                          }
                        }),
                    SizedBox(
                      height: 200,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            print("All fields are valid");
                            try{
                              packageModel = PackageModel(
                                package_title: _packageTitleController.text,
                                package_description: _packageDesController.text,
                                package_fee: _packageFeeController.text,
                              );
                              packageStore.createPackage(packageModel);
                              dialog.addMoreCustomDialog(context,
                                  headerTitle: 'Congratulation',
                                  desTitle: 'Create a batch successfully',
                                  headerTitleColor: Color(0xff0BC974),
                                  callbackForAdd: (){
                                    Navigator.pushReplacementNamed(context, Routes.package);
                                  }, callbackForCancled: (){
                                    Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                                  });
                            }catch(e){
                              print("Batch create exception ::: $e");
                            }
                            //Navigator.pushNamed(context, Routes.navigationBarScreen);
                          } else {
                            if(_packageTitleController.text.isEmpty){
                              FocusScope.of(context).requestFocus(packageTitleFocusNode);
                            }
                            else if(_packageDesController.text.isEmpty){
                              FocusScope.of(context).requestFocus(packageDesFocusNode);
                            }
                            else if(_packageFeeController.text.isEmpty){
                              FocusScope.of(context).requestFocus(packageFeeFocusNode);
                            }

                            print("Something wrong");
                          }
                        },
                        //onTap: login,

                        buttonText: 'Create a new Package')

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
