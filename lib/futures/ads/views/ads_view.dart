import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../controller/ads_controller.dart';
import '../controller/all_ads_controller.dart';
import 'add_ads_view.dart';
import 'all_ads_view.dart';

class AdsView extends StatelessWidget {
  final AdsController controller = Get.put(AdsController());
  final allAdsController = Get.put(AllAdsController());

  AdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .05),
              SizedBox(
                height: 120,
                width: screenSize(context).width / 2,
                child: const Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    CustomAssetsImage(path: 'assets/megaphone.png'),
                    Positioned(
                        bottom: 2,
                        child: CustomAssetsImage(
                          path: 'assets/pngwing 15.png',
                          boxFit: BoxFit.fill,
                        )),
                  ],
                ),
              ),
              const CustomSizedBox(value: .02),
              InkWell(
                onTap: () => navigateTo(context, const AddAdsView()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.modulate,
                        ),
                        child: CustomAssetsImage(
                          path: 'assets/Rectangle 187.png',
                          width: screenSize(context).width,
                          height: screenSize(context).height * .15,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetsImage(
                            path: 'assets/Natural User Interface 5.png',
                            // width: screenSize(context).width,
                            //height: screenSize(context).height * .2,
                            boxFit: BoxFit.fill,
                          ),
                          SizedBox(width: 5),
                          ResponsiveText(
                            text: 'إضافة إعلان',
                            scaleFactor: .06,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const CustomSizedBox(value: .015),
              InkWell(
                onTap: () => navigateTo(context, const AllAdsView()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.modulate,
                        ),
                        child: CustomAssetsImage(
                          path: 'assets/Rectangle 188.png',
                          width: screenSize(context).width,
                          height: screenSize(context).height * .15,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetsImage(
                            path: 'assets/Natural User Interface 5.png',
                            // width: screenSize(context).width,
                            //height: screenSize(context).height * .2,
                            boxFit: BoxFit.fill,
                          ),
                          SizedBox(width: 5),
                          ResponsiveText(
                            text: 'مراقبة الإعلانات',
                            scaleFactor: .06,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
