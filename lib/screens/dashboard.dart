import 'package:another_flushbar/flushbar_helper.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/data/api/api_appwrite.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/shared_preference_helper.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/stores/teacher_store/teacher_store.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_schedule.dart';
import 'package:idea_tuition_managment_app/widgets/dashboard_box.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/add_more_dialogs.dart';
import 'package:idea_tuition_managment_app/widgets/dialogs/email_not_match.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:idea_tuition_managment_app/widgets/task_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/constants/preferences.dart' as aw;


import '../utils/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<String> month = ['January', 'February', 'March'];
  String? select_month = 'January';
  int count = 0;
  AddMoreDialog dialog = AddMoreDialog();
  bool hasFilteredTeacherList = false;



  //late BatchStore batchStore;
  //late StudentStore studentStore;
  //late PackageStore packageStore;
  late TeacherStore teacherStore;
  @override
  void initState() {
    super.initState();
    getPreference();
    // teacherStore = Provider.of<TeacherStore>(context);
     //filterTeacherList( teacherStore.teacherList);
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
     teacherStore = Provider.of<TeacherStore>(context);
     teacherStore.getTeacherList();
     teacherStore.teacherList;
    // Ensure you have the teacherList data before calling filterTeacherList
    if (teacherStore.teacherList == null) {
      // Fetch the teacher list if it's not available
      teacherStore.getTeacherList().then((_) {
        // Now that you have the teacher list, call your filtering function
          filterTeacherList(teacherStore.teacherList);

      });
    } else {
      // If the teacher list is already available, simply call the filtering function
        filterTeacherList(teacherStore.teacherList);
    }

  }


  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> arg =
    // ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // count = arg['arg1'];

    return SafeArea(
        top: true,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              child: AppBar(
                backgroundColor: CustomColors.AppBarColor,
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.White),
                ),
                centerTitle: true,
                leading: Row(
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        _scaffoldkey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        "assets/menu.svg",
                        height: 20,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Container(
                    height: 32,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/notification.svg",
                            height: 27.14,
                            width: 32.1,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  )
                ],
                //leading: SvgPicture.asset("assets/menu.svg",height: 20,width: 24,fit: BoxFit.cover,),
              ),
              preferredSize: Size.fromHeight(toolbarHeight)),
          drawer: CustomDrawer(),

          body: Stack(
            children: [
              Observer(builder: (BuildContext context) {
                print("loadListsuccess is :: ${teacherStore.loading}");
                return teacherStore.loading
                    ? const Center(child: CustomProgressIndicatorWidget())
                    : _mainContent(context);
              }),

              // Observer(builder: (BuildContext context){
              //   if (teacherStore.apicallstate == APICALLSTATE.LOADING){
              //     return teacherStore.success
              //         ? _showSuccessMessage(teacherStore.successMessage)
              //         : _showErrorMessage(teacherStore.noDataFound);
              //   }else {
              //     return const SizedBox.shrink();
              //   }
              //
              // }),


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
            title: "Create Customer Sucessfully",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    teacherStore.successMessage="";
    return const SizedBox.shrink();
  }


  _mainContent(context){
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Overview",
                          style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                        )),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        //iconEnabledColor: CustomColors.White,
                          iconDisabledColor: Colors.blue,
                          //dropdownColor: Colors.blue,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          hint: Text("Today",style: CustomTextStyle.field.copyWith(color: CustomColors.White),),
                          items: month
                              ?.map((item) => DropdownMenuItem(
                              value: item, child: Text(item)))
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              select_month = item;
                            });
                          }),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DashboardBox(
                        title: "Today’s class",
                        value: "22",
                        textStyle: CustomTextStyle.subtitle2,
                        colorOfValueField: CustomColors.titleBlack,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: DashboardBox(
                        title: "Today’s Batch",
                        value: "50",
                        textStyle: CustomTextStyle.subtitle2,
                        colorOfValueField: CustomColors.titleBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DashboardBox(
                        title: "Active Students",
                        value: "50",
                        textStyle: CustomTextStyle.subtitle2,
                        colorOfValueField: CustomColors.titleBlack,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: DashboardBox(
                        title: "Active Batch",
                        value: "35",
                        textStyle: CustomTextStyle.subtitle2,
                        colorOfValueField: CustomColors.titleBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 27,
                ),

                Text(
                  "Task",
                  style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TaskWidget(
                          icon: "assets/person.svg",
                          task: "Create Students",
                          onTap: (){
                            Navigator.pushNamed(context, Routes.createStudent);
                          },
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: TaskWidget(
                        icon: "assets/person.svg",
                        task: "Create Batch",
                        onTap: (){
                          Navigator.pushNamed(context, Routes.createBatch);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TaskWidget(
                          icon: "assets/person.svg",
                          task: "Create Payment",
                          onTap: (){
                            //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateOrders()));
                            Navigator.pushNamed(context, Routes.createPayment);
                          },
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: TaskWidget(
                        icon: "assets/person.svg",
                        task: "Create Notice",
                        onTap: (){

                          Navigator.pushReplacementNamed(context, Routes.createNotice);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today’s Schedule",
                      style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                    ),
                    Text(
                      "2 May 2023",
                      style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                    )                    ],
                ),
                SizedBox(
                  height: 20,
                ),
                //count == 0 ? Text("New User") : Text("Old User"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CustomColors.White
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        CustomSchedule(
                          time: '7:00 pm',
                          slot: 'Morning',
                          batch_name: 'Class 10 Morning Batch',
                          batch_num: '10',
                        ),
                        CustomSchedule(
                          time: '7:00 pm',
                          slot: 'Evening',
                          batch_name: 'Class 10 Evening Batch',
                          batch_num: '10',
                        ),
                        CustomSchedule(
                          time: '8:00 pm',
                          slot: 'No Batch',
                        ),
                        CustomSchedule(
                          time: '9:00 pm',
                          slot: 'No Batch',
                        ),
                        CustomSchedule(
                          time: '9:00 pm',
                          slot: 'Morning',
                          batch_name: 'Class 9 Morning Batch',
                          batch_num: '9',
                        ),
                        CustomSchedule(
                          time: '10:00 pm',
                          slot: 'No Batch',
                        ),

                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
         //if (count == 0) {Text("New User")},
        if(count == 0) TeacherNotFoundDialog()
      ],
    );
  }

  Future<bool> filterTeacherList( DocumentList? teacherList) async {
    print("Now list is created");
    if (teacherList == null) {
      // Handle the case where deliveryManList is null
      print("Teacher Number:: null value");
      //return "done";
    }
    var totalTeacher = teacherList!.total;
    print("Teacher Number:: ${totalTeacher}");
    var teacher_List = teacherList!.documents.toList();
    print("Teacher List:: ${teacher_List}");
    List<Map<String, dynamic>> AllTeacher = [];

    //batchStore.TotalBatch = batch_List.length;
    //print("Total Payment List number :: ${batchStore.TotalBatch}");
    for(int i = 0; i < teacher_List.length; i++){
      print("List will be arranged");
      var document = teacher_List[i].data;
      AllTeacher.add(document);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var checkEmailList = document.containsKey('email') && document['email'] == preferences.getString(aw.Preferences.user_email);

      if(checkEmailList){
        count++;
        if(count == 1){
          var d = document['\$id'];
        }
      }
      //print("How many email are same : $count");
    }
    hasFilteredTeacherList = true;
    print("How many email are same : $count");


    try{
      //_paymentList = AllPayment.map((data) => PaymentModel.fromJson(data)).toList();
      // batchNameList = _batchList.map((batch) => batch.batch_name).toList();
      // print("All Payment name as list ::: ${batchNameList}");
      //print("All selected Payment name as list ::: ${selected_batch_list}");
    }catch(e){
      print("exception:::${e}");
    }
    //return "done";
    // Return a flag indicating whether the dialog should be shown
    //hasFilteredTeacherList = false;
    return count == 0;
  }

  Future getPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    teacherStore.teacher_email = preferences.getString(aw.Preferences.user_email)!;
        print("Get User Session :: ${preferences.getString(aw.Preferences.user_email)}");
  }

}

