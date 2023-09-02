/// statusCode : 200
/// status : true
/// message : "File number is found"
/// data : {"mobile":"505412342"}

class BaseResponseModel {
  BaseResponseModel({
      int? statusCode, 
      bool? status, 
      String? message, 
      Object? data,}){
    _statusCode = statusCode;
    _status = status;
    _message = message;
    _data = data;
}

  BaseResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  int? _statusCode;
  bool? _status;
  String? _message;
  Object? _data;

  int? get statusCode => _statusCode;
  bool? get status => _status;
  String? get message => _message;
  Object? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}


