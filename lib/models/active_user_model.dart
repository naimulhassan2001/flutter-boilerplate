class ActiveUserModel {
  String userFullName;
  String id;
  String email;
  String role;
  String image;
  int iat;
  int exp;

  ActiveUserModel({
    required this.userFullName,
    required this.id,
    required this.email,
    required this.role,
    required this.iat,
    required this.exp,
    required this.image,
  });

  factory ActiveUserModel.fromJson(Map<String, dynamic> json) {
    return ActiveUserModel(
      userFullName: json['userFullName'] ?? '',
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
      iat: json['iat'] ?? 0,
      exp: json['exp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userFullName': userFullName,
      '_id': id,
      'email': email,
      'role': role,
      'iat': iat,
      'exp': exp,
      'image': exp,
    };
    return data;
  }
}
