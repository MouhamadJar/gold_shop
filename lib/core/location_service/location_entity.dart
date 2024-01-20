import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double lon;
  final double lat;

  const LocationEntity({required this.lon, required this.lat});

  @override
  List<Object?> get props => [lon, lat];

  @override
  String toString() => 'Location Entity (lon : $lon , lat : $lat)';
}
