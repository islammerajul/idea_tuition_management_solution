import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/batch_model.dart';
import 'package:idea_tuition_managment_app/stores/batch/batch_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class CreateBatch extends StatefulWidget {
  const CreateBatch({super.key});

  @override
  State<CreateBatch> createState() => _CreateBatchState();
}

class _CreateBatchState extends State<CreateBatch> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _batchNameController = TextEditingController();
  TextEditingController _batchIDController = TextEditingController();
  TextEditingController _batchFeeController = TextEditingController();
  List<String> timePeriod = ['7:00 AM', '8:00 AM', '9:00 AM', '6:00 PM','7:00 PM', '8:00 PM',];
  String select_timePeriod = '7:00 AM';
  List<String> schedule = ['sat, mon, wed', 'sun, tue, thu'];
  String select_schedule = 'sat, mon, wed';
  List<String> activeStatus = ['Active', 'Inactive'];
  String select_activeStatus = 'Active';
  AddMoreDialog dialog = AddMoreDialog();

  late BatchStore batchStore;
  late BatchModel batchModel = BatchModel();

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _batchFeeController.dispose();
    _batchIDController.dispose();
    _batchNameController.dispose();
    //myFocusNode?.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    batchStore = Provider.of<BatchStore>(context);
    super.didChangeDependencies();
  }

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
          body: Stack(
            children: [
              Observer(builder: (BuildContext context) {
                return batchStore.loading
                    ? const Center(child: CustomProgressIndicatorWidget())
                    : _mainContent(context);
              }),
              Observer(builder: (BuildContext context){
                if (batchStore.apicallstate == APICALLSTATE.LOADING){
                  return batchStore.success
                      ? _showSuccessMessage(batchStore.successMessage)
                      : _showErrorMessage(batchStore.noDataFound);
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
    batchStore.noDataFound="";
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
    batchStore.successMessage="";
    return const SizedBox.shrink();
  }

  _mainContent(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                readOnly: true,
                headerName: 'Batch ID',
                style: CustomTextStyle.header,
                sizedboxHeight: 11,
                controller: TextEditingController(
                  text: _batchIDController.text = "bt${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().minute}-${DateTime.now().millisecond}",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: 'Batch Name',
                  hint: "Please enter your Batch Name",
                  hintStyle: CustomTextStyle.header.copyWith(fontSize: 14),
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
                    "Schedule",
                    style: CustomTextStyle.header,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  DropdownButtonFormField(
                      iconEnabledColor: CustomColors.White,
                      value: select_schedule,
                      dropdownColor: CustomColors.AppBarColor,
                      decoration: InputDecoration(
                        hintText: 'Select Your schedule',
                        hintStyle: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                        filled: true,
                        fillColor: const Color(0xff492E51),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      items: schedule
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
                          select_schedule = item!;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time Period",
                    style: CustomTextStyle.header,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  DropdownButtonFormField(
                      iconEnabledColor: CustomColors.White,
                      value: select_timePeriod,
                      dropdownColor: CustomColors.AppBarColor,
                      decoration: InputDecoration(
                        hintText: 'Select Your time period ',
                        hintStyle: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                        filled: true,
                        fillColor: const Color(0xff492E51),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      items: timePeriod
                          ?.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: CustomTextStyle.header.copyWith(fontSize: 14))))
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          select_timePeriod = item!;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active/Inactive Batch",
                    style: CustomTextStyle.header,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  DropdownButtonFormField(
                      iconEnabledColor: CustomColors.White,
                      value: select_activeStatus,
                      dropdownColor: CustomColors.AppBarColor,
                      decoration: InputDecoration(
                        hintText: 'Select Your time period ',
                        hintStyle: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                        filled: true,
                        fillColor: const Color(0xff492E51),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      items: activeStatus
                          ?.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: CustomTextStyle.header.copyWith(fontSize: 14))))
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          select_activeStatus = item!;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: 'Amount',
                  hint: "Enter batch fee",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffCCDADC),
                  ),
                  controller: _batchFeeController,
                  keyboardType: TextInputType.number,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter batch fee";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              /*
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
                    */
              SizedBox(
                height: 200,
              ),
              CustomButton(
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      print("All fields are valid");
                      try{
                        batchModel = BatchModel(
                            batch_id: _batchIDController.text,
                            batch_name: _batchFeeController.text,
                            schedule: select_schedule,
                            time_period: select_timePeriod,
                            amount: _batchFeeController.text,
                            batch_status: select_activeStatus
                        );
                        batchStore.createBatch(batchModel);
                        dialog.addMoreCustomDialog(context,
                            headerTitle: 'Congratulation',
                            desTitle: 'Create a batch successfully',
                            headerTitleColor: Color(0xff0BC974),
                            callbackForAdd: (){
                              Navigator.pushReplacementNamed(context, Routes.createBatch);
                            }, callbackForCancled: (){
                              Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                            });
                      }catch(e){
                        print("Batch create exception ::: $e");
                      }
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
    );
  }
}
