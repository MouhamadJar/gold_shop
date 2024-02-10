import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/app_fonts.dart';
import '../controller/mediator_shops_map_.dart';

class MediatorShopsMapScreen extends GetView<MediatorShopsMapController> {
  const MediatorShopsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MediatorShopsMapController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppWord.mediatorShops,
          style: TextStyle(
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppFonts.subTitleFont(context),
          ),
        ),
        leading: GestureDetector(onTap : (){Get.back();},child: Icon(Icons.arrow_back)),
        elevation: 1,
        backgroundColor: CustomColors.white,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:controller.initialCameraPosition,
        markers: {
        controller.markerEntity
        },
      ),
    );
  }
}
