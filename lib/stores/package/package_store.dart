import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/package_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
part 'package_store.g.dart';

class PackageStore = _PackageStore with _$PackageStore;

abstract class _PackageStore with Store{
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _PackageStore(Repository repository) : this._repository = repository {
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
  @observable
  String select_package = '';

  @observable
  PackageModel? packageModel;

  @observable
  DocumentList? packageList;
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
  @observable
  List<PackageModel> packageModelList = [];


  // actions:-------------------------------------------------------------------

  @action
  Future createPackage(PackageModel packageModel) async {
    print("Package Information::: $packageModel");
    //network call
    print("Network call");
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.addDocument(AppDatabase.package,packageModel.toJson());
    print("Package FUTURE : $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Package success true");
        print(value.object);
        success = true;
        successMessage="Create a package successfully";
        print(successMessage);
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        noDataFound = value.object as String;
      }
    });
  }

  @action
  Future getPackageList() async {
    List<Map<String, dynamic>> _list = [];
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.getDocumentList(AppDatabase.package);
    print("The future result (Package List) ::: $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Response code is : ${value.id}");
        success = true;
        print("Sucess is : $success");
        successMessage="Get package list Successfully";
        packageList=value.object as DocumentList;

        for(int i = 0; i < packageList!.documents.length; i++){
          var document = packageList!.documents[i].data;

          _list.add(document);

        }
        try{
          packageModelList = _list.map((data) => PackageModel.fromJson(data)).toList();
          print("Package name list ::: ${packageModelList.reversed}");
        }catch(e){
          print("exception:::${e}");
        }
        print("The Package Info is :: $packageList");
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