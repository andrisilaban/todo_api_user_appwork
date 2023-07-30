class UserModel {
  final String name;
  final String email;
  int? id;

  UserModel({
    required this.name,
    required this.email,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return '$name $email $id';
  }
}
