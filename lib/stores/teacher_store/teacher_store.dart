import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/teacher_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
part 'teacher_store.g.dart';

class TeacherStore = _TeacherStore with _$TeacherStore;

abstract class _TeacherStore with Store{
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _TeacherStore(Repository repository) : this._repository = repository {
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
  bool loadListsuccess = false;
  @observable
  bool createSuccess = false;



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
  String teacher_email = '';


  @observable
  TeacherModel? teacherModel;

  @observable
  DocumentList? teacherList;

  @observable
  String? teacher_documentID = '';
  List<String?> teacherNameList = [];

  // @observable
  // String? selectedUserID;

  @observable
  APICALLSTATE apicallstate = APICALLSTATE.INICIAL;
  //
  // @observable
  // List<CustomerModel>? _originalCustomerList;
  @observable
  List<TeacherModel> teacherModelList = [];


  // actions:-------------------------------------------------------------------

  @action
  Future createTeacher(TeacherModel teacherModel) async {
    print("teacher Information::: $teacherModel");
    //network call
    print("Network call");
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.addDocument(AppDatabase.teacher,teacherModel.toJson());
    print("teacher FUTURE : $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("teacher success true");
        print(value.object);
        createSuccess = true;
        successMessage="Create a teacher successfully";
        print(successMessage);
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        createSuccess = false;
        noDataFound = (value.object == null) ? "Signup not work" : value.object as String;
        print("noDataFound is ::: $noDataFound");
      }
    });
  }

  @action
  Future getTeacherList() async {
    List<Map<String, dynamic>> _list = [];
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.getDocumentList(AppDatabase.teacher);
    print("The future result (teacher List) ::: $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Response code is : ${value.id}");
        success = true;
        print("Sucess is : $success");
        successMessage="Get teacher list Successfully";
        teacherList=value.object as DocumentList;
        loadListsuccess = true;

        for(int i = 0; i < teacherList!.documents.length; i++){
          var document = teacherList!.documents[i].data;

          _list.add(document);

        }
        try{
          teacherModelList = _list.map((data) => TeacherModel.fromJson(data)).toList();
          print("teacher name list ::: ${teacherModelList.reversed}");
          //batchNameList = teacherModelList.map((batch) => batch.batch_name).toList();
          //print("All teacher name as list ::: ${batchNameList}");
        }catch(e){
          print("exception:::${e}");
        }
        print("The teacher Info is :: $teacherList");
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        noDataFound = value.object as String;
        loadListsuccess = false;
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