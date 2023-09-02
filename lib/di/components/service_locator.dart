

import 'package:get_it/get_it.dart';
import 'package:idea_tuition_managment_app/data/api/api_appwrite.dart';
import 'package:idea_tuition_managment_app/data/client/client_appwrite.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/shared_preference_helper.dart';
import 'package:idea_tuition_managment_app/di/module/local_module.dart';
import 'package:idea_tuition_managment_app/services/navigation_service.dart';
import 'package:idea_tuition_managment_app/stores/language/language_store.dart';
import 'package:idea_tuition_managment_app/stores/theme/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt=GetIt.instance;

Future<void> setupLocator() async {

  getIt.registerSingleton(ClientAppWrite());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));

  getIt.registerSingleton(AppwriteApi( getIt<ClientAppWrite>(), getIt<SharedPreferenceHelper>()));
  getIt.registerLazySingleton(() => NavigationService());
  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
      getIt<AppwriteApi>(),
      getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------

  // getIt.registerSingleton(AuthStore(getIt<Repository>()));
  // getIt.registerSingleton(AdminStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  // getIt.registerSingleton(CustomerStore(getIt<Repository>()));
  // getIt.registerSingleton(VendorStore(getIt<Repository>()));

}
