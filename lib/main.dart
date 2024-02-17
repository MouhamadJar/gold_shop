import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/general_controllers/google_map_controller.dart';
import 'core/general_controllers/problems_controller.dart';
import 'core/storage_handler/storage_handler.dart';
import 'core/dictionary/dictionary.dart';
import 'module/main/mediator_shop/signature/view/mediator_shop_view.dart';
import 'module/splash/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    StorageHandler.init(),
  ]);
  // StorageHandler().removeUserId();
  // StorageHandler().removeToken();
  Get.log(StorageHandler().token);
  Get.log(StorageHandler().userId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.log(StorageHandler().lang);
    return GetMaterialApp(
      locale: StorageHandler().locale,
      translations: Dictionary(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      onInit: onAppInit,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

void onAppInit () {
  Get.put(ProblemsController());
  Get.put(AppGoogleMapController());
}
