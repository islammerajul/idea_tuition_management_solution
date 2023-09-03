
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idea_tuition_managment_app/screens/splash_screen.dart';
import 'package:idea_tuition_managment_app/services/navigation_service.dart';
import 'package:idea_tuition_managment_app/stores/language/language_store.dart';
import 'package:idea_tuition_managment_app/stores/theme/theme_store.dart';
import 'package:idea_tuition_managment_app/utils/locale/app_localization.dart';
import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
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

  // final AuthStore _authStore = AuthStore(getIt<Repository>());
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  // final AdminStore _adminStore = AdminStore(getIt<Repository>());
  // final SplashStore _splashStore = SplashStore(getIt<Repository>());
  // final OrderStore _orderStore = OrderStore(getIt<Repository>());
  // final CustomerStore _customerStore = CustomerStore(getIt<Repository>());
  // final VendorStore _vendorStore = VendorStore(getIt<Repository>());
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        // Provider<AuthStore>(create: (_) => _authStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        // Provider<AdminStore>(create: (_) => _adminStore),
        // Provider<SplashStore>(create: (_) => _splashStore),
        // Provider<OrderStore>(create: (_) => _orderStore),
        // Provider<CustomerStore>(create: (_) => _customerStore),
        // Provider<VendorStore>(create: (_) => _vendorStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
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
          );
        },
      ),
    );
  }
}

