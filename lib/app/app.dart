import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selivery_controlle_panal/core/rescourcs/app_colors.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';
import 'package:selivery_controlle_panal/futures/splash/views/splash_view.dart';
import '../core/rescourcs/app_theme.dart';
import 'package:get/get.dart';

class SeliveryControl extends StatelessWidget {
  const SeliveryControl({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, // Set your desired color
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      textDirection: TextDirection.rtl,
      theme: appTheme(),
      title: 'Selivery control',
      home: MainView(),//const SplashView(),
    );
  }
}
