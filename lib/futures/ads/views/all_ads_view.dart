import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_column_divider.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';

import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class AllAdsView extends StatelessWidget {
  const AllAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .01),
              const CustomColumnDivider(title: 'الإعلانات'),
              const CustomSizedBox(value: .02),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      customAdsWidget(context, index),
                  itemCount: 10,
                ),
              ),
              const CustomSizedBox(value: .02),
            ],
          ),
        ));
  }

  Column customAdsWidget(BuildContext context, int index) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              color: AppColors.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ResponsiveText(
              text: '# الإعلان ${index + 1} ',
              scaleFactor: .04,
              color: AppColors.black,
            ),
          ),
        ),
        CustomAssetsImage(
          path: 'assets/Rectangle 247.png',
          width: screenSize(context).width,
          height: screenSize(context).height * .3,
          boxFit: BoxFit.fill,
        ),
        const CustomSizedBox(value: .02),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAssetsImage(
                          width: 20,
                          path: 'assets/Natural User Interface 5.png'),
                      const ResponsiveText(
                        text: 'عدد النقرات :23 ',
                        scaleFactor: .03,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              height: 50,
              width: 1,
              color: Colors.black,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.red,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: FittedBox(
                  child: Row(
                    children: const [
                      ResponsiveText(
                        text: 'حذف الإعلان ',
                        scaleFactor: .03,
                        color: AppColors.white,
                      ),
                      Icon(
                        Icons.delete,
                        color: AppColors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
