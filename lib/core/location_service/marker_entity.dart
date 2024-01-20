import 'package:equatable/equatable.dart';
import 'extention.dart';
import 'location_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInfo extends Equatable {
  final String markerId;
  final String title;
  final String subTitle;
  final LocationEntity location;

  const MarkerInfo({
    required this.markerId,
    required this.title,
    required this.subTitle,
    required this.location,
  });

  @override
  List<Object?> get props => [
        markerId,
        title,
        subTitle,
        location,
      ];

  @override
  String toString() =>
      'Marker info : \ntitle :$title .\ndub title :$subTitle .\nlatlang :${location.toString()}';
}

class MarkerEntity extends Marker {
  const MarkerEntity(
      {required super.markerId,
      required super.position,
      required super.infoWindow});

  factory MarkerEntity.fromMarkerInfo({required MarkerInfo info}) {
    return MarkerEntity(
      markerId: MarkerId(info.markerId),
      position: info.location.toLatLng,
      infoWindow: InfoWindow(
        title: info.title,
        snippet: info.subTitle,
      ),
    );
  }
}
