import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'location_entity.dart';
import 'location_model.dart';

abstract class BaseLocationService {

  Stream<LocationEntity> get locationStream;
  StreamSubscription<LocationEntity>? _positionsStream;
  final List<Function(LocationEntity location)> _listeners = [];

  LocationEntity? _cache;

  void _internalListener(LocationEntity location) {
    _cache = location;
  }

  void addListener(void Function(LocationEntity location) listener){
    _listeners.add(listener);
    if(_cache != null) listener(_cache!);
  }

  void removeListener(void Function(LocationEntity location) listener){
    _listeners.remove(listener);
  }

  void start(){
    _positionsStream = locationStream.listen((event) {
      _internalListener(event);
      for (var element in _listeners) {
        element(event);
      }
    });
  }

  void dispose() async {
    await _positionsStream?.cancel();
    _positionsStream = null;
    _listeners.clear();
    print('Location Service <$runtimeType> disposed');
  }


}

class _LocationServiceException implements Exception{
  // TODO :: Words
  @override
  String toString() => 'Location Service is disabled !!';
}

class GeolocatorLocationService extends BaseLocationService{

  StreamSubscription<LocationEntity>? _positionsStream;

  GeolocatorLocationService._();
  static GeolocatorLocationService? _instance;
  static Future<GeolocatorLocationService> getLocationService() async{
    print('start getLocationService');
    var permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      var isEnabled =await Geolocator.isLocationServiceEnabled();
      if(!isEnabled) await Geolocator.openLocationSettings();
      isEnabled = await Geolocator.isLocationServiceEnabled();
      if(isEnabled) return _instance ??= GeolocatorLocationService._();
    }

    throw _LocationServiceException();
  }

  @override
  Stream<LocationEntity> get locationStream => Geolocator.getPositionStream(
      locationSettings:  AndroidSettings(
          forceLocationManager: true,
          accuracy: LocationAccuracy.high,
          distanceFilter: 50,
      ),
  ).map(
          (event) => LocationGeolocatorModel.fromPosition(event)
  );





}


class FakeLocationService extends BaseLocationService{


  FakeLocationService._();
  static FakeLocationService? _instance;
  static Future<FakeLocationService> getLocationService() async {
    print("FAKE LOCATION SERVICE IS RUNNING");
    return _instance ??= FakeLocationService._();
  }

  @override
  Stream<LocationEntity> get locationStream => _fakeLocations();

  Stream<LocationEntity> _fakeLocations()async*{
    final List<LocationEntity> fake = [
      const LocationEntity(lat: 33.50579298376323, lon: 36.317691285191096),
      const LocationEntity(lat: 33.50579298376323, lon: 36.31806268425516),
      const LocationEntity(lat:33.50580118730441, lon:36.31849311363404),
      const LocationEntity(lat:33.50569360323885, lon:36.318541695801215),
      const LocationEntity(lat:33.50550630775703, lon:36.31860860394408),
      const LocationEntity(lat:33.50535388081032, lon:36.31866356420826),
      const LocationEntity(lat:33.50505699618804, lon:36.31879857528571),
      const LocationEntity(lat:33.50482586382766, lon:36.3188344189355),
      const LocationEntity(lat:33.50430282496774, lon:36.31898137789545),
    ];

    for(int i = 0 ; i < fake.length ; i++){
      await Future.delayed(
          Duration(
            milliseconds: 900 + (i == 0 ? 12000 : 0),
            seconds: i % 3 + 2
          )
      );
      yield fake[i];
    }
  }
}