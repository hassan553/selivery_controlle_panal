import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class DriversLicenseView extends StatelessWidget {
  const DriversLicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [
          const CustomSizedBox(value: .02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
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
              const Expanded(
                child: CustomColumnDivider(
                  title: 'رخص السائقين',
                  imagePath: 'assets/Identification Documents.png',
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize(context).height * .03),
          Container(
              height: screenSize(context).height * .3,
              width: screenSize(context).width,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffD9D9D9),
              ),
              child: LayoutBuilder(
                builder: (p0, p1) => Column(
                  children: [
                    SizedBox(
                      height: p1.maxHeight / 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: const [
                                    ResponsiveText(
                                      text: 'إسم السائق : محمود أحمد',
                                      scaleFactor: .06,
                                      color: AppColors.black,
                                    ),
                                    ResponsiveText(
                                      text: 'رقم الموبايل ',
                                      scaleFactor: .06,
                                      color: AppColors.black,
                                    ),
                                    ResponsiveText(
                                      text: ' 01115690652',
                                      scaleFactor: .06,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          CustomAssetsImage(
                            width: p1.maxWidth * .4,
                            height: p1.maxHeight,
                            boxFit: BoxFit.fill,
                            path: 'assets/Rectangle 253.png',
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const ResponsiveText(
                              text: 'رخصة القيادة',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                            CustomAssetsImage(
                                path: 'assets/saudi_licene_back 1.png')
                          ],
                        ),
                        Column(
                          children: [
                            const ResponsiveText(
                              text: 'رخصة السيارة',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                            CustomAssetsImage(path: 'assets/image-1 1.png')
                          ],
                        ),
                        Column(
                          children: [
                            const ResponsiveText(
                              text: 'صورة البطاقة',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                            CustomAssetsImage(
                                boxFit: BoxFit.fill,
                                path: 'assets/Rectangle 268.png')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          SizedBox(height: screenSize(context).height * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: const ResponsiveText(
                  text: 'قبول',
                  scaleFactor: 0.04,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.red,
                ),
                child: const ResponsiveText(
                  text: 'رفض',
                  scaleFactor: 0.04,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
