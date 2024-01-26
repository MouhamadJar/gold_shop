import 'package:get/get.dart';

class UserSignupModel {
  final String token;
  final int userId;
  final String name;
  final String? photo;
  final int? verified;

  UserSignupModel(
      {required this.userId,
      required this.name,
      this.photo,
      this.verified,
      required this.token});

  factory UserSignupModel.fromJson({required Map<String, dynamic> json}) {
    return UserSignupModel(
      token: json['token'].toString(),
      userId: int.parse(json['user_id'].toString()),
      name: '',
    );
  }
}
