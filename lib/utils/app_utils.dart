import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:idea_tuition_managment_app/utils/sentry_utils.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class AppUtils{
  SentryUtils sentryUtils=new SentryUtils();
  static String timeFormat(String time){
    var now=DateTime.parse("2021-12-23 ${time}");

    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('h:mm:a').format(now);
    String formattedDate = formatter.format(now);
    return formattedTime;
  }

  static showDefaultToastMessage(String msg,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
  static Widget appNetworkImage(String url,{required double height,required double width,imageLink=null}){
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => imageLink??
          Container(
            width: 50,
            height: 50,
            child: Center(child: Icon(Icons.error,color: Colors.white,)),)
          ,
    );

  }

  void emailSender({
    required String emailaddress,
    required String body,
    required String subject,
  }) async{
    final Email email = Email(
      body: 'Write you Email',
      subject: 'App Support',
      recipients: [emailaddress],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (e,stackTrace) {
      sentryUtils.sentry_exception(e.toString(), stackTrace);
      print(e.toString());
    }


  }

  void launchWhatsappWithMessage({required String mobilNumber,required String text,required BuildContext context}) async {

    var androidUrl = "whatsapp://send?phone=$mobilNumber&text=$text";
    var iosUrl = "https://wa.me/$mobilNumber?text=${Uri.parse(text)}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }


  void launchPhoneNumber({required String phoneNumber})async{
    try{
      print("phone number");
      var url = "tel:$phoneNumber";
      await launchUrl(Uri.parse(url));
    }catch(e){
      print(e.toString());
    }

  }
}
