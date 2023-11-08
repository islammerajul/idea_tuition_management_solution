import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/payment_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
part 'payment_store.g.dart';

class PaymentStore = _PaymentStore with _$PaymentStore;

abstract class _PaymentStore with Store{
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _PaymentStore(Repository repository) : this._repository = repository {
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
  String selected_batchName = 'Class 9(Boys)';

  @observable
  PaymentModel? paymentModel;

  @observable
  DocumentList? paymentList;

  @observable
  int? Total = 0;
  @observable
  String? select_batchName = '';
  @observable
  String? batch_documentID = '';
  @observable
  List<String?> paymentNameList = [];

  // @observable
  // String? selectedUserID;

  @observable
  APICALLSTATE apicallstate = APICALLSTATE.INICIAL;
  //
  // @observable
  // List<CustomerModel>? _originalCustomerList;
  @observable
  List<PaymentModel> paymentModelList = [];


  // actions:-------------------------------------------------------------------

  @action
  Future createPayment(PaymentModel paymentModel) async {
    print("Payment Information::: $paymentModel");
    //network call
    print("Network call");
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.addDocument(AppDatabase.payment,paymentModel.toJson());
    print("Payment FUTURE : $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Payment success true");
        print(value.object);
        success = true;
        successMessage="Create a payment successfully";
        print(successMessage);
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        noDataFound = (value.object == null) ? "Payment not work" : value.object as String;
        print("noDataFound is ::: $noDataFound");
      }
    });
  }

  @action
  Future getPaymentList() async {
    List<Map<String, dynamic>> _list = [];
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.getDocumentList(AppDatabase.payment);
    print("The future result (Payment List) ::: $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Response code is : ${value.id}");
        success = true;
        print("Sucess is : $success");
        successMessage="Get payment list Successfully";
        paymentList=value.object as DocumentList;

        for(int i = 0; i < paymentList!.documents.length; i++){
          var document = paymentList!.documents[i].data;

          _list.add(document);

        }
        try{
          paymentModelList = _list.map((data) => PaymentModel.fromJson(data)).toList();
          print("Payment name list ::: ${paymentModelList.reversed}");
          //paymentNameList = paymentModelList.map((payment) => payment.batch).toList();
          //print("All payment name as list ::: ${paymentNameList}");
        }catch(e){
          print("exception:::${e}");
        }
        print("The Payment Info is :: $paymentList");
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        //noDataFound = value.object as String;
        noDataFound = (value.object == null) ? "Payment List not work" : value.object as String;
        print("noDataFound is ::: $noDataFound");
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