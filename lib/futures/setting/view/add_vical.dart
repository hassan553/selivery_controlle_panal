import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../../core/widgets/take_image.dart';

class AddVicalView extends StatelessWidget {
  const AddVicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
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
                  title: 'إضافة مركبة',
                  imagePath: 'assets/Car.png',
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const FittedBox(
                      child: ResponsiveText(
                        text: 'نوع المركبة',
                        scaleFactor: .05,
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: screenSize(context).width * .6,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_circle_down_sharp,
                            color: AppColors.primaryColor,
                          ),
                          Spacer(),
                          ResponsiveText(
                            text: 'سياره ',
                            scaleFactor: .04,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize(context).height * .01),
                customAddImageForm(context),
                SizedBox(height: screenSize(context).height * .02),
                Container(
                  width: screenSize(context).width * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: const FittedBox(
                    child: ResponsiveText(
                      text: 'إضافة ',
                      scaleFactor: .04,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
