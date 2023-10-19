import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/batch_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';

import '../../constants/app_data.dart';
part 'batch_store.g.dart';

class BatchStore = _BatchStore with _$BatchStore;

abstract class _BatchStore with Store{
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _BatchStore(Repository repository) : this._repository = repository {
    init();
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
  int Totalcustomer = 0;


  @observable
  String noDataFound = '';
  @observable
  String successMessage = '';
  @observable
  String errorMessage = '';
  @observable
  String email = '';
  @observable
  String phone = '';

  // @observable
  // CustomerModel? customerModel;

  // @observable
  // DocumentList? customerList;
  //
  // @observable
  // int? TotalCustomer = 0;

  // @observable
  // String? selectedUserID;

  @observable
  APICALLSTATE apicallstate = APICALLSTATE.INICIAL;
  //
  // @observable
  // List<CustomerModel>? _originalCustomerList;
  // @observable
  // List<CustomerModel> customerModelList = [];


  // actions:-------------------------------------------------------------------

  @action
  Future createBatch(BatchModel batchModel) async {
    print("Batch Information::: $batchModel");
    //network call
    print("Network call");
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.addDocument(AppDatabase.batch,batchModel.toJson());
    print("Batch FUTURE : $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Batch success true");
        print(value.object);
        success = true;
        successMessage="Create a batch successfully";
        print(successMessage);
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        noDataFound = value.object as String;
      }
    });
  }




  @action
  void clearCartData()  {

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