import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/another_dashboard_box.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/dashboard_box.dart';

class TuitionFeesScreen extends StatefulWidget {
  const TuitionFeesScreen({super.key});

  @override
  State<TuitionFeesScreen> createState() => _TuitionFeesScreenState();
}

class _TuitionFeesScreenState extends State<TuitionFeesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<String>? day = ['Today', 'This week', 'This month'];
  String? select_day = 'Today';

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
                "Tuiton Fees",
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
            child: Container(
              //height: MediaQuery.of(context).size.height,
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
                              style: CustomTextStyle.field
                                  .copyWith(color: CustomColors.White),
                            )),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField(
                              iconEnabledColor: CustomColors.White,
//dropdownColor: Colors.blue,
                              decoration:
                                  InputDecoration.collapsed(hintText: ''),
                              hint: Text(
                                "Today",
                                style: CustomTextStyle.field
                                    .copyWith(color: CustomColors.White),
                              ),
                              items: day
                                  ?.map((item) => DropdownMenuItem(
                                      value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (item) {
                                setState(() {
                                  select_day = item;
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
                            title: "Total collected Fee ",
                            value: "200000",
                            showCurrencyType: true,
                            staticValue: 'TAKA',
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
                            title: "Total Due’s",
                            value: "16000",
                            showCurrencyType: true,
                            staticValue: 'TAKA',
                            textStyle: CustomTextStyle.subtitle2,
                            colorOfValueField: CustomColors.titleBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DashboardBox(
                            title: "Active Students",
                            value: "248",
                            textStyle: CustomTextStyle.subtitle2,
                            colorOfValueField: CustomColors.titleBlack,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: DashboardBox(
                              title: "Active Batches",
                              value: "14",
                              textStyle: CustomTextStyle.subtitle2,
                              colorOfValueField: CustomColors.titleBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Transactions",
                      style: CustomTextStyle.field
                          .copyWith(color: CustomColors.White),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 500,
                      child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              Container(
                                child: const TabBar(
                                    labelColor: CustomColors.White,
                                    labelStyle: CustomTextStyle.field,
                                    unselectedLabelColor: CustomColors.White,
                                    unselectedLabelStyle: CustomTextStyle.peice,
                                    indicatorColor: Colors.blue,
                                    tabs: [
                                      Tab(
                                        text: 'Paid',
                                      ),
                                      Tab(
                                        text: 'Unpaid',
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: SizedBox(
                                      //height: MediaQuery.of(context).size.height * 0.5,
                                      child: TabBarView(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 26, right: 16, bottom: 20),
                                  child: GridView.builder(
                                      //physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 15.0,
                                        childAspectRatio: 1 / 0.18,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 30),

                                              //height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: CustomColors.White),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Naimul Hassan Noor",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Batch : 21 (Inter-Morning)",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xffb2b2b2)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: -22,
                                              child: CircleAvatar(
                                                radius: 22,
                                                backgroundImage: AssetImage(
                                                  "assets/imgs/person.jpg",
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 26, right: 16, bottom: 20),
                                  child: GridView.builder(
                                      //physics: NeverScrollableScrollPhysics(),

                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: 8,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 15.0,
                                        childAspectRatio: 1 / 0.18,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25),
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 30),

                                                //height: 50,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: CustomColors.White),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Naimul Hassan Noor",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      "Batch : 21 (Inter-Morning)",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xffb2b2b2)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: 4,
                                              child: CircleAvatar(
                                                radius: 22,
                                                backgroundImage: AssetImage(
                                                  "assets/imgs/person.jpg",
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ])))
                            ],
                          )),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
