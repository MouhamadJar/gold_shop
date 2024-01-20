import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_entity.dart';

extension LocationAdapter on LocationEntity {
  LatLng get toLatLng => LatLng(lat, lon);
}
