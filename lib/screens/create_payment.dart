import 'package:another_flushbar/flushbar_helper.dart';
import 'package:appwrite/models.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/payment_model.dart';
import 'package:idea_tuition_managment_app/stores/batch/batch_store.dart';
import 'package:idea_tuition_managment_app/stores/payment/payment_store.dart';
import 'package:idea_tuition_managment_app/stores/student/student_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

class CreatePayment extends StatefulWidget {
  const CreatePayment({super.key});

  @override
  State<CreatePayment> createState() => _CreatePaymentState();
}

class _CreatePaymentState extends State<CreatePayment> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December',];
  String? select_month;
  String? select_student;
  String? select_batch;
  List<String> paymentStatus = ['Paid', 'Due'];
  String? select_paymentStatus;
  String? student_name;
  String? selected_studentName;
  String? selected_batchName;
  String? selected_month;
  String? FinalPaymentStatus;
  bool? matchBatchName;
  bool? matchStudentName;
  bool? matchMonth;
  var document;

  late PaymentStore paymentStore;
  late BatchStore batchStore;
  late StudentStore studentStore;
  PaymentModel paymentModel = PaymentModel();
  AddMoreDialog dialog = AddMoreDialog();

  //StudentModel studentModel = StudentModel();
  List<PaymentModel> _paymentList = [];
  List<Map<String, dynamic>> batch_NameList = [];

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
    paymentStore = Provider.of<PaymentStore>(context);
    //packageStore = Provider.of<PackageStore>(context);
    //filterBatchList(batchStore.batchList);
    batchStore.getBatchList();
    studentStore.getStudentList();
    paymentStore.getPaymentList();
    //packageStore.getPackageList();
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
              appbarTitle: 'Create Payment',
              needLeading: true,
            )),
        body: Stack(
          children: [
            Observer(builder: (BuildContext context) {
              return (studentStore.loading && batchStore.loading && paymentStore.loading)
                  ? const Center(child: CustomProgressIndicatorWidget())
                  : _mainContent(context);
            }),
            Observer(builder: (BuildContext context){
              if (paymentStore.apicallstate == APICALLSTATE.LOADING){
                return studentStore.success
                    //? _showErrorMessage(studentStore.noDataFound)
                //: _showSuccessMessage(studentStore.successMessage);
                ? _showSuccessMessage(studentStore.successMessage)
                    : _showErrorMessage(studentStore.noDataFound);
              }else {
                return const SizedBox.shrink();
              }

            }
            ),


          ],
        ),
      ),
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
            title: "Create Payment Sucessfully",
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
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Month",
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
                        value: select_month,
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
                        items: month
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
                            select_month = item;
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




                             DropdownButtonFormField(
                                iconEnabledColor: CustomColors.White,
                                value: select_batch,
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
                                items: batchStore.batchModelList
                                    ?.map((item) => DropdownMenuItem(
                                    value: item.document_id,
                                    child: Text("${item.batch_name}",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            CustomColors.White))))
                                    .toList(),
                                onChanged: (item) {
                                  setState(() {
                                    select_batch = item;
                                    print("@@@Selected Batch ::: $select_batch}");
                                  });
                                })




                    // )                  FutureBuilder(
                    //     future: batchStore.getBatchList(),
                    //     builder: (BuildContext, Snapshot) {
                    //       if(Snapshot.hasData){
                    //         return DropdownButtonFormField(
                    //             iconEnabledColor: CustomColors.White,
                    //             value: select_batch,
                    //             dropdownColor: CustomColors.AppBarColor,
                    //             decoration: InputDecoration(
                    //               hintText: 'Select',
                    //               hintStyle: CustomTextStyle.icontitle
                    //                   .copyWith(color: CustomColors.White),
                    //               filled: true,
                    //               fillColor: const Color(0xff492E51),
                    //               border: OutlineInputBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(5),
                    //                   borderSide: BorderSide.none),
                    //             ),
                    //             items: batchStore.batchModelList
                    //                 ?.map((item) => DropdownMenuItem(
                    //                 value: item.document_id,
                    //                 child: Text("${item.batch_name}",
                    //                     style: TextStyle(
                    //                         fontSize: 14.0,
                    //                         fontWeight: FontWeight.w400,
                    //                         color:
                    //                         CustomColors.White))))
                    //                 .toList(),
                    //             onChanged: (item) {
                    //               setState(() {
                    //                 select_batch = item;
                    //                 print("@@@Selected Batch ::: $select_batch}");
                    //               });
                    //             });
                    //       }
                    //       // else{
                    //       //   return SizedBox(
                    //       //       height: 20,
                    //       //       width: 20,
                    //       //       child: CustomProgressIndicatorWidget());
                    //       // }
                    //       return SizedBox.shrink();
                    //
                    //     }
                    // ),

                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Student",
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
                        value: select_student,
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
                        items: studentStore.studentModelList
                            ?.map((item) => DropdownMenuItem(
                            value: item.student_documentID,
                            child: Text("${item.student_name}",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    CustomColors.White))))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            select_student = item;
                            print("Student info :: ${select_student}");
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
                      "Payment Status",
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
                        value: select_paymentStatus,
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
                        items: paymentStatus
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
                            select_paymentStatus = item;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                CustomButton(
                    onTap: () async {
                      //Navigator.pushNamed(context, Routes.navigationBarScreen);
                      if (_formkey.currentState!.validate()) {
                        print("All fields are valid");
                        try{
                          paymentModel = PaymentModel(
                            payment_status: select_paymentStatus,
                            month: select_month,
                            batch: select_batch,
                            students: select_student,
                            //teachers_DocID: batch_documentID,
                            //grade_DocID: batch_documentID,
                          );
                          paymentStore.createPayment(paymentModel);
                          // if( APICALLSTATE.RESPONSE==paymentStore.apicallstate){
                          //   Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                          // }

                          // dialog.addMoreCustomDialog(context,
                          //     headerTitle: 'Congratulation',
                          //     desTitle: 'Create a student successfully',
                          //     headerTitleColor: Color(0xff0BC974),
                          //     callbackForAdd: (){
                          //       Navigator.pushReplacementNamed(context, Routes.createStudent);
                          //     }, callbackForCancled: (){
                          //       Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                          //     });
                        }catch(e){
                          print("Payment create exception ::: $e");
                        }

                        // dialog.addMoreCustomDialog(context,
                        //     headerTitle: 'Congratulation',
                        //     desTitle: paymentStore.successMessage,
                        //     headerTitleColor: Color(0xff0BC974),
                        //     callbackForAdd: (){
                        //       Navigator.pushReplacementNamed(context, Routes.createPayment);
                        //     }, callbackForCancled: (){
                        //       Navigator.pushReplacementNamed(context, Routes.navigationBarScreen);
                        //     });

                      } else {
                        //_showErrorMessage("Please fill all the data");
                      }
                    },
                    buttonText: 'Create Payment'),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text("OR",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),)),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                    onTap: () async {
                      filterPaymentList(paymentStore.paymentList);
                      if(matchBatchName! && matchStudentName! && matchMonth!){
                        print("condition :: $matchBatchName");
                        FinalPaymentStatus = document['payment_status'];
                        print("Final Payment Status :: ${document['payment_status']}");
                        //batchStore.batch_documentID = document['\$id'];
                      }else{
                        FinalPaymentStatus = "Due";
                      }
                      //Navigator.pushNamed(context, Routes.navigationBarScreen);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                backgroundColor: Color(0xff3A2544),
                                insetPadding: EdgeInsets.all(10),
                                child: Stack(
                                  clipBehavior: Clip.none, alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height * 0.50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        //color: Color(0xff3A2544)
                                      ),
                                      padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Payment Status",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 24,
                                                color: CustomColors.typeofGreen),
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Student name : $selected_studentName",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Batch name : $selected_batchName",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Month : $select_month",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Payment Status : $FinalPaymentStatus",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              //Navigator.pushNamed(context, Routes.createPayment);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)
                                                  ),
                                                  color: Colors.green
                                              ),
                                              child: Center(
                                                child: Text("OK",style: CustomTextStyle.field
                                                    .copyWith(color: CustomColors.White),),
                                              ),
                                            ),
                                          ),
                                          // CustomButton(
                                          //   height: 39,
                                          //   onTap: callbackForCancled,
                                          //   buttonText: 'Cancled',
                                          //   buttonColor: Colors.red,
                                          //   //myTextStyle: TextStyle(fontSize: 18,color: Colors.white),
                                          //   myTextStyle: CustomTextStyle.field
                                          //       .copyWith(color: CustomColors.White),
                                          //   padding:
                                          //   EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                          // )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: -50,
                                        right: 20,
                                        child: Image.asset(
                                          "assets/success.png",
                                          height: 98,
                                          width: 98,
                                        )
                                    )
                                  ],
                                )
                            );
                          });
                    },
                    buttonText: 'Show Payment'),
              ],
            ),
          ),
        ));
  }

  Future<String> filterPaymentList(DocumentList? paymentList) async {
    print("Now list is created");
    if (paymentList == null) {
      // Handle the case where deliveryManList is null
      print("Payment Number:: null value");
      return "done";
    }
    var totalPayment = paymentList!.total;
    print("Payment Number:: ${totalPayment}");
    var payment_List = paymentList!.documents.toList();
    print("Payment List:: ${payment_List}");
    List<Map<String, dynamic>> AllPayment = [];


    //batchStore.TotalBatch = batch_List.length;
    //print("Total Payment List number :: ${batchStore.TotalBatch}");
    for(int i = 0; i < payment_List.length; i++){
      print("List will be arranged");
      document = payment_List[i].data;
      AllPayment.add(document);
      student_name = document['students']['student_name'];
      print("student name :: ${document['students']['student_name']}");
      print("student name :: ${document['students']['\$id']}");
      print("Batch name :: ${document['batch']['batch_name']}");
      print("Batch name :: ${document['batch']['\$id']}");
      print("Month :: ${document['month']}");
      print("Month :: ${document['\$id']}");
      print("Payment Status :: ${document['payment_status']}");
      print("Show Payment names :: ${AllPayment}");
      // var matchBatchName = document.containsKey('batch_name') && document['batch_name'] == batchStore.select_batchName;
      // if(matchBatchName){
      //   print("condition :: $matchBatchName");
      //   batchStore.batch_documentID = document['\$id'];
      // }
      matchStudentName = document.containsKey('students') && document['students']['\$id'] == select_student;
      selected_studentName = document['students']['student_name'];
      for(int j = 0; j < payment_List.length; j++){
        matchBatchName = document.containsKey('batch') && document['batch']['\$id'] == select_batch;
        selected_batchName = document['batch']['batch_name'];
        for(int k = 0; k < payment_List.length; k++){
          matchMonth = document.containsKey('month') && document['month'] == select_month;
          // if(matchBatchName! && matchStudentName! && matchMonth!){
          //   print("condition :: $matchBatchName");
          //   FinalPaymentStatus = document['payment_status'];
          //   print("Final Payment Status :: ${document['payment_status']}");
          //   //batchStore.batch_documentID = document['\$id'];
          // }
        }
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
    // for(var map in AllBatch){
    //   print("List will be arranged");
    //   if (map.containsKey('batch_name')) {
    //     batch_NameList.add({'batch_name': map['batch_name']});
    //   }
    // }
    // print("Payment list ::: $batch_NameList");
    // print("Payment Document ID ::: ${batchStore.batch_documentID}");
    // print("Selected Payment Document ID ::: ${batch_documentID}");
    try{
      _paymentList = AllPayment.map((data) => PaymentModel.fromJson(data)).toList();
      // batchNameList = _batchList.map((batch) => batch.batch_name).toList();
      // print("All Payment name as list ::: ${batchNameList}");
      //print("All selected Payment name as list ::: ${selected_batch_list}");
    }catch(e){
      print("exception:::${e}");
    }
    return "done";
  }

}
