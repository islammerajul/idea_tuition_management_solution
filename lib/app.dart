
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/screens/attendence.dart';
import 'package:idea_tuition_managment_app/screens/splash_screen.dart';
import 'package:idea_tuition_managment_app/services/navigation_service.dart';
import 'package:idea_tuition_managment_app/stores/auth/auth_store.dart';
import 'package:idea_tuition_managment_app/stores/batch/batch_store.dart';
import 'package:idea_tuition_managment_app/stores/language/language_store.dart';
import 'package:idea_tuition_managment_app/stores/package/package_store.dart';
import 'package:idea_tuition_managment_app/stores/payment/payment_store.dart';
import 'package:idea_tuition_managment_app/stores/student/student_store.dart';
import 'package:idea_tuition_managment_app/stores/teacher_store/teacher_store.dart';
import 'package:idea_tuition_managment_app/stores/theme/theme_store.dart';
import 'package:idea_tuition_managment_app/utils/locale/app_localization.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
import 'package:idea_tuition_managment_app/utils/scroll_glow/scroll_glow.dart';
import 'package:provider/provider.dart';


import 'constants/app_theme.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'data/repository/repository.dart';
import 'di/components/service_locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final AuthStore _AuthStore = AuthStore(getIt<Repository>());
  final BatchStore _BatchStore = BatchStore(getIt<Repository>());
  final PackageStore _PackageStore = PackageStore(getIt<Repository>());
  final StudentStore _studentStore = StudentStore(getIt<Repository>());
  final PaymentStore _paymentStore = PaymentStore(getIt<Repository>());
  final TeacherStore _teacherStore = TeacherStore(getIt<Repository>());
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<AuthStore>(create: (_) => _AuthStore),
        Provider<BatchStore>(create: (_) => _BatchStore),
        Provider<PackageStore>(create: (_) => _PackageStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<StudentStore>(create: (_) => _studentStore),
        Provider<PaymentStore>(create: (_) => _paymentStore),
        Provider<TeacherStore>(create: (_) => _teacherStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child!,
              );
            },
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeData : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            //supportedLocales: _languageStore.supportedLanguages.map((language) => Locale(language.locale!, language.code)).toList(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
            home: const SplashScreen(),
            //home: AttendenceScreen(),
          );
        },
      ),
    );
  }
}

