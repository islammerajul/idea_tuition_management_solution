import 'package:flutter/cupertino.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class NoticeContent extends StatefulWidget {
  NoticeContent({super.key,this.title,this.content,this.gap});
  String? title, content;
  double? gap;

  @override
  State<NoticeContent> createState() => _NoticeContentState();
}

class _NoticeContentState extends State<NoticeContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "${widget.title}",
          style: CustomTextStyle.field.copyWith(color: CustomColors.White),
        ),
        SizedBox(
          height: widget.gap ?? 11,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff492E51)
          ),
          child: Text("${widget.content}",style: CustomTextStyle.subtitle3.copyWith(color: CustomColors.White,fontSize: 15),),
        )
      ],
    );
  }
}
