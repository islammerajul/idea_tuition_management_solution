import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _AuthStore(Repository repository) : this._repository = repository {
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // store variables:-----------------------------------------------------------


  @observable
  bool loading = false;
  @observable
  bool success = false;
  @observable
  bool signup_status = false;


  @observable
  String noDataFound = '';
  @observable
  String successMessage = '';
  @observable
  String errorMessage = '';
  @observable
  BuildContext? mContext;


  // actions:-------------------------------------------------------------------


  @action
  Future createEmailSession(email, password) async {
    loading = true;
    final future = _repository.login(email, password);
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        success = true;

      } else {
        success = false;
        noDataFound = value.object as String;
      }
    });
  }

  @action
  Future createSignUp(userID,userName, email, password) async {
    loading = true;
    final future = _repository.signup(userID,userName, email, password);
    await future.then((value) async {

      print("Value is ::: $value");

      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        print("Response Code is ::: ${value.id}");
        success = true;
        signup_status = true;
      } else {
        success = false;
        signup_status = false;
        noDataFound = value.object as String;
        print("noDataFound is ::: $noDataFound");
      }
    });
  }

  @action
  Future updateSignUpInfo(String userId, List<String> labels) async {
    loading = true;
    final future = _repository.updateSignup(userId, labels);
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        success = true;

      } else {
        success = false;
        noDataFound = value.object as String;
      }
    });
  }


  // general:-------------------------------------------------------------------
  // general:-------------------------------------------------------------------
  void init() async {

  }

  // dispose:-------------------------------------------------------------------
  dispose() {
    print("doctor-store-dispose-call");
    for (final d in _disposers) {
      d();
    }
  }
}
