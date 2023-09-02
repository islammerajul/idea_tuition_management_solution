
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/widgets/progress_indicator_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'locale/app_localization.dart';

enum WebViewType{
  bill,
  generic,
  url,
}

class AppWebView extends StatefulWidget {

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final WebViewController _controller=new WebViewController();
  bool loading = false;
  dynamic data;
  String appBarText="";
  var type=WebViewType.url;

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (value){
            print("url::$value");
          },
          onProgress: (int progress) {
            print("init::$progress");
           setState(() {
             if(progress == 100){
               loading = false;
             }else{
               loading = true;
             }
           });
          },),
      );

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: appBarText!=""?Text(appBarText,style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: CustomColors.PrimaryColor
        ),):Text(""),
        leading: InkWell(child: Icon(Icons.arrow_back_ios, color: CustomColors.PrimaryColor,), onTap: () {
          Navigator.pop(context);
        },),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          _webView(),
          loading == true? CustomProgressIndicatorWidget(): SizedBox.shrink()
        ],
      ),
    );
    return Scaffold(
        body: WebViewWidget(controller: _controller));

  }

  Widget _webView() {
    return Column(
                children: [
                  Container(
                    height: 5,
                    color: CustomColors.PrimaryColor,
                  ),
                  SizedBox(height: 5,),
                  Expanded(child: WebViewWidget(controller: _controller))
                ]);

        }
}



