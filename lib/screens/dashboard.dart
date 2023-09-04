import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_schedule.dart';
import 'package:idea_tuition_managment_app/widgets/dashboard_box.dart';
import 'package:idea_tuition_managment_app/widgets/task_widget.dart';

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
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
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
                            //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateOrders()));
                            //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderListScreen()));
                            //Navigator.pushNamed(context, '/create-order');
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
                              //Navigator.pushNamed(context, Routes.showConfirmedOrders);
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
        ));
  }
}
