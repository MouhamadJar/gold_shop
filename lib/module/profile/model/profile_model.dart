class ProfileModel {
  final int id;

  final String firstName;

  final String lastName;

  final String phoneNumber;

  final String? photo;

  final String email;

  final double latitude;

  final double longitude;

  final String country;

  final String state;

  final String city;

  final String neighborhood;

  final String street;

  final bool isVerified;

  final dynamic blocked;

  final String deletedAt;

  final String createdAt;

  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.photo,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.isVerified,
    this.blocked,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      photo: json['photo'],
      email: json['email'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      isVerified: json['is_verified'],
      blocked: json['blocked'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
