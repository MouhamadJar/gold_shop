class LoginModel {
  final String token;
  final int userId;
  final String name;
  final String? photo;
  final int verified;

  LoginModel(
      {required this.userId,
      required this.name,
      this.photo,
      required this.verified,
      required this.token});

  factory LoginModel.fromJson({required Map<String, dynamic> json}) {
    return LoginModel(
        token: json['token'],
        userId: json['user_id']??json['store_id'],
        name: json['name'],
        verified: json['verified']);
  }
}
