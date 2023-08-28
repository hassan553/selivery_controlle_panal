import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/futures/setting/view/setting_view.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../drivers/views/drivers_license_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSizedBox(value: .02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => navigateTo(context, const SettingView()),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primaryColor,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.list,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ResponsiveText(
                            text: 'معلومات التطبيق',
                            scaleFactor: .05,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            width: screenSize(context).width * .4,
                            child: const Divider(
                              color: AppColors.primaryColor,
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            width: screenSize(context).width * .2,
                            child: const Divider(
                              color: AppColors.primaryColor,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(value: .02),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomAssetsImage(path: 'assets/Europe.png'),
                      const SizedBox(width: 4),
                      const ResponsiveText(
                        text: 'نظرة عامة علي التطبيق',
                        scaleFactor: .05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
                bestClientWidget(
                    context, 'عدد السائقين', 'assets/Driving.png', '212'),
                const CustomSizedBox(value: .01),
                bestClientWidget(
                    context, 'عدد العملاء', 'assets/Businessman.png', '11'),
                const CustomSizedBox(value: .01),
                bestClientWidget(context, 'عدد المركبات الذي تم إضافتها للبيع',
                    'assets/Car.png', '22'),
                const CustomSizedBox(value: .01),
                bestClientWidget(
                    context,
                    'عدد المركبات الذي تم إضافتها للإيجار',
                    'assets/Car.png',
                    '31'),
                const CustomSizedBox(value: .03),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => navigateTo(context, DriversLicenseView()),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ResponsiveText(
                            text: 'فحص بيانات السائق ',
                            scaleFactor: .04,
                            color: AppColors.black,
                          ),
                          const SizedBox(width: 5),
                          CustomAssetsImage(path: 'assets/Driving.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox bestClientWidget(
      BuildContext context, String title, String imagePath, String number) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CustomAssetsImage(path: imagePath),
                ),
                const SizedBox(width: 5),
                ResponsiveText(
                  text: title,
                  scaleFactor: .05,
                  color: AppColors.black,
                ),
                const Spacer(),
                ResponsiveText(
                  text: number,
                  scaleFactor: .05,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
