import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, this.height,this.icon,this.task,this.onTap,this.color,this.textColor,this.iconColor});
  double? height;
  String? icon, task;
  dynamic? onTap;
  Color? color,textColor, iconColor;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8,left: 10,right: 10,bottom: 8),
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.color ?? CustomColors.White
        ),
        child: Row(
          children: [
            SvgPicture.asset("${widget.icon}" ,height: 40,width: 40,fit: BoxFit.cover,color: widget.iconColor ,) ,
            SizedBox(width: 5,),
            SizedBox(
                width: 70,
                child: AutoSizeText("${widget.task}",style: CustomTextStyle.taskText.copyWith(color: widget.textColor ?? Color(0xff492E51)))),
          ],
        ),
      ),
    );
  }
}
