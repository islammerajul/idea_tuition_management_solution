import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class ShortDetailsOfStudent extends StatefulWidget {
  ShortDetailsOfStudent({super.key,this.img,this.name,this.customer_type,this.address,this.phone});
  String? img;
  String? name;
  String? customer_type;
  String? address;
  String? phone;

  @override
  State<ShortDetailsOfStudent> createState() => _ShortDetailsOfStudentState();
}

class _ShortDetailsOfStudentState extends State<ShortDetailsOfStudent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(top: 8, left: 6, right: 6),
          height: 250,
          width: 188,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: CustomColors.White),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    "assets/happy.svg",
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                  )),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 81,
                    width: 76,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                          image:
                          AssetImage("assets/imgs/person.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: -2,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: CustomColors.White,
                        child: Container(
                          height: 11,
                          width: 11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: CustomColors.typeofGreen,
                            //border: Border.all(color: CustomColors.White, width: 2)
                          ),
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: AutoSizeText(
                  "${widget.name}",
                  style: CustomTextStyle.nametitle,
                ),
              ),
              Text(
                //"${widget.customer_type}",
                "Regular Customer",
                style: CustomTextStyle.Text2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "${widget.address}",
                  style: CustomTextStyle.Text2,
                ),
              ),
              Text(
                "${widget.phone}",
                style: CustomTextStyle.Text2,
              ),
              SizedBox(
                height: 22,
              ),

            ],
          ),
        ),
        Positioned(
            bottom: -10,
            left: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 38,
              //width: double.infinity,
              width: 175,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.AppBarColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, '/customer-dashboard');
                        //Navigator.pushNamed(context, Routes.customerDashboard);
                      },
                      child: SvgPicture.asset("assets/bar_options/Chart_fill.svg")),
                  InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, Routes.sendNotification);
                      },
                      child: SvgPicture.asset("assets/bar_options/Bell.svg")),
                  InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, Routes.customerInfo);
                      },
                      child: SvgPicture.asset("assets/bar_options/Desk_alt_fill.svg")),
                  InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, Routes.customerChat);
                      },
                      child: SvgPicture.asset("assets/bar_options/Chat_fill.svg")),
                  InkWell(
                      onTap: (){
                        //Navigator.pushNamed(context, Routes.customerMap);
                      },
                      child: SvgPicture.asset("assets/bar_options/Send_fill.svg")),
                ],
              ),
            ))
      ],
    );
  }
}
