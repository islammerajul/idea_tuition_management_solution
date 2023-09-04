import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/custom_drawer.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';
import 'package:idea_tuition_managment_app/widgets/dashboard_box.dart';
import 'package:idea_tuition_managment_app/widgets/short_details_of_student.dart';
import 'package:idea_tuition_managment_app/widgets/task_widget.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
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
                  "Student",
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
          floatingActionButton: FloatingActionButton(
              backgroundColor: CustomColors.AppBarColor,
              child: Icon(Icons.search,color: Colors.white,),
              onPressed: () {
                searchStudent(context);
                }
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DashboardBox(
                          height: 125,
                          title: "All Customer",
                          value: "22",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DashboardBox(
                          height: 125,
                          title: "Active \nCustomer",
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
                          height: 125,
                          title: "Inactive Customers",
                          value: "50",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: DashboardBox(
                          height: 125,
                          title: "Vendor Customer",
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
                            height: 53,
                            icon: "assets/person.svg",
                            task: "Create \nCustomer",
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TaskWidget(
                          height: 53,
                          icon: "assets/person.svg",
                          task: "Create Orders",
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
                            height: 53,
                            icon: "assets/person.svg",
                            task: "Create Task",
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
                          height: 53,
                          icon: "assets/person.svg",
                          task: "Create \nVendors",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Text(
                    "Customers",
                    style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 31.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 1/1.35
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true ,
                      itemCount: 3,
                      itemBuilder: (context, index) {

                        return InkWell(
                          onTap: (){

                          },
                          child: ShortDetailsOfStudent(
                            //img: cus_list.img,
                            name: 'Naimul Hassan Noor',
                            address: "1659,Dania,Dhaka-1236",
                            phone: "01733433672",
                            //customer_type: cus_list.customer_type,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void searchStudent(BuildContext context) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        //backgroundColor: Colors.transparent,
        //backgroundColor: CustomColors.AppBarColor,
        builder: (context) => Container(
          padding: const EdgeInsets.only(top: 26, left: 20, right: 20, bottom: 0),
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: CustomColors.AppBarColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search Students",
                  style: TextStyle(
                      color: CustomColors.White, fontSize: 21,fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Search Students",
                  style: TextStyle(
                      color: CustomColors.White, fontSize: 15,fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 42,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 42,
                          //width: 275,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffFFFFFF)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.search,
                                    size: 20,
                                  )),
                              Expanded(
                                flex: 7,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                    'Search a doctor or health issue',
                                    hintStyle: CustomTextStyle.field
                                        .copyWith(
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                            "assets/filter.svg",
                            height: 42,
                            width: 31,
                          ),
                  ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 26, right: 16, bottom: 20),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 15,
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
                              padding: EdgeInsets.only(left: 30),

                              //height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      5),
                                  color:
                                  CustomColors.White),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Naimul Hassan Noor",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Colors.black),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Batch : 21 (Inter-Morning)",style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400,color: Color(0xffb2b2b2)),),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: -22,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundImage: AssetImage("assets/imgs/person.jpg",),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ));
  }

}
