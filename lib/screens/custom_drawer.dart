

import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/style/custom_text_style.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget buildHeader(BuildContext context) => Container(
    //height: 113,
    //height: 130,
    color: CustomColors.AppBarColor,
    padding: EdgeInsets.only(
      top: 12,
        //top: MediaQuery.of(context).padding.top,
        left: 12
    ),
    child: Column(
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SvgPicture.asset("assets/dm_logo.svg",
            //   height: 45,width: 45,fit: BoxFit.cover,
            // ),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: CustomColors.White,)),
            Image.asset("assets/logo/idea_logo.png",height: 70,width: 200,fit: BoxFit.cover,),
            SizedBox(width: 16,),

            //Text("Dholaimama \nAdmin",style: CustomTextStyle.drawerAppText,),
          ],
        ),
        SizedBox(height: 20,),
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/imgs/person.jpg",),
          ),
          title: Text("Naimul Hassan Noor",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: CustomColors.White),),
          subtitle: Text("English Teacher",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: CustomColors.White),),
          trailing: Image.asset("assets/drawer_icon/logout.png",height: 40,width: 40,),
        ),
      ],
    ),
  );

  @override
  Widget buildMenuItem(BuildContext context) => Wrap(
    runSpacing: 15,
    spacing: 34,
    children: [
      ListTile(
        leading: Image.asset("assets/drawer_icon/user-profile.png",height: 37,width: 38,),
        title: Text(
          "Profile",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.profile);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/news.png",height: 31,width: 30,),
        //SvgPicture.asset("assets/icons/drawer_icon/help.svg"),
        title: Text(
          "News & Blogs",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.newsBlogs);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/Settings.png",height: 40,width: 40,),

        //leading: SvgPicture.asset("assets/icons/drawer_icon/setting.svg"),
        title: Text(
          "Settings",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.settings);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/package.png",height: 40,width: 40,),

        //leading: SvgPicture.asset("assets/icons/drawer_icon/setting.svg"),
        title: Text(
          "Package",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.packageMenu);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/support.png",height: 36,width: 36,),
        //SvgPicture.asset("assets/icons/drawer_icon/support.svg"),
        title: Text(
          "Support",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.support);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/info.png",height: 31,width: 30,),
        //SvgPicture.asset("assets/icons/drawer_icon/info.svg"),
        title: Text(
          "Terms & Conditions",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.termsConditions);
        },
      ),
      ListTile(
        leading: Image.asset("assets/drawer_icon/privacy.png",height: 34,width: 34,),
        //SvgPicture.asset("assets/icons/drawer_icon/privacy.svg"),
        title: Text(
          "Privacy Policy",
          style: CustomTextStyle.drawerText.copyWith(color: CustomColors.White),
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.privacyPolicy);
        },
      ),

    ],
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        backgroundColor: CustomColors.AppBarColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              SizedBox(height: 60,),
              buildMenuItem(context),
            ],
          ),
        ),

      ),
    );
  }
}
