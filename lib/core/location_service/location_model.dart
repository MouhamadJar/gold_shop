import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_entity.dart';
import 'package:geolocator/geolocator.dart';

class LocationGeolocatorModel extends LocationEntity {
  const LocationGeolocatorModel({required super.lon, required super.lat});

  factory LocationGeolocatorModel.fromPosition(Position pos) =>
      LocationGeolocatorModel(lon: pos.longitude, lat: pos.latitude);
}

class LocationGoogleModel extends LocationEntity {
  const LocationGoogleModel({required super.lon, required super.lat});

  factory LocationGoogleModel.fromLatLon(LatLng latLng) =>
      LocationGoogleModel(lon: latLng.longitude, lat: latLng.latitude);
}
