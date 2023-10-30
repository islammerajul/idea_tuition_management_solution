
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/screens/attendence.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/student/student_login.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/student/student_signup.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_form.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_login.dart';
import 'package:idea_tuition_managment_app/screens/auth_module/teacher/teacher_signup.dart';
import 'package:idea_tuition_managment_app/screens/create_batch.dart';
import 'package:idea_tuition_managment_app/screens/create_payment.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/news_blogs.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/packages/package.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/packages/packageMenu.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/privacy_policy.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/profile.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/settings.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/support.dart';
import 'package:idea_tuition_managment_app/screens/menu_journey/terms_conditions.dart';
import 'package:idea_tuition_managment_app/screens/notice_journey/create_notice.dart';
import 'package:idea_tuition_managment_app/screens/create_student.dart';
import 'package:idea_tuition_managment_app/screens/notice_journey/notice_list.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/edit_student_profile.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_attendence.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_dashboard.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_leave.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_navigation_bar.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_payment.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/student_profile.dart';
import 'package:idea_tuition_managment_app/screens/student_portal_screens/today_schedule.dart';
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
  static const String createBatch = '/create-batch';
  static const String createNotice = '/create-notice';
  static const String noticeList = '/notice-list';
  static const String profile = '/profile';
  static const String newsBlogs = '/news-blogs';
  static const String settings = '/settings';
  static const String support = '/support';
  static const String termsConditions = '/terms-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String packageMenu = '/package-menu';
  static const String studentPortalDashboard = '/student-portalDashboard';
  static const String scheduleOfToday = '/schedule-OfToday';
  static const String studentProfile = '/student-profile';
  static const String editStudentProfile = '/edit-studentProfile';
  static const String studentAttendance = '/student-attendance';
  static const String studentNavigationBar = '/student-navigationBar';
  static const String studentLeave = '/student-leave';
  static const String attendence = '/attendence';
  static const String package = '/package';
  static const String createPayment = '/create-payment';
  static const String studentPayment = '/student-payment';
  static const String teacherForm = '/teacher-Form';
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
    createBatch: (BuildContext context) => const CreateBatch(),
    createNotice: (BuildContext context) => const CreateNotice(),
    noticeList: (BuildContext context) => const NoticeList(),
    profile: (BuildContext context) => const Profile(),
    newsBlogs: (BuildContext context) => const NewsBlogs(),
    settings: (BuildContext context) => const Settings(),
    support: (BuildContext context) => const Support(),
    termsConditions: (BuildContext context) => const TermsConditions(),
    privacyPolicy: (BuildContext context) => const PrivacyPolicy(),
    packageMenu: (BuildContext context) => const PackageMenu(),
    studentPortalDashboard: (BuildContext context) => const StudentPortalDashboard(),
    scheduleOfToday: (BuildContext context) => const TodaySchedulScreen(),
    studentProfile: (BuildContext context) =>  StudentProfileScreen(),
    editStudentProfile: (BuildContext context) => const EditStudentProfile(),
    studentAttendance: (BuildContext context) => const StudentAttendanceScreen(),
    studentNavigationBar: (BuildContext context) => const StudentNavigationBar(),
    studentLeave: (BuildContext context) => const StudentLeave(),
    attendence: (BuildContext context) => const AttendenceScreen(),
    package: (BuildContext context) => const PackageScreen(),
    createPayment: (BuildContext context) => const CreatePayment(),
    studentPayment: (BuildContext context) => const StudentPaymentScreen(),
    teacherForm: (BuildContext context) => const TeacherForm(),

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
