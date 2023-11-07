import 'package:appwrite/models.dart';
import 'package:idea_tuition_managment_app/constants/app_data.dart';
import 'package:idea_tuition_managment_app/constants/database.dart';
import 'package:idea_tuition_managment_app/data/repository/repository.dart';
import 'package:idea_tuition_managment_app/models/base/model_response_object.dart';
import 'package:idea_tuition_managment_app/models/teacher_model.dart';
import 'package:idea_tuition_managment_app/utils/app_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idea_tuition_managment_app/data/sharedpref/constants/preferences.dart' as aw;
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
  bool hasFilteredTeacherList = false;
  @observable
  bool functionLoading = false;
  @observable
  bool isTeacherCountFetched = false;


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
  int count = 0;
  @observable
  int sameEmailCount = 0;


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

        print("Total Teacher Number ::${teacherList!.documents.length}");
        for(int i = 0; i < teacherList!.documents.length; i++){
          var document = teacherList!.documents[i].data;

          _list.add(document);

        }
        try{
          teacherModelList = _list.map((data) => TeacherModel.fromJson(data)).toList();
          print("teacher name list ::: ${teacherModelList.reversed}");
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


  // @action
  // Future<int> filterTeacherList( DocumentList? teacherList) async {
  //   print("Now list is created");
  //   if (teacherList == null) {
  //     // Handle the case where deliveryManList is null
  //     print("Teacher Number:: null value");
  //     //return "done";
  //   }
  //   var totalTeacher = teacherList!.total;
  //   print("Teacher Number:: ${totalTeacher}");
  //   var teacher_List = teacherList!.documents.toList();
  //   print("Teacher List:: ${teacher_List}");
  //   List<Map<String, dynamic>> AllTeacher = [];
  //
  //   print("teacher_List.length in filterTeacherList :: ${teacher_List.length}");
  //   for(int i = 0; i < teacher_List.length; i++){
  //     print("List will be arranged");
  //     var document = teacher_List[i].data;
  //     AllTeacher.add(document);
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     var checkEmailList = document.containsKey('email') && document['email'] == preferences.getString(aw.Preferences.user_email);
  //     print("Show email :: ${preferences.getString(aw.Preferences.user_email)}");
  //     if(checkEmailList){
  //       count++;
  //       if(count == 1){
  //         var d = document['\$id'];
  //       }
  //     }
  //   }
  //   hasFilteredTeacherList = true;
  //   print("How many email are same : $count");
  //   try{}catch(e){
  //     print("exception:::${e}");
  //   }
  //   // Return a flag indicating whether the dialog should be shown
  //   //hasFilteredTeacherList = false;
  //   return count;
  // }
  //
  // @action
  // Future countSameMail() async {
  //   print("Enter countSameMail function");
  //   getTeacherList();
  //   sameEmailCount = await filterTeacherList(teacherList);
  //   functionLoading =true;
  //   isTeacherCountFetched = true;
  //   print("Stop countSameMail function");
  //   functionLoading = false;
  // }
  //
  // @action
  // void clearCartData()  {
  //   count = 0;
  //   sameEmailCount = 0;
  // }


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