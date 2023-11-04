import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_form.dart';
import 'package:idea_tuition_managment_app/screens/batch_screen.dart';
import 'package:idea_tuition_managment_app/screens/tuition_fees_screen.dart';
import 'package:idea_tuition_managment_app/screens/student_screen.dart';
import 'package:idea_tuition_managment_app/screens/dashboard.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    Dashboard(),
    StudentScreen(),
    TeacherForm(),
    //BatchScreen(),
    TuitionFeesScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: Center(
            child: _pages.elementAt(_selectedIndex), //New
          ),
          bottomNavigationBar: SizedBox(
            child: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: CustomColors.AppBarColor,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                //primaryColor: Colors.red,
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex, //New
                onTap: _onItemTapped,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                selectedIconTheme: const IconThemeData(size: 40),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/dashboard.png")),label: 'Dashboard'),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/student.png")),label: 'Student'),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/batch.png",),color: Colors.white,),label: 'Batch',),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/money.png")),label: 'Fees'),

                ],
              ),
            ),
          ),
        ));
  }
}
