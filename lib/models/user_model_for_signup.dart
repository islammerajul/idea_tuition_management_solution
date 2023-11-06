class UserModel {
  final String userId;
  final String name;
  final String email;
  // Add more user properties here as needed

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    // Initialize additional properties here
  });

  // Create a factory constructor to deserialize user data from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      // Map additional properties from JSON here
    );
  }

  // Convert the user model to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      // Add more properties here
    };
  }
}