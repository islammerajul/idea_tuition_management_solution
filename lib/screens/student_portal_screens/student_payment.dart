import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/all_constant_values.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_appbar.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';

class StudentPaymentScreen extends StatefulWidget {
  const StudentPaymentScreen({super.key});

  @override
  State<StudentPaymentScreen> createState() => _StudentPaymentScreenState();
}

class _StudentPaymentScreenState extends State<StudentPaymentScreen> {
  List<String> month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December',];
  String? select_month;
  List<String> batch = ['Bijoy', 'Shadhin', 'Shimahin'];
  String? select_batch;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: CustomColors.AppBarColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(toolbarHeight),
            child: CustomAppBar(
              appbarTitle: 'Show Payment',
              needLeading: true,
            )),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Month",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: CustomColors.White),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    DropdownButtonFormField(
                        iconEnabledColor: CustomColors.White,
                        value: select_month,
                        dropdownColor: CustomColors.AppBarColor,
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: CustomTextStyle.icontitle
                              .copyWith(color: CustomColors.White),
                          filled: true,
                          fillColor: const Color(0xff492E51),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                        ),
                        items: month
                            ?.map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    CustomColors.White))))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            select_month = item;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batch",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: CustomColors.White),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    DropdownButtonFormField(
                        iconEnabledColor: CustomColors.White,
                        value: select_batch,
                        dropdownColor: CustomColors.AppBarColor,
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: CustomTextStyle.icontitle
                              .copyWith(color: CustomColors.White),
                          filled: true,
                          fillColor: const Color(0xff492E51),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                        ),
                        items: batch
                            ?.map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    CustomColors.White))))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            select_batch = item;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                CustomButton(
                    onTap: () async {
                      //Navigator.pushNamed(context, Routes.navigationBarScreen);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                backgroundColor: Color(0xff3A2544),
                                insetPadding: EdgeInsets.all(10),
                                child: Stack(
                                  clipBehavior: Clip.none, alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        //color: Color(0xff3A2544)
                                      ),
                                      padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Payment Status",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 24,
                                                color: CustomColors.typeofGreen),
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Batch name : $select_batch",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Month : $select_month",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: AutoSizeText(
                                              "Payment Status : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 19,
                                                  color: CustomColors.PrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              //Navigator.pushNamed(context, Routes.createPayment);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)
                                                  ),
                                                  color: Colors.green
                                              ),
                                              child: Center(
                                                child: Text("OK",style: CustomTextStyle.field
                                                    .copyWith(color: CustomColors.White),),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: -50,
                                        right: 20,
                                        child: Image.asset(
                                          "assets/success.png",
                                          height: 98,
                                          width: 98,
                                        )
                                    )
                                  ],
                                )
                            );
                          });
                    },
                    buttonText: 'Show Payment'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
