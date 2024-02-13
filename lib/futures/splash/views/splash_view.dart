import 'package:flutter/material.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../auth/view/login_view.dart';
import '../../home/view/main_view.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/responsive_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => checkAuth());
  }

  checkAuth() {
    final token = CacheStorageServices().token;
    if (token.isEmpty) {
      navigateOff(context, LoginView());
    } else {
      navigateOff(context, MainView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetsImage(
              path: 'assets/Untitled-1 2.png',
              width: screenSize(context).width * .6,
              boxFit: BoxFit.fill,
            ),
            Container(
              width: screenSize(context).width * .7,
              height: screenSize(context).height * .3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xff937445),
              ),
              child: LayoutBuilder(
                builder: (p0, p1) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 5,
                      right: 10,
                      child: CustomAssetsImage(
                        path: 'assets/gear.png',
                        width: screenSize(context).width * .4,
                        height: screenSize(context).height * .2,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    CustomAssetsImage(
                      path: 'assets/taxi car.png',
                      width: screenSize(context).width * .5,
                      height: screenSize(context).height * .2,
                      boxFit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            const CustomSizedBox(value: .04),
            const ResponsiveText(
              text: 'control panel',
              scaleFactor: .13,
              color: AppColors.white,
            ),
            const ResponsiveText(
              text: 'Loading...',
              scaleFactor: .1,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
