import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class ClassDetailsBox extends StatefulWidget {
  ClassDetailsBox(
      {super.key,
      this.date,
      this.day,
      this.class_details,
      this.ending_time,
      this.starting_time,
      this.present_status,
      this.status_needed = false});

  String? day, date, class_details, starting_time, ending_time, present_status;
  bool? status_needed;
  @override
  State<ClassDetailsBox> createState() => _ClassDetailsBoxState();
}

class _ClassDetailsBoxState extends State<ClassDetailsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  SvgPicture.asset("assets/chatIcon.svg"),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.day}",
                        style: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.date}",
                        style: CustomTextStyle.icontitle
                            .copyWith(color: CustomColors.White),
                      ),
                    ],
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              width: 1,
              color: CustomColors.White,
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "${widget.class_details}",
                    style: CustomTextStyle.icontitle
                        .copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: CustomColors.White,
                          ),
                          AutoSizeText(
                            "${widget.starting_time} - ${widget.ending_time}",
                            style: CustomTextStyle.icontitle
                                .copyWith(color: CustomColors.White),
                          ),
                        ],
                      ),
                      widget.status_needed == true
                          ? Text(
                              "${widget.present_status}",
                              style: widget.present_status == "Present"
                                  ? CustomTextStyle.Text2.copyWith(
                                      color: CustomColors.typeofGreen)
                                  : widget.present_status == "Absent"
                                      ? CustomTextStyle.Text2.copyWith(
                                          color: CustomColors.Red)
                                      : CustomTextStyle.Text2.copyWith(
                                          color: CustomColors.typeofYellow),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
