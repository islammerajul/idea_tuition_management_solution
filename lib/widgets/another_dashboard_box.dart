import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class AnotherDashBoardBox extends StatefulWidget {
  AnotherDashBoardBox({super.key,this.title,this.value,this.height,peice});
  String? title, value;
  double? height;
  bool? peice;

  @override
  State<AnotherDashBoardBox> createState() => _AnotherDashBoardBoxState();
}

class _AnotherDashBoardBoxState extends State<AnotherDashBoardBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16,left: 16,right: 12,bottom: 10),
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColors.White
      ),
      child: Stack(
        children: [
          AutoSizeText("${widget.title}",style: CustomTextStyle.subtitle2,),
          SizedBox(height: 10,),
          Positioned(
              bottom: 1,
              child: Text("${widget.value}",style: CustomTextStyle.DashboardValue,)),
          Positioned(
              bottom: 1,
              right: 1,
              child: widget.peice == true ? Text("p",style: CustomTextStyle.peice,) : Text("TAKA",style: CustomTextStyle.Taka,)),

        ],
      ),
    );
  }
}
