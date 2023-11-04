class TeacherModel{
  String? teacher_name;
  String? teacher_phone;
  String? teacher_email;
  String? teacher_address;
  String? teacher_institution;

  TeacherModel(
      {this.teacher_name,
      this.teacher_phone,
      this.teacher_email,
      this.teacher_address,
      this.teacher_institution});

  // Factory method to create a User object from JSON data
  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      teacher_name: json['name'],
      teacher_email: json['email'],
      teacher_phone: json['contract_number'],
      teacher_address: json['address'],
      teacher_institution: json['institution'],

      //batchModel: json['batch'] != null ? BatchModel.fromJson(json['batch']) : BatchModel(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': teacher_name,
    'email': teacher_email,
    'contract_number': teacher_phone,
    'address': teacher_address,
    'institution': teacher_institution,


  };
}