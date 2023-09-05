import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';

class SupportBox extends StatefulWidget {
  SupportBox({super.key,this.title,this.icon,this.onTap});
  String? icon, title;
  VoidCallback? onTap;

  @override
  State<SupportBox> createState() => _SupportBoxState();
}

class _SupportBoxState extends State<SupportBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 58,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xff492E51)
        ),
        child: Row(
          children: [
            SvgPicture.asset("${widget.icon}"),
            SizedBox(
              width: 30,
            ),
            Text("${widget.title}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CustomColors.White),
            ),
          ],
        ),
      ),
    );
  }
}
