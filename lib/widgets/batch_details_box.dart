import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class BatchDetailsBox extends StatefulWidget {
  const BatchDetailsBox({super.key});

  @override
  State<BatchDetailsBox> createState() => _BatchDetailsBoxState();
}

class _BatchDetailsBoxState extends State<BatchDetailsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(width: 2),
        color: Color(0xff492E51),
        //color: Colors.transparent
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "English  (Class 10)",
            style: CustomTextStyle.field.copyWith(color: CustomColors.White),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AutoSizeText(
              "Moring(9AM)",
              style: CustomTextStyle.field.copyWith(color: CustomColors.White,fontWeight: FontWeight.w300),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: SvgPicture.asset("assets/info_icon/Calendar.svg")),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 5,
                child: AutoSizeText(
                  "SAN,MON,WED",
                  style: CustomTextStyle.field.copyWith(color: CustomColors.White,fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset("assets/info_icon/Money.svg"),
              SizedBox(
                width: 5,
              ),
              Text(
                "1000",
                style: CustomTextStyle.field.copyWith(color: CustomColors.White,fontWeight: FontWeight.w300),
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
                  child: SvgPicture.asset("assets/info_icon/User_cicrle.svg")),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 5,
                child: AutoSizeText(
                  "Naimul Hassan Noor",
                  style: CustomTextStyle.field.copyWith(color: CustomColors.White,fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
