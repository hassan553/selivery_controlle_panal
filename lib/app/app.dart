import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';
import 'package:selivery_controlle_panal/futures/splash/views/splash_view.dart';
import '../core/rescourcs/app_theme.dart';
import 'package:get/get.dart';
class SeliveryControl extends StatelessWidget {
  const SeliveryControl({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: appTheme(),
        title: 'Selivery control',
        home: const SplashView(),
    );
  }
}
