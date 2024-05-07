import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/general_controllers/google_map_controller.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/dimensions.dart';

class AppGoogleMap extends GetView<AppGoogleMapController> {
   AppGoogleMap(
      {super.key,
      this.markers = const {},
      this.cameraPosition,
      this.height,
      this.width,
      this.onTap,
      this.onCameraMoved
      });

  final Set<Marker> markers;
  final CameraPosition? cameraPosition;
  final double? width;
  final double? height;
  final Function(LatLng)? onTap;
  final Function(CameraPosition)? onCameraMoved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenDimensions.screenWidth(context),
      height: height ?? ScreenDimensions.heightPercentage(context, 25),
      decoration: BoxDecoration(border: Border.all()),
      child: GoogleMap(
        onCameraMove: onCameraMoved,
        onMapCreated: (mapController) {
          controller.mapController = mapController;
        },
        onTap: onTap,
        minMaxZoomPreference: const MinMaxZoomPreference(6, 19),
        gestureRecognizers: {
          Factory(
            () => EagerGestureRecognizer(
              allowedButtonsFilter: (buttons) => true,
              supportedDevices: {
                PointerDeviceKind.touch,
              },
            ),
          ),
        },
        initialCameraPosition: cameraPosition == null ? controller.position! : cameraPosition!,
        markers: markers,
      ),
    ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2));
  }
}
