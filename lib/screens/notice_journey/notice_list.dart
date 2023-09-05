import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/notice_content.dart';



class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  var demoText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. eb sites still in their infancy. ";
  var demoText1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. eb sites still in their infancy. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.\n\n";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: CustomColors.AppBarColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(toolbarHeight),
              child: CustomAppBar(
                appbarTitle: ' Notice List',
                needLeading: true,
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: CustomTextStyle.field.copyWith(color: CustomColors.White),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NoticeContent(
                    title: 'About Batch',
                    content: demoText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NoticeContent(
                    title: 'Education',
                    content: demoText1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NoticeContent(
                    title: 'Class Tast',
                    content: demoText,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}