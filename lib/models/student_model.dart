import 'package:idea_tuition_managment_app/models/batch_model.dart';

class StudentModel{
  String? student_id;
  String? student_name;///
  String? st_phone;///
  String? st_email;///
  String? st_gender;///
  String? st_dob;///
  String? st_institution;///
  String? st_image;///
  String? st_blood_group;
  String? st_father_name;
  String? st_mother_name;
  String? st_parent_phone;
  String? st_parent_email;
  String? st_address;
  String? active_status;
  List? batch_DocID;
  List? packages_DocID;
  List? teachers_DocID;
  List? grade_DocID;
  String? student_documentID;
  //BatchModel? batchModel;

  StudentModel(
      {this.student_id,
        this.student_name,
        this.st_phone,
        this.st_email,
        this.st_gender,
        this.st_dob,
        this.st_institution,
        this.st_image,
        this.st_blood_group,
        this.st_father_name,
        this.st_mother_name,
        this.st_parent_phone,
        this.st_parent_email,
        this.st_address,
        this.active_status,
        this.batch_DocID,
        this.packages_DocID,
        this.grade_DocID,
        this.teachers_DocID,
        this.student_documentID,
        //this.batchModel,
      });

  // Factory method to create a User object from JSON data
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      student_id: json['student_id'],
      student_name: json['student_name'],
      st_phone: json['st_phone'],
      st_email: json['st_email'],
      st_gender: json['st_gender'],
      st_dob: json['st_dob'],
      st_institution: json['st_institution'],
      st_image: json['st_image'],
      st_blood_group: json['st_blood_group'],
      st_father_name: json['st_father_name'],
      st_mother_name: json['st_mother_name'],
      st_parent_phone: json['st_parent_phone'],
      st_parent_email: json['st_parent_email'],
      st_address: json['st_address'],
      active_status: json['active_status'],
      student_documentID: json['\$id'],
      //batchModel: json['batch'] != null ? BatchModel.fromJson(json['batch']) : BatchModel(),
    );
  }

  Map<String, dynamic> toJson() => {
    'student_id': student_id,
    'student_name': student_name,
    'st_phone': st_phone,
    'st_email': st_email,
    'st_gender': st_gender,
    'st_dob': st_dob,
    'st_institution': st_institution,
    'st_image': st_image,
    'st_blood_group': st_blood_group,
    'st_father_name': st_father_name,
    'st_mother_name': st_mother_name,
    'st_parent_phone': st_parent_phone,
    'st_parent_email': st_parent_email,
    'st_address': st_address,
    'active_status': active_status,
    'batch': batch_DocID,
    'packages': packages_DocID,
    'teachers': teachers_DocID,
    'grade': grade_DocID,
  };
}