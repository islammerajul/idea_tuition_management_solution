
import 'package:appwrite/models.dart' as aw;
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/client/client_appwrite.dart';
import 'package:idea_tuition_managment_app/data/exceptions/network_exceptions.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/constants/preferences.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/shared_preference_helper.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/utils/sentry_utils.dart';



class AppwriteApi {
  // dio instance

  ClientAppWrite _clientAppWrite = ClientAppWrite();
  final SharedPreferenceHelper sharedPreferenceHelper;
  //injecting dio instance
  AppwriteApi(this._clientAppWrite,this.sharedPreferenceHelper);

  //sentry
  final SentryUtils _sentryUtils = SentryUtils();



  //email session
  Future<ResponseObject> emailSession(String email,String password) async {
    try {

      final res = await _clientAppWrite.emailSession(email,password);
      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);

      } else {
        _storeUserSession(res);
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);

      }
    } catch (e) {

      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }

  // Future<ResponseObject> getAppSettings() async {
  //   try {
  //     //final res = await _clientAppWrite.listDocuments();
  //     if (res is NetworkException) {
  //       return ResponseObject(id: ResponseCode.FAILED, object: res.message);
  //
  //     } else {
  //       _storeUserSession(res);
  //       return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
  //     }
  //   } catch (e) {
  //
  //     return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
  //   }
  // }

  Future<ResponseObject> getProductList() async {
    try {
      final res = await _clientAppWrite.listDocuments(AppDatabase.core_db,AppDatabase.productlist);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        _storeProducts(res);
        print("SUCCESSFUL");
        print(res);
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
       print("productlist-exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }

  Future<ResponseObject> getOrderList() async {
    try {
      final res = await _clientAppWrite.listDocuments(AppDatabase.core_db,AppDatabase.orderlist);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
      print("order_list_exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }

  Future<ResponseObject> getAppSettingsList() async {
    try {
      final res = await _clientAppWrite.listDocuments(AppDatabase.core_db,AppDatabase.appSettings);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        _storeAppSettings(res);
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
      print("app settings list-exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }


  Future<ResponseObject> getDocumentList(tag) async {
    try {
      final res = await _clientAppWrite.listDocuments(AppDatabase.core_db,tag);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        //_storeAppSettings(res);
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
      print("app settings list-exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }
  Future<ResponseObject> getDocument(tag,doc) async {
    try {
      final res = await _clientAppWrite.getDocument(AppDatabase.core_db,doc);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        _storeAppSettings(res);
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
      print("app settings list-exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }

  Future<ResponseObject> addDocument(tag,data) async {
    try {
      final res = await _clientAppWrite.addDocument(AppDatabase.core_db,tag,data);

      if (res is NetworkException) {
        return ResponseObject(id: ResponseCode.FAILED, object: res.message);
      } else {
        return ResponseObject(id: ResponseCode.SUCCESSFUL, object: res);
      }
    } catch (e) {
      print("app document-exception::$e");
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again.");
    }
  }

  void _storeUserSession(aw.Session session) {
    sharedPreferenceHelper.saveSession(session);
    sharedPreferenceHelper.saveIsLoggedIn(true);
  }
  void _storeProducts(aw.DocumentList documentList) {
    sharedPreferenceHelper.setDocumentList( documentList.toMap(),Preferences.product_list);
  }
  void _storeAppSettings(aw.DocumentList documentList) {
    sharedPreferenceHelper.setDocumentList( documentList.toMap(),Preferences.app_setting);
  }




}