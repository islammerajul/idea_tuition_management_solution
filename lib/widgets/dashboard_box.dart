import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';


class DashboardBox extends StatefulWidget {
  DashboardBox({super.key,this.title,this.value,this.height = 135,this.subvalue,this.buttonNeeded,this.showCurrencyType,this.onTap,this.textStyle,this.color,this.staticValue,this.colorOfValueField});
  String? title, value, subvalue, staticValue;
  double? height;
  bool? buttonNeeded, showCurrencyType;
  dynamic onTap;
  TextStyle? textStyle;
  Color? color, colorOfValueField;

  @override
  State<DashboardBox> createState() => _DashboardBoxState();
}

class _DashboardBoxState extends State<DashboardBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16,left: 16,right: 12,bottom: 10),
      //height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.color ?? CustomColors.White
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
              child: AutoSizeText("${widget.title}",style: widget.textStyle ?? CustomTextStyle.subtitle2.copyWith(color: CustomColors.White),)),
          SizedBox(height: 10,),
        AutoSizeText("${widget.value}",style: CustomTextStyle.DashboardValue.copyWith(color: widget.colorOfValueField ?? CustomColors.White),),
        Align(
          alignment: Alignment.bottomRight,
            child: widget.showCurrencyType == true ? Text("${widget.staticValue}",style: CustomTextStyle.Taka,) : SizedBox.shrink())
        ],
      ),
      // child: Stack(
      //   children: [
      //     AutoSizeText("${widget.title}",style: widget.textStyle ?? CustomTextStyle.subtitle2,),
      //     SizedBox(height: 10,),
      //     Positioned(
      //         bottom: 1,
      //
      //         child: AutoSizeText("${widget.value}",style: CustomTextStyle.DashboardValue,)),
      //     Positioned(
      //         bottom: 1,
      //         right: 1,
      //         child: widget.showCurrencyType == true ? Text("TAKA",style: CustomTextStyle.Taka,) : SizedBox.shrink())
      //   ],
      // ),
    );
  }
}
