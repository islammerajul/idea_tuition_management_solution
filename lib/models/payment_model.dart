import 'package:idea_tuition_managment_app/models/batch_model.dart';
import 'package:idea_tuition_managment_app/models/student_model.dart';

class PaymentModel{
  String? document_id;
  String? payment_status;
  String? month;
  String? batch;
  String? students;
  BatchModel? batchModel;
  StudentModel? studentModel;

  PaymentModel({this.payment_status, this.month, this.batch, this.students, this.document_id, this.studentModel, this.batchModel});

  // Factory method to create a User object from JSON data
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      payment_status: json['payment_status'],
      month: json['month'],

      document_id: json['\$id'],
      batchModel: json['batch'] != null ? BatchModel.fromJson(json['batch']) : BatchModel(),
      studentModel: json['students'] != null ? StudentModel.fromJson(json['students']) : StudentModel(),
    );
  }

  Map<String, dynamic> toJson() => {
    'payment_status': payment_status,
    'month': month,
    'batch': batch,
    'students': students,
  };
}