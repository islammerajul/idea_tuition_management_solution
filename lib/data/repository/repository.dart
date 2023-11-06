import 'dart:async';
import 'dart:convert';

import 'package:idea_tuition_managment_app/data/api/api_appwrite.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/shared_preference_helper.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';




class Repository {

  final SharedPreferenceHelper _sharedPrefsHelper;
  final AppwriteApi _appwriteApi;

  // constructor
  Repository(
      this._appwriteApi,
      this._sharedPrefsHelper,);

  // Post: ---------------------------------------------------------------------
  // Future<PostList> getPosts() async {
  //   // check to see if posts are present in database, then fetch from database
  //   // else make a network call to get all posts, store them into database for
  //   // later use
  //   return await _postApi.getPosts().then((postsList) {
  //     postsList.posts?.forEach((post) {
  //       _postDataSource.insert(post);
  //     });
  //
  //     return postsList;
  //   }).catchError((error) => throw error);
  // }
  //
  // Future<List<Post>> findPostById(int id) {
  //   //creating filter
  //   List<Filter> filters = [];
  //
  //   //check to see if dataLogsType is not null
  //   Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
  //   filters.add(dataLogTypeFilter);
  //
  //   //making db call
  //   return _postDataSource
  //       .getAllSortedByFilter(filters: filters)
  //       .then((posts) => posts)
  //       .catchError((error) => throw error);
  // }
  //
  // Future<int> insert(Post post) => _postDataSource
  //     .insert(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);
  //
  // Future<int> update(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);
  //
  // Future<int> delete(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<ResponseObject> login(String userName, String password) async {
    return await _appwriteApi.emailSession(userName, password).then((res) {
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }

  // Signup:---------------------------------------------------------------------
  Future<ResponseObject> signup(String userName, String email, String password) async {
    return await _appwriteApi.signupSession(userName, email, password).then((res) {
      print("_appwriteApi.signupSession mehod in repository return res ::: $res");
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }

  Future<ResponseObject> updateSignup(String userId, List<String> labels) async {
    return await _appwriteApi.updateSignupInfo(userId, labels).then((res) {
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }
  // Splash:---------------------------------------------------------------------
  // Future<ResponseObject> getAppSettings() async {
  //   return await _appwriteApi.getAppSeetings().then((res) {
  //     return res;
  //   }).catchError((error) {
  //     return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
  //   });
  // }

  // Future<ResponseObject> getProductList() async {
  //   return await _appwriteApi.getProductList().then((res) {
  //     return res;
  //   }).catchError((error) {
  //     return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
  //   });
  // }

  // Future<ResponseObject> getAppSettingsList() async {
  //   return await _appwriteApi.getAppSettingsList().then((res) {
  //     return res;
  //   }).catchError((error) {
  //     return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
  //   });
  // }
  Future<ResponseObject> getDocumentList(tag) async {
    return await _appwriteApi.getDocumentList(tag).then((res) {
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }

  Future<ResponseObject> getDocument(tag,doc) async {
    return await _appwriteApi.getDocument(tag,doc).then((res) {
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }

  Future<ResponseObject> addDocument(tag,doc) async {
    print("repodata:::${doc.toString()}");
    return await _appwriteApi.addDocument(tag,doc).then((res) {
      return res;
    }).catchError((error) {
      return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
    });
  }




  // Future<ResponseObject> getOrderList() async {
  //   return await _appwriteApi.getOrderList().then((res) {
  //     return res;
  //   }).catchError((error) {
  //     return ResponseObject(id: ResponseCode.FAILED, object: "Try again");
  //   });
  // }

 /*
  Future<void> saveUserEmail(String value) => _sharedPrefsHelper.saveUserEmail(value);
*/

  Future<void> saveIsLoggedIn(bool value) => _sharedPrefsHelper.saveIsLoggedIn(value);
  Future<void> saveIsDoctors(bool value) => _sharedPrefsHelper.saveIsDoctor(value);

  //app settings & product list
  Future<String?> getDocumentLitFromSP(String tag) => _sharedPrefsHelper.getDocumenetList(tag);



  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
  Future<bool> get isDoctor => _sharedPrefsHelper.getIsDoctor;

  Future<void> saveUserData(dynamic loginData) async {

  }

  String? get currentUser => _sharedPrefsHelper.currentUserResponse;

  Future<void> logout() async {}

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) => _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;








}
