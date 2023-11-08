import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/student_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
part 'student_store.g.dart';

class StudentStore = _StudentStore with _$StudentStore;

abstract class _StudentStore with Store{
  // repository instance
  late Repository _repository;

  AppDialog dialog = new AppDialog();

  // constructor:---------------------------------------------------------------
  _StudentStore(Repository repository) : this._repository = repository {
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
  String selected_img = '';

  @observable
  StudentModel? studentModel;

  @observable
  DocumentList? studentList;
  //
  @observable
  int? TotalStudent = 0;

  @observable
  String? student_documentID = '';
  @observable
  String? select_studentName = '';

  @observable
  APICALLSTATE apicallstate = APICALLSTATE.INICIAL;
  //
  // @observable
  // List<CustomerModel>? _originalCustomerList;
  @observable
  List<StudentModel> studentModelList = [];


  // actions:-------------------------------------------------------------------

  @action
  Future createStudent(StudentModel studentModel) async {
    print("Student Information::: $studentModel");
    //network call
    print("Network call");
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.addDocument(AppDatabase.student,studentModel.toJson());
    print("Student FUTURE : $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Student success true");
        print(value.object);
        success = true;
        successMessage="Create a student successfully";
        print(successMessage);
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        noDataFound = value.object as String;
        //noDataFound = "value.object as String";
      }
    });
  }

  @action
  Future getStudentList() async {
    List<Map<String, dynamic>> _list = [];
    loading = true;
    apicallstate=APICALLSTATE.LOADING;
    final future = _repository.getDocumentList(AppDatabase.student);
    print("The future result (Student List) ::: $future");
    await future.then((value) async {
      loading = false;
      if (value.id == ResponseCode.SUCCESSFUL) {
        apicallstate=APICALLSTATE.RESPONSE;
        print("Response code is : ${value.id}");
        success = true;
        print("Sucess is : $success");
        successMessage="Get student list Successfully";
        studentList=value.object as DocumentList;

        for(int i = 0; i < studentList!.documents.length; i++){
          var document = studentList!.documents[i].data;

          _list.add(document);

        }
        try{
          studentModelList = _list.map((data) => StudentModel.fromJson(data)).toList();
          print("Student name list ::: ${studentModelList.reversed}");
        }catch(e){
          print("exception:::${e}");
        }
        print("The Student Info is :: $studentList");
      } else {
        apicallstate=APICALLSTATE.RESPONSE;
        success = false;
        //noDataFound = value.object as String;
        noDataFound = (value.object == null) ? "Student List not work" : value.object as String;
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