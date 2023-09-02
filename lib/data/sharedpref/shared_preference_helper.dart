import 'dart:async';
import 'dart:convert';


import 'package:appwrite/models.dart' as aw;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------

  Future<String?> get getUsersession async {
    return _sharedPreference.getString(Preferences.user_session);
  }
  Future<bool> saveSession(aw.Session session) async {
    return _sharedPreference.setString(Preferences.user_session, jsonEncode(session));
  }

  Future<String?>  getDocumenetList(String tag) async {
    return _sharedPreference.getString(tag);
  }

  Future<bool> setDocumentList(Map<String,dynamic> documentList,String tag) async {
    return _sharedPreference.setString(tag, jsonEncode(documentList));
  }

  Future<String?> get getOrderList async {
    return _sharedPreference.getString(Preferences.order_list);
  }
  Future<bool> saveOrderList(Map<String,dynamic> documentList) async {
    return _sharedPreference.setString(Preferences.order_list, jsonEncode(documentList));
  }


  Future<bool> saveAppSettingsList(Map<String,dynamic> documentList) async {
    return _sharedPreference.setString(Preferences.app_setting, jsonEncode(documentList));
  }

  Future<String?> get getAppSettings async {
    return _sharedPreference.getString(Preferences.app_setting);
  }

  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }
  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refresh_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }
  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.setString(Preferences.refresh_token, refreshToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }
  Future<bool> get getIsDoctor async {
    return _sharedPreference.getBool(Preferences.is_doctor) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }
  Future<bool> saveIsDoctor(bool value) async {
    return _sharedPreference.setBool(Preferences.is_doctor, value);
  }


  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

  //Current user
  Future<void> saveCurrentUser(dynamic userResponse) {
    return _sharedPreference.setString(Preferences.current_user, jsonEncode(userResponse));
  }

  String? get currentUserResponse{
    return _sharedPreference.getString(Preferences.current_user);
  }



  //save local auth status
  Future<bool> get isEnableLocalAuth async {
    return _sharedPreference.getBool(Preferences.local_auth_status) ?? false;
  }

  Future<bool> saveLocalAuthStatus(bool value) async {
    return _sharedPreference.setBool(Preferences.local_auth_status, value);
  }

  Future<bool> clearData(String key) async{
    return _sharedPreference.remove(key);
  }

}