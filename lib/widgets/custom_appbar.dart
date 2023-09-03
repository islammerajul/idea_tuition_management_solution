
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({Key? key,this.appbarTitle,this.needLeading}) : super(key: key);
  String? appbarTitle;
  bool? needLeading;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.AppBarColor,
      toolbarHeight: toolbarHeight,
      title: Text(widget.appbarTitle!,style: CustomTextStyle.AppbarTextColor,),
      centerTitle: true,
      leading: widget.needLeading == true ? IconButton(onPressed: (){
        Navigator.of(context).pop();
      }, icon: Icon(Icons.arrow_back,color: CustomColors.White,)) : SizedBox(),
      actions: [
        Container(
          height: 32,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/notification.svg",
                  height: 27.14,
                  width: 32.1,
                ),
              ),

              SizedBox(width: 16,)

            ],
          ),
        )
      ],
    );
  }
}
