import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_button.dart';

import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../../core/widgets/take_image.dart';

class AddAdsView extends StatelessWidget {
  const AddAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
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
                      child: CustomColumnDivider(title: 'إضافة إعلان جديد')),
                ],
              ),
              const CustomSizedBox(value: .02),
              customForm(context, 'إسم الإعلان', 40),
              const CustomSizedBox(value: .02),
              customForm(context, 'لينك الإعلان', 40),
              const CustomSizedBox(value: .02),
              customForm(context, 'تفاصيل الإعلان', 100),
              const CustomSizedBox(value: .02),
              customAddImageForm(context),
              const CustomSizedBox(value: .05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: const ResponsiveText(
                  text: 'إضافة ',
                  scaleFactor: .04,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  Row customForm(BuildContext context, String title, double maxLine) {
    return Row(
      children: [
        FittedBox(
          child: ResponsiveText(
            text: title,
            scaleFactor: .05,
          ),
        ),
        const Spacer(),
        SizedBox(
          height: maxLine,
          width: screenSize(context).width * .6,
          child: TextFormField(
            maxLines: 4,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 10),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
