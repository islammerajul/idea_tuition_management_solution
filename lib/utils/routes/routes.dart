
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/student/student_login.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/student/student_signup.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_login.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_signup.dart';
import 'package:idea_tuition_managment_app/screens/create_student.dart';
import 'package:idea_tuition_managment_app/screens/student_screen.dart';
import 'package:idea_tuition_managment_app/screens/tuition_fees_screen.dart';
import 'package:idea_tuition_managment_app/screens/navigation_bar.dart';
import 'package:idea_tuition_managment_app/screens/splash_screen.dart';


class Routes {
  Routes._();
  //static variables
  static const String splash = '/splash';
  static const String studentLogin = '/student-login';
  static const String teacherLogin = '/teacher-login';

  static const String teacherSignup = '/teacher-signup';
  static const String studentSignup = '/student-signup';
  static const String dashboard = '/dashboard';
  static const String navigationBarScreen = '/navigation-barScreen';
  static const String createStudent = '/create-student';
  static const String student = '/student';
  // static const String coreNavigation = '/core-navigation';
  // static const String orderRequest = '/order-request';
  // static const String createCustomer = '/create-customer';
  // static const String customers = '/customers';
  // static const String customerDashboard = '/customer-dashboard';
  // static const String orderCreation = '/order-creation';
  // static const String showConfirmedOrders = '/showConfirmed-Orders';
  // static const String sendNotification = '/send-notification';
  // static const String customerInfo = '/customer-info';
  // static const String customerChat = '/customer-chat';
  // static const String customerMap = '/customer-map';
  // static const String createVendor = '/create-vendor';
  // static const String vendorOrderRequest = '/vendor-orderRequest';
  // static const String orderDetails = '/order-details';



  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    // coreNavigation: (BuildContext context) => const NavigationBarScreen(),
    studentLogin: (BuildContext context) => const StudentLoginScreen(),
    teacherLogin: (BuildContext context) => const TeacherLoginScreen(),
    teacherSignup: (BuildContext context) => const TeacherSignupScreen(),
    studentSignup: (BuildContext context) => const StudentSignupScreen(),
    dashboard: (BuildContext context) => const TuitionFeesScreen(),
    navigationBarScreen: (BuildContext context) => const NavigationBarScreen(),
    createStudent: (BuildContext context) => const CreateStudentScreen(),
    student: (BuildContext context) => const StudentScreen(),

    // signup: (BuildContext context) => const SignupScreen(),
    // orderRequest: (BuildContext context) => OrderRequestScreen(),
    // createCustomer: (BuildContext context) => CreateCustomer(),
    // customers: (BuildContext context) => Customers(),
    // customerDashboard: (BuildContext context) => CustomerDashboard(),
    // orderCreation: (BuildContext context) => OrderCreation(),
    // showConfirmedOrders: (BuildContext context) => ShowConfirmedOrders(),
    // sendNotification: (BuildContext context) => SendNotification(),
    // customerInfo: (BuildContext context) => CustomerInfo(),
    // customerChat: (BuildContext context) => CustomerChat(),
    // customerMap: (BuildContext context) => CustomerMap(),
    // createVendor: (BuildContext context) => CreateVendor(),
    // vendorOrderRequest: (BuildContext context) => VendorOrderRequest(),
    // orderDetails: (BuildContext context) => OrderDetailsScreen(),


  };
}
