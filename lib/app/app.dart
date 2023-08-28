import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/futures/setting/view/all_vichal.dart';
import 'package:selivery_controlle_panal/futures/splash/views/splash_view.dart';
import '../core/rescourcs/app_theme.dart';
import '../futures/home/view/main_view.dart';
import '../futures/search/view/search_view.dart';
import '../futures/setting/view/add_vical.dart';
import '../futures/setting/view/setting_view.dart';

class SeliveryControl extends StatelessWidget {
  const SeliveryControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: appTheme(),
        title: 'Selivery control',
        home:const  SplashView(),
      ),
    );
  }
}
