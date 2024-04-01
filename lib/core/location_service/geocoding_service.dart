import 'package:get/get.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';

class GeocodingCoordinatesManager extends GetConnect {
  Future<CoordinatesLocation> convertCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    List<CoordinatesLocation> tmp = [];
    await get(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAMKYCHSG1l-kOoLe1lBPyiyXd2MaukDx4&language=${StorageHandler().lang}')
        .then((location) {
      location.body['results'].forEach((miniLocation) {
        tmp.add(CoordinatesLocation.fromResult(miniLocation));
        Get.log('${miniLocation['formatted_address']} added successfully');
      });
    });
    return getPreferOne(tmp);
  }

  CoordinatesLocation getPreferOne(List<CoordinatesLocation> locations) {
    CoordinatesLocation preferOne = locations.first;
    int score = 0;
    for (int index = 0; index < locations.length; index++) {
      int elementScore = 0;
      if (locations[index].city != '') {
        elementScore += 1;
      }
      if (locations[index].area != '') {
        elementScore += 1;
      }
      if (locations[index].country != '') {
        elementScore += 1;
      }
      if (locations[index].neighborhood != '') {
        elementScore += 1;
      }
      if (elementScore > score) {
        preferOne = locations[index];
        score = elementScore;
      }
    }
    Get.log('prefer location is ${preferOne.formattedAddress}');
    return preferOne;
  }
}

class CoordinatesLocation {
  String formattedAddress;
  String neighborhood;
  String area;
  String city;
  String country;
  String route;

  CoordinatesLocation({
    required this.formattedAddress,
    required this.neighborhood,
    required this.area,
    required this.city,
    required this.country,
    required this.route,
  });

  factory CoordinatesLocation.fromResult(Map<String, dynamic> result) {
    CoordinatesLocation tmp = CoordinatesLocation(
      formattedAddress: result['formatted_address'] ?? 'null',
      neighborhood: '',
      area: '',
      city: '',
      country: '',
      route: '',
    );
    for (int index = 0; index < result['address_components'].length; index++) {
      switch (result['address_components'][index]['types'][0]) {
        case 'administrative_area_level_1':
          tmp.country = result['address_components'][index]['long_name'];
        case 'administrative_area_level_2':
          tmp.area = result['address_components'][index]['long_name'];
        case 'locality':
          tmp.neighborhood = result['address_components'][index]['long_name'];
        case 'country':
          tmp.city = result['address_components'][index]['long_name'];
        case 'route':
          tmp.route = result['address_components'][index]['long_name'];
        default:
          '';
      }
    }
    return tmp;
  }
}
