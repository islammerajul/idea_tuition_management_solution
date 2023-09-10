import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class StudentIDBox extends StatefulWidget {
  StudentIDBox({super.key,this.name,this.departmentAndclass,this.needBottomField = false,this.needTopField = false, this.studentID, this.extrafieldValue, this.onTap});
  String? name, studentID, departmentAndclass,extrafieldValue;
  bool needBottomField, needTopField;
  dynamic onTap;

  @override
  State<StudentIDBox> createState() => _StudentIDBoxState();
}

class _StudentIDBoxState extends State<StudentIDBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xff533c5b),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.needTopField == true ? Text(
            "${widget.departmentAndclass}",
            style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White,),
          ) : SizedBox.shrink(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/imgs/person.jpg"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White,),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Student ID :${widget.studentID}",
                    style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White,),
                  ),

                ],
              ),

            ],
          ),
          widget.needBottomField == true ? InkWell(
            onTap: widget.onTap,
            child: Text(
              "${widget.extrafieldValue}",
              style: CustomTextStyle.icontitle.copyWith(color: CustomColors.White,),
            ),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
