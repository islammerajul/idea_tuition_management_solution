
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class StudentInfoBox extends StatefulWidget {
  StudentInfoBox({super.key,this.title,this.icon,this.value});

  String? title, value,icon;

  @override
  State<StudentInfoBox> createState() => _StudentInfoBoxState();
}

class _StudentInfoBoxState extends State<StudentInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              //Icon(Icons.calendar_month,color: CustomColors.White,),
              SvgPicture.asset("${widget.icon}"),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.title}",
                style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              "${widget.value}",
              style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White),
            ),
          ),
        ),
      ],
    );
  }
}
