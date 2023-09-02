
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';


class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.onTap,
        this.buttonColor,
        this.borderRadius,
        this.myTextStyle = CustomTextStyle.buttonTextColor, this.height = 56,this.neededBorder,this.width,
        required this.buttonText,this.padding});
  VoidCallback onTap;
  Color? buttonColor;
  double? borderRadius, height, width;
  String? buttonText;
  TextStyle? myTextStyle;
  bool? neededBorder;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            border: neededBorder == true ? Border.all(width: 1,color: CustomColors.PrimaryColor) : Border(top: BorderSide.none,bottom: BorderSide.none,left: BorderSide.none,right: BorderSide.none),
            color: buttonColor ?? Color(0xff151D29)),
        child: Center(
          child: Text(
            buttonText!,
            style: myTextStyle,
          ),
        ),
      ),
    );
  }
}
