import 'package:flutter/cupertino.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class PackageBox extends StatefulWidget {
  PackageBox({super.key,this.title,this.fees,this.numOfBatch,this.numOfStudent});
  String? title, numOfStudent, numOfBatch, fees;

  @override
  State<PackageBox> createState() => _PackageBoxState();
}

class _PackageBoxState extends State<PackageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 278,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xff492E51)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.title}",
            style: CustomTextStyle.buttonTextColor,
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            "${widget.numOfStudent} Students",
            style: CustomTextStyle.nametitle.copyWith(color: CustomColors.White),
          ),
          SizedBox(
            height: 11,
          ),
          Text(
            "${widget.numOfBatch} Batch",
            style: CustomTextStyle.nametitle.copyWith(color: CustomColors.White),
          ),
          SizedBox(
            height: 61,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "\$${widget.fees}",
              style: CustomTextStyle.buttonTextColor.copyWith(fontSize: 54,),
            ),
          ),
        ],
      ),
    );
  }
}
