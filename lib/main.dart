import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/storage_handler/storage_handler.dart';
import 'core/dictionary/dictionary.dart';
import 'module/splash/view/splash_view.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    StorageHandler.init(),
  ]);
Get.log(StorageHandler().token);
Get.log(StorageHandler().userId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ar'),
      translations: Dictionary(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
