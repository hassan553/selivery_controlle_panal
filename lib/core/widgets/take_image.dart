import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/widgets/responsive_text.dart';

import '../functions/global_function.dart';
import '../rescourcs/app_colors.dart';
import 'custom_image.dart';

customAddImageForm(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const FittedBox(
        child: ResponsiveText(
          text: 'إضافة صورة',
          scaleFactor: .05,
        ),
      ),
      const Spacer(),
      Container(
        width: screenSize(context).width * .6,
        height: screenSize(context).height * .12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: CustomAssetsImage(path: 'assets/Add Image.png'),
      ),
    ],
  );
}
