class BatchModel{
  String? batch_id;
  String? batch_name;
  String? schedule;
  String? time_period;
  String? amount;
  String? batch_status;
  String? document_id;

  BatchModel(
      {this.batch_id,
      this.batch_name,
      this.schedule,
      this.time_period,
      this.amount,
      this.batch_status,
        this.document_id
      });

  // Factory method to create a User object from JSON data
  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      batch_id: json['batch_id'],
      batch_name: json['batch_name'],
      schedule: json['schedule'],
      time_period: json['time_period'],
      amount: json['amount'],
      batch_status: json['batch_status'],
      document_id: json['\$id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_id': batch_id,
    'batch_name': batch_name,
    'schedule': schedule,
    'time_period': time_period,
    'amount': amount,
    'batch_status': batch_status,
  };
}