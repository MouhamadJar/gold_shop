import 'package:gold_shop/core/location_service/location_entity.dart';

class ProfileModel {
  final int id;

  final String firstName;

  final String lastName;

  final String phoneNumber;

  final String? description;

  final String? photo;

  final String email;

  final int addressId;

  final int isVerified;

  final int isEmailVerified;

  final int blocked;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.description,
    this.photo,
    required this.addressId,
    required this.blocked,
    required this.isEmailVerified,
    required this.email,
    required this.isVerified,
  });

  factory ProfileModel.fromJson({required Map<String, dynamic> json}) {

    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      photo: json['photo'],
      email: json['email'],
      isVerified: json['is_verified'],
      isEmailVerified: json['is_email_verified'],
      addressId: json['address_id'],
      description: json['description'],
      blocked: json['blocked'],
    );
  }
}
