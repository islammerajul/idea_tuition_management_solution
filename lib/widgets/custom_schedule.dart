import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class CustomSchedule extends StatefulWidget {
  CustomSchedule({super.key,this.time,this.slot,this.batch_name,this.batch_num});
  String? time, slot, batch_name, batch_num;

  @override
  State<CustomSchedule> createState() => _CustomScheduleState();
}

class _CustomScheduleState extends State<CustomSchedule> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.time}",
                    style: CustomTextStyle.subtitle3,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.slot}",
                    style: CustomTextStyle.subtitle3
                        .copyWith(color: CustomColors.unselectTextButtonColor),
                  ),
                ],
              ),
            ),

            Expanded(
                flex: 3,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CustomColors.TimeBox),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.batch_name != null ? Text(
                          "${widget.batch_name}",
                          style: CustomTextStyle.subtitle3,
                        ) : SizedBox.shrink(),
                        widget.batch_num != null ? CircleAvatar(
                          backgroundColor: Color(0xffD9D9D9),
                          child: Text(
                            "${widget.batch_num}",
                            style: CustomTextStyle.subtitle3,
                          ),
                        ) : SizedBox.shrink()
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
