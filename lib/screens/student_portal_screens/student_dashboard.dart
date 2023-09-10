import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/screens/student_drawer.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/class_details_box.dart';
import 'package:idea_tuition_managment_app/widgets/dashboard_box.dart';
import 'package:idea_tuition_managment_app/widgets/student_id_box.dart';
import 'package:idea_tuition_managment_app/widgets/task_widget.dart';

class StudentPortalDashboard extends StatefulWidget {
  const StudentPortalDashboard({super.key});

  @override
  State<StudentPortalDashboard> createState() => _StudentPortalDashboardState();
}

class _StudentPortalDashboardState extends State<StudentPortalDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<String> month = ['January', 'February', 'March'];
  String? select_month = 'January';

  @override
  Widget build(BuildContext context) {
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
          drawer: StudentDrawer(),
          body: Container(
            decoration: BoxDecoration(
              gradient: CustomColors.codeGradient,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentIDBox(
                      name: 'Naimul Hassan Noor',
                      studentID: '123456',
                      departmentAndclass: 'Science 10',
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          flex: 1,
                          child: DropdownButtonFormField(
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
                            title: "Today’s attendance",
                            value: "22",
                            color: Color(0xff492E51),
                            staticValue: '30',
                            onTap: (){
                              Navigator.pushNamed(context, Routes.studentAttendance);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: DashboardBox(
                            title: "Today’s active batch",
                            value: "5",
                            color: Color(0xff492E51),
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
                            title: "Total Leave",
                            value: "20",
                            color: Color(0xff492E51),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: DashboardBox(
                            title: "Grade",
                            value: "A+",
                            colorOfValueField: Colors.green,
                            color: Color(0xff492E51),
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
                              task: "Attendance",
                              color: Color(0xff492E51),
                              iconColor: Colors.white,
                              textColor: CustomColors.White,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.studentAttendance);
                              },
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: TaskWidget(
                            icon: "assets/person.svg",
                            task: "Academic",
                            color: Color(0xff492E51),
                            iconColor: Colors.white,
                            textColor: CustomColors.White,
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
                              task: "Leave Application",
                              color: Color(0xff492E51),
                              iconColor: Colors.white,
                              textColor: CustomColors.White,
                              onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateOrders()));
                                Navigator.pushNamed(context, Routes.studentLeave);
                              },
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: TaskWidget(
                            icon: "assets/person.svg",
                            task: "Course Fee",
                            color: Color(0xff492E51),
                            iconColor: Colors.white,
                            textColor: CustomColors.White,
                            onTap: (){
                              Navigator.pushNamed(context, Routes.createNotice);
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
                          "Today’s Class",
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
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.scheduleOfToday);
                  },
                  child: Container(
                    height: 420,
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff492E51),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 4,
                        itemBuilder: (context,index){
                        var length = 3;
                      return Column(
                        children: [
                          ClassDetailsBox(
                            day: 'sun',
                            date: '01/Jan',
                            class_details: 'English Class with CT Exam (Class Teacher :Sourob Hassan)',
                            starting_time: '11:30 am',
                            ending_time: '12:30 pm',
                          ),
                          index != length ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              thickness: 2,
                              color: Colors.white12,
                            ),
                          ) : SizedBox.shrink()
                        ],
                      );
                    }),
                  ),
                ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
