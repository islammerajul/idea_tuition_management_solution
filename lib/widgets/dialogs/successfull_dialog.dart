import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';

class SuccessfullDialog {
  successDialog(
    BuildContext context, {
    String? headerTitle,
    String? desTitle,
    String? message,
    Color? headerTitleColor,
    required VoidCallback callbackForCancled,
  }) {
    return showDialog(
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
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Color(0xff3A2544)
                    ),
                    padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(headerTitle!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: CustomColors.typeofGreen),
                      textAlign: TextAlign.center,
                    ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AutoSizeText(
                            message ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 19,
                                color: CustomColors.PrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        InkWell(
                          onTap: callbackForCancled,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)
                              ),
                              color: Colors.red
                            ),
                            child: Center(
                              child: Text("Cancled",style: CustomTextStyle.field
                                  .copyWith(color: CustomColors.White),),
                            ),
                          ),
                        ),
                        // CustomButton(
                        //   height: 39,
                        //   onTap: callbackForCancled,
                        //   buttonText: 'Cancled',
                        //   buttonColor: Colors.red,
                        //   //myTextStyle: TextStyle(fontSize: 18,color: Colors.white),
                        //   myTextStyle: CustomTextStyle.field
                        //       .copyWith(color: CustomColors.White),
                        //   padding:
                        //   EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        // )
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
  }
}

/*
Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,

            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AlertDialog(
                  backgroundColor: Color(0xff3A2544),
                  insetPadding: const EdgeInsets.symmetric(
                      horizontal:
                          30), // This padding increases dialog's width
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  // title: Image.asset(
                  //   "assets/success.png",
                  //   height: 98,
                  //   width: 98,
                  // ),
                  // title: Center(
                  //     child: Text(
                  //   headerTitle!,
                  //   style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w500,
                  //       color: headerTitleColor ??
                  //           Color(
                  //               0xff02B634) // It means that headerTitleColor is null then execute Color(0xff02B634)
                  //       //color:Color(0xff02B634) ?? headerTitleColor  // It is wrong
                  //       ),
                  // )),
                  content: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      //padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: desTitle == null
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              desTitle!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: CustomColors.typeofGreen),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            message ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 19,
                                color: CustomColors.PrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  actions: [
                    CustomButton(
                      height: 39,
                      onTap: callbackForCancled,
                      buttonText: 'Cancled',
                      buttonColor: Colors.red,
                      //myTextStyle: TextStyle(fontSize: 18,color: Colors.white),
                      myTextStyle: CustomTextStyle.field
                          .copyWith(color: CustomColors.White),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    )
                  ],
                ),
                // Positioned(
                //     top: 250,
                //     right: 00,
                //     left: 0,
                //     child: SvgPicture.asset(
                //       "assets/success.svg",
                //
                //     )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.28,
                    right: 50,
                    //left: 0,
                    child: Image.asset(
                      "assets/success.png",
                      height: 98,
                      width: 98,
                    ))
              ],
            ),
          );
 */