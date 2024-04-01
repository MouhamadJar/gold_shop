import 'package:flutter/cupertino.dart';
import 'package:gold_shop/core/location_service/location_entity.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MediatorShopProfileModel {
  final LocationEntity location;
  final int userId;

  final String name;

  final String description;

  final String phoneNumber;

  final String? photo;

  final String email;

  final dynamic cost;

  final dynamic longitude;

  final dynamic latitude;

  final String country;

  final String state;

  final String city;

  final String neighborhood;

  final String street;

  final dynamic isVerified;

  final dynamic blocked;

  MediatorShopProfileModel({
    required this.userId,
    required this.name,
    required this.description,
    required this.phoneNumber,
     this.photo,
    required this.email,
    required this.cost,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.isVerified,
    required this.blocked,
    required this.location
  });

  factory MediatorShopProfileModel.fromJson(
      {required Map<String, dynamic> json}) {
    return MediatorShopProfileModel(
      userId: json['id'],
      name: json['name'],
      description: json['description'],
      phoneNumber: json['phone_number'],
      photo: json['photo'],
      email: json['email'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      blocked: json['blocked'],
      isVerified: json['is_verified'],
      cost: json['cost'],
      location:  LocationEntity(lon: json['longitude'],lat: json['latitude']),
    );
  }
}
