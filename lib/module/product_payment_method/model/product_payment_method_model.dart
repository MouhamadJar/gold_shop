class StoresModel {
  final int id;

  final String name;

   String? image;

  final dynamic longitude;

  final dynamic latitude;

  final String country;

  final String state;

  final String city;

  final String neighborhood;

  final String street;

  final int isVerified;

  final int isBlocked;

  final dynamic cost;

  StoresModel({
    required this.id,
    required this.name,
     this.image,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.isVerified,
    required this.isBlocked,
    required this.cost,
  });

  factory StoresModel.fromJson({required Map<String, dynamic> json}) {
    return StoresModel(
      id: json['id'],
      name: json['name'],
      image: json['photo']??'',
      longitude: json['longitude'],
      latitude: json['latitude'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      isVerified: json['is_verified'],
      isBlocked: json['blocked'],
      cost: json['cost'],
    );
  }
}
