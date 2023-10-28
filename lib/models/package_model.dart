class PackageModel{
  String? package_title;
  String? package_description;
  String? package_fee;

  PackageModel(
      {this.package_title,
        this.package_description,
        this.package_fee,
        });

  // Factory method to create a User object from JSON data
  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      package_title: json['title'],
      package_description: json['description'],
      package_fee: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': package_title,
    'description': package_description,
    'amount': package_fee,
  };
}