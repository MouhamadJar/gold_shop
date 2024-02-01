import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/dimensions.dart';

class AppGoogleMap extends StatelessWidget {
  const AppGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenDimensions.screenWidth(context),
      height: ScreenDimensions.heightPercentage(context, 25),
      decoration: BoxDecoration(border: Border.all()),
      child: GoogleMap(
          onMapCreated: (mapController) {
            controller.mapController =
                mapController;
          },
          gestureRecognizers: {
            Factory(
                  () => EagerGestureRecognizer(
                  allowedButtonsFilter: (buttons) =>
                  true,
                  supportedDevices: {
                    PointerDeviceKind.touch
                  }),
            ),
          },
          initialCameraPosition:
          controller.position!,
          markers: {controller.marker!}),
    ).paddingSymmetric(
        vertical: ScreenDimensions.heightPercentage(
            context, 2));
  }
}
