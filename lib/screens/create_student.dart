import 'package:another_flushbar/flushbar_helper.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/batch_model.dart';
import 'package:idea_tuition_managment_app/models/package_model.dart';
import 'package:idea_tuition_managment_app/models/student_model.dart';
import 'package:idea_tuition_managment_app/stores/batch/batch_store.dart';
import 'package:idea_tuition_managment_app/stores/package/package_store.dart';
import 'package:idea_tuition_managment_app/stores/student/student_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/custom_image_picker_for_profile.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/show_error_dialog.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/text_form_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({super.key});

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _studentIDController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _institutionNameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _motherNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _parentEmailController = TextEditingController();
  TextEditingController _parentPhoneController = TextEditingController();

  AddMoreDialog dialog = AddMoreDialog();

  List<BatchModel> _batchList = [];
  List<PackageModel> _packageList = [];
  List<Map<String, dynamic>> batch_NameList = [];
  List<Map<String, dynamic>> package_NameList = [];

  //List<String> batch_documentID = ['653c970cc0e0551642bf', '6539ffa5cdf9be6d03aa'];
  List<String> batch_documentID = [];
  List<String> package_documentID = [];
  List<String?> batchNameList = [];
  List<String?> packageNameList = [];
  List<String>? selected_batch_list = [];
  List<String>? selected_package_list = [];
  List<String> gender = ['Male', 'Female'];
  String? select_gender;
  List<String> active_status = ['Active', 'Inactive'];
  String? select_active_status;
  List<String> package = ['Bijoy', 'Shadhin', 'Shimahin'];
  String? select_package;
  List<String> attendance = ['Present', 'Absent', 'Not start'];
  String? select_attendance;
  List<String> leave = ['Approved', 'Rejected', 'Due'];
  String? select_leave;
  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? select_bloodGroup;
  //List<String> batch = ['Class 10', 'Class 8', 'Class 9', 'Class 7'];
  String? select_batch;
  List<String> timeSchedule = ['7:00 AM', '8:00 AM', '9:00 AM', '7:00 PM'];
  String? select_timeSchedule;
  var batch_List;
  var package_List;

  late BatchStore batchStore;
  late StudentStore studentStore;
  late PackageStore packageStore;
  StudentModel studentModel = StudentModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    batchStore = Provider.of<BatchStore>(context);
    studentStore = Provider.of<StudentStore>(context);
    packageStore = Provider.of<PackageStore>(context);
    filterBatchList(batchStore.batchList);
    batchStore.getBatchList();
    packageStore.getPackageList();
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
                appbarTitle: 'Create Student',
                needLeading: true,
              )),

          body: Stack(
            children: [
              Observer(builder: (BuildContext context) {
                return (batchStore.loading && packageStore.loading)
                    ? const Center(child: CustomProgressIndicatorWidget())
                    : _mainContent(context);
              }),
              Observer(builder: (BuildContext context){
                if (studentStore.apicallstate == APICALLSTATE.LOADING){
                  return studentStore.success
                      ? _showSuccessMessage(studentStore.successMessage)
                      : _showErrorMessage(studentStore.noDataFound);
                }else {
                  return const SizedBox.shrink();
                }

              }),


            ],
          ),

          //body: _mainContent(context),
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
    studentStore.noDataFound="";
    return const SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    print('Success-$message');
    if (message.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createSuccess(
            message: message,
            title: "Create Student Sucessfully",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    studentStore.successMessage="";
    return const SizedBox.shrink();
  }

  _mainContent(context){
    return SingleChildScrollView(
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
                readOnly: true,
                headerName: 'Batch ID',
                style: CustomTextStyle.header,
                sizedboxHeight: 11,
                controller: TextEditingController(
                  text: _studentIDController.text = "st${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().minute}-${DateTime.now().millisecond}",
                ),
              ),
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
              TextFormFieldWidget(
                  headerName: "Student's email",
                  hint: "Type Your email",
                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!value.contains("@")) {
                      return "Invalid Email ";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              /*
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _batchStore.selected_batchName = select_batch!,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF3F0F0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  hint: Text("Select"),
                                  items: _batchStore.batchModelList.map<DropdownMenuItem<String>>((map) {
                                    return DropdownMenuItem<String>(
                                      value: map.batch_id,
                                      child: Text("${map.batch_id}"),
                                      // value: map['batch_id'],
                                      // child: Text("${map['batch_id']}"),
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      select_batch = item!;
                                      print(select_batch);
                                    });
                                  },
                                )

                              ],
                            )

                                /*
                            Column(
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
                            )
                            */
                        ),
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
                    */
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Blood Group",
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
                      value: select_bloodGroup,
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
                      items: bloodGroup
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
                          select_bloodGroup = item;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: 'Instituation',
                  hint: "Select Your Instituation",
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
                      return "Please enter your Instituation";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: "Father's name",
                  hint: "Please enter your father's name",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffCCDADC),
                  ),
                  controller: _fatherNameController,
                  keyboardType: TextInputType.text,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your father name";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: "Mother's name",
                  hint: "Please enter your mother's name",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffCCDADC),
                  ),
                  controller: _motherNameController,
                  keyboardType: TextInputType.text,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your mother name";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: "Parent's phone",
                  hint: "Type Your phone",
                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                  controller: _parentPhoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone";
                    }

                  }),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: "Parent's email",
                  hint: "Type Your email",
                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffCCDADC),),
                  controller: _parentEmailController,
                  keyboardType: TextInputType.emailAddress,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!value.contains("@")) {
                      return "Invalid Email ";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  headerName: "Address",
                  hint: "Please enter your address",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffCCDADC),
                  ),
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  //maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your address";
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Status",
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
                      value: select_active_status,
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
                      items: active_status
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
                          select_active_status = item;
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
                    "Batch",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  // DropdownButtonFormField(
                  //     iconEnabledColor: CustomColors.White,
                  //     value: batchStore.select_batchName = select_batch,
                  //     dropdownColor: CustomColors.AppBarColor,
                  //     decoration: InputDecoration(
                  //       hintText: 'Select Your Batch ',
                  //       hintStyle: CustomTextStyle.icontitle
                  //           .copyWith(color: CustomColors.White),
                  //       filled: true,
                  //       fillColor: const Color(0xff492E51),
                  //       border: OutlineInputBorder(
                  //           borderRadius:
                  //           BorderRadius.circular(5),
                  //           borderSide: BorderSide.none),
                  //     ),
                  //     items: batchStore.batchModelList
                  //         ?.map((item) => DropdownMenuItem(
                  //         value: item.batch_name,
                  //         child: Text("${item.batch_name}",
                  //             style: TextStyle(
                  //                 fontSize: 14.0,
                  //                 fontWeight: FontWeight.w400,
                  //                 color:
                  //                 CustomColors.White))))
                  //         .toList(),
                  //     onChanged: (item) {
                  //       setState(() {
                  //         select_batch = item;
                  //       });
                  //     }),

                ],
              ),
              FutureBuilder(
                future: filterBatchList(batchStore.batchList),
                builder: (BuildContext, Snapshot) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: batchNameList.map(
                          (batch_name) {
                        bool isSelected = false;
                        if (selected_batch_list!.contains(batch_name)) {
                          isSelected = true;
                        }
                        return GestureDetector(
                          onTap: () {
                            if (!selected_batch_list!.contains(batch_name)) {
                              if (selected_batch_list!.length < batchStore.batchList!.total ) {
                                selected_batch_list!.add(batch_name!);
                                setState(() {});
                                print("selected_chip_list");
                                print(selected_batch_list);
                              }
                            } else {
                              selected_batch_list!
                                  .removeWhere((element) => element == batch_name);
                              setState(() {});
                              print(selected_batch_list);
                            }
                          },
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                color: isSelected == true ? CustomColors.BoxColor
                                    : Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 13),
                                  child: Text(
                                      batch_name!,
                                      style: CustomTextStyle.subtitle2.copyWith(color:
                                      isSelected ? CustomColors.White : CustomColors.SmallTextColor,)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
                }
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  // DropdownButtonFormField(
                  //     iconEnabledColor: CustomColors.White,
                  //     value: packageStore.select_package = select_package!,
                  //     dropdownColor: CustomColors.AppBarColor,
                  //     decoration: InputDecoration(
                  //       hintText: 'Select Your Package ',
                  //       hintStyle: CustomTextStyle.icontitle
                  //           .copyWith(color: CustomColors.White),
                  //       filled: true,
                  //       fillColor: const Color(0xff492E51),
                  //       border: OutlineInputBorder(
                  //           borderRadius:
                  //           BorderRadius.circular(5),
                  //           borderSide: BorderSide.none),
                  //     ),
                  //     items: packageStore.packageModelList
                  //         ?.map((item) => DropdownMenuItem(
                  //         value: item.package_title,
                  //         child: Text("${item.package_title}",
                  //             style: TextStyle(
                  //                 fontSize: 14.0,
                  //                 fontWeight: FontWeight.w400,
                  //                 color:
                  //                 CustomColors.White))))
                  //         .toList(),
                  //     onChanged: (item) {
                  //       setState(() {
                  //         select_package = item;
                  //       });
                  //     }),

                ],
              ),
              FutureBuilder(
                  future: filterPackageList(packageStore.packageList),
                  builder: (BuildContext, Snapshot) {
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: packageNameList.map(
                            (package_title) {
                          bool isSelected = false;
                          if (selected_package_list!.contains(package_title)) {
                            isSelected = true;
                          }
                          return GestureDetector(
                            onTap: () {
                              if (!selected_package_list!.contains(package_title)) {
                                if (selected_package_list!.length < packageStore.packageList!.total ) {
                                  selected_package_list!.add(package_title!);
                                  setState(() {});
                                  print("selected_package_list");
                                  print(selected_package_list);
                                }
                              } else {
                                selected_package_list!
                                    .removeWhere((element) => element == package_title);
                                setState(() {});
                                print(selected_package_list);
                              }
                            },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  color: isSelected == true ? CustomColors.BoxColor
                                      : Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 13),
                                    child: Text(
                                        package_title!,
                                        style: CustomTextStyle.subtitle2.copyWith(color:
                                        isSelected ? CustomColors.White : CustomColors.SmallTextColor,)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  }
              ),
          /*
              SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Attendance",
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
                      value: select_attendance,
                      dropdownColor: CustomColors.AppBarColor,
                      decoration: InputDecoration(
                        hintText: 'Select Your Attendence ',
                        hintStyle: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                        filled: true,
                        fillColor: const Color(0xff492E51),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      items: attendance
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
                          select_attendance = item;
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
                    "Leave",
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
                      value: select_leave,
                      dropdownColor: CustomColors.AppBarColor,
                      decoration: InputDecoration(
                        hintText: 'Select Your Leave ',
                        hintStyle: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                        filled: true,
                        fillColor: const Color(0xff492E51),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      items: leave
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
                          select_leave = item;
                        });
                      }),

                ],
              ),
              */
              SizedBox(
                height: 100,
              ),
              CustomButton(
                  onTap: () async {


                    batch_documentID.clear();
                    for(int i = 0; i < batch_List.length; i++){
                      print("List will be arranged");
                      var document = batch_List[i].data;
                      for(int k = 0; k < selected_batch_list!.length; k++){
                        var matchListOfBatch = document.containsKey('batch_name') && document['batch_name'] == selected_batch_list?[k];
                        if(matchListOfBatch){
                          print("condition :: $matchListOfBatch");
                          batchStore.batch_documentID = document['\$id'];

                          batch_documentID.add(document['\$id']);
                        }
                      }
                    }
                    ///For Package
                    package_documentID.clear();
                    for(int j = 0; j < package_List.length; j++){
                      print("List will be arranged");
                      var document = package_List[j].data;
                      for(int l = 0; l < selected_package_list!.length; l++){
                        var matchListOfPackage = document.containsKey('title') && document['title'] == selected_package_list![l];
                        if(matchListOfPackage){
                          print("condition 2 :: $matchListOfPackage");
                          packageStore.package_documentID = document['\$id'];

                          package_documentID.add(document['\$id']);
                        }
                      }
                    }
                    print("Selected packages list lenght :: ${selected_package_list!.length}");




                    if (_formkey.currentState!.validate()) {
                      print("All fields are valid");
                      try{
                        studentModel = StudentModel(
                            student_id: _studentIDController.text,
                            student_name: _fullNameController.text,
                            st_phone: _phoneController.text,
                            st_email: _emailController.text,
                            st_gender: select_gender,
                            st_dob: _dateController.text,
                            st_institution: _institutionNameController.text,
                            st_image: studentStore.selected_img,
                            st_blood_group: select_bloodGroup,
                            st_father_name: _fatherNameController.text,
                            st_mother_name: _motherNameController.text,
                            st_parent_phone: _parentPhoneController.text,
                            st_parent_email: _parentEmailController.text,
                            st_address: _addressController.text,
                            active_status: select_active_status,
                          batch_DocID: batch_documentID,
                          packages_DocID: package_documentID,
                          //teachers_DocID: batch_documentID,
                          //grade_DocID: batch_documentID,
                        );
                        studentStore.createStudent(studentModel);
                        dialog.addMoreCustomDialog(context,
                            headerTitle: 'Congratulation',
                            desTitle: 'Create a student successfully',
                            headerTitleColor: Color(0xff0BC974),
                            callbackForAdd: (){
                              Navigator.pushReplacementNamed(context, Routes.createStudent);
                            }, callbackForCancled: (){
                              Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                            });
                      }catch(e){
                        print("Student create exception ::: $e");
                      }
                      /*
                      dialog.addMoreCustomDialog(context,
                          headerTitle: 'Congratulation',
                          desTitle: 'Student added',
                          headerTitleColor: Color(0xff0BC974),
                          callbackForAdd: (){
                            Navigator.pushReplacementNamed(context, Routes.createStudent);
                          }, callbackForCancled: (){
                            Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                          });
                      */
                    } else {
                      //_showErrorMessage("Please fill all the data");
                    }
                  },
                  //onTap: login,

                  buttonText: 'Add Student'),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(onPressed: (){
                filterBatchList(batchStore.batchList);
                //packageStore.packageModelList;
                filterPackageList(packageStore.packageList);
                packageStore.getPackageList();
                print("Select the student's batch name ::: ${batchStore.select_batchName}");
              }, child: Text("CLICK"))
            ],
          ),
        ),
      ),
    );
  }
  Future<String> filterBatchList(DocumentList? batchList) async {
    print("Now list is created");
    if (batchList == null) {
      // Handle the case where deliveryManList is null
      print("Batch Number:: null value");
      return "done";
    }
    var totalBatch = batchList!.total;
    print("Batch Number:: ${totalBatch}");
    batch_List = batchList!.documents.toList();
    print("Batch List:: ${batch_List}");
    List<Map<String, dynamic>> AllBatch = [];


    batchStore.TotalBatch = batch_List.length;
    print("Total Batch List number :: ${batchStore.TotalBatch}");
    for(int i = 0; i < batch_List.length; i++){
      print("List will be arranged");
      var document = batch_List[i].data;
      AllBatch.add(document);
      print("Show Batch names :: ${AllBatch}");
      var matchBatchName = document.containsKey('batch_name') && document['batch_name'] == batchStore.select_batchName;
      if(matchBatchName){
        print("condition :: $matchBatchName");
        batchStore.batch_documentID = document['\$id'];
      }
      // for(int k = 0; k < selected_chip_list!.length; k++){
      //   var matchListOfBatch = document.containsKey('batch_name') && document['batch_name'] == selected_chip_list![k];
      //   if(matchListOfBatch){
      //     print("condition :: $matchListOfBatch");
      //     batchStore.batch_documentID = document['\$id'];
      //     batch_documentID.add(document['\$id']);
      //   }else break;
      // }
    }
    for(var map in AllBatch){
      print("List will be arranged");
      if (map.containsKey('batch_name')) {
        batch_NameList.add({'batch_name': map['batch_name']});
      }
    }
    print("Delivery Man list ::: $batch_NameList");
    print("Delivery Man's Document ID ::: ${batchStore.batch_documentID}");
    print("Selected Batch Document ID ::: ${batch_documentID}");
    try{
      _batchList = AllBatch.map((data) => BatchModel.fromJson(data)).toList();
      batchNameList = _batchList.map((batch) => batch.batch_name).toList();
      print("All batch name as list ::: ${batchNameList}");
      print("All selected batch name as list ::: ${selected_batch_list}");
    }catch(e){
      print("exception:::${e}");
    }
    return "done";
  }


  Future<String> filterPackageList(DocumentList? packageList) async {
    print("Now Package list is created");
    if (packageList == null) {
      // Handle the case where deliveryManList is null
      print("Package Number:: null value");
      return "done";
    }
    var totalPackage = packageList!.total;
    print("Package Number:: ${totalPackage}");
    package_List = packageList!.documents.toList();
    print("Package List:: ${package_List}");
    List<Map<String, dynamic>> AllPackages = [];


    //batchStore.TotalBatch = batch_List.length;
    //print("Total Batch List number :: ${batchStore.TotalBatch}");
    for(int i = 0; i < package_List.length; i++){
      print("List will be arranged");
      var document = package_List[i].data;
      AllPackages.add(document);
      print("Show Packages names :: ${AllPackages}");
      // var matchBatchName = document.containsKey('batch_name') && document['batch_name'] == batchStore.select_batchName;
      // if(matchBatchName){
      //   print("condition :: $matchBatchName");
      //   batchStore.batch_documentID = document['\$id'];
      // }
    }
    for(var map in AllPackages){
      print("List will be arranged");
      if (map.containsKey('title')) {
        package_NameList.add({'title': map['title']});
      }
    }
    print("Package list ::: $package_NameList");
    print("Recent select Package Document ID ::: ${packageStore.package_documentID}");
    print("Selected Packages Document ID ::: ${package_documentID}");
    //print("Delivery Man's Document ID ::: ${batchStore.batch_documentID}");
    try{
      _packageList = AllPackages.map((data) => PackageModel.fromJson(data)).toList();
      packageNameList = _packageList.map((package) => package.package_title).toList();
      print("All packages name as list ::: ${packageNameList}");
      print("All selected packages name as list ::: ${selected_package_list}");
    }catch(e){
      print("exception:::${e}");
    }
    return "done";
  }

}
