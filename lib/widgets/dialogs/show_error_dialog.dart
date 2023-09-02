
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/widgets/custom_button.dart';


class CustomSEdialog{

  seCustomDialog(BuildContext context, {
    String? headerTitle,
    String? desTitle,
    String? message,
    Color? headerTitleColor,
    required VoidCallback  callback,
  }){
    return showDialog(context: context, builder: (BuildContext context){
      return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(
                horizontal: 30), // This padding increases dialog's width
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: Center(
                child: Text(
                  headerTitle!,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: headerTitleColor ?? Color(0xff02B634) // It means that headerTitleColor is null then execute Color(0xff02B634)
                    //color:Color(0xff02B634) ?? headerTitleColor  // It is wrong
                  ),
                )),
            content: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                //padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: desTitle == null ? MainAxisAlignment.center : MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        desTitle!,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                            color: CustomColors.PrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // AutoSizeText(
                    //   message!,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 18,
                    //       color: CustomColors.PrimaryColor),
                    //   textAlign: TextAlign.center,
                    // ),
                    Text(
                      message ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: CustomColors.PrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      height: 39,
                      onTap: callback,
                      buttonText: 'Cancled',
                      buttonColor: Colors.red,
                      //myTextStyle: TextStyle(fontSize: 18,color: Colors.white),
                      myTextStyle: CustomTextStyle.field
                          .copyWith(color: CustomColors.White),
                      padding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

}