import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/authentication/controller/user/user_login_controller.dart';
import 'core/storage_handler/storage_handler.dart';
import 'core/dictionary/dictionary.dart';
import 'module/splash/view/splash_view.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    StorageHandler.init(),
  ]);

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