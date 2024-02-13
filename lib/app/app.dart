import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/rescourcs/app_colors.dart';
import '../core/rescourcs/app_theme.dart';
import 'package:get/get.dart';
import '../futures/splash/views/splash_view.dart';

class SeliveryControl extends StatelessWidget {
  const SeliveryControl({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      theme: appTheme(),
      title: 'Selivery control',
      home: const SplashView(),
    );
  }
}
