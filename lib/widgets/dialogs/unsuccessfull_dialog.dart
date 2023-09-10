import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';

class UnsuccessfullDialog {
  unSuccessfullDialog(
    BuildContext context, {
    String? headerTitle,
    String? desTitle,
    String? message,
    Color? headerTitleColor,
    required VoidCallback callbackForOK,
    required VoidCallback callbackForCancled,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              //backgroundColor: Colors.white,
              insetPadding: EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          headerTitle!,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Colors.red),
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
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: callbackForOK,
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(4)),
                                        color: Color(0xff492E51)),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: CustomTextStyle.field.copyWith(
                                            color: CustomColors.White),
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: callbackForCancled,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4),
                                          ),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      "Cancled",
                                      style: CustomTextStyle.field
                                          .copyWith(color: CustomColors.White),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: -50,
                      right: 20,
                      child: Image.asset(
                        "assets/unsuccessfull.png",
                        height: 98,
                        width: 98,
                      ))
                ],
              ));
        });
  }
}
