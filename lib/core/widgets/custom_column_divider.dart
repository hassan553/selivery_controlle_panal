import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import 'package:selivery_controlle_panal/core/widgets/responsive_text.dart';

import '../functions/global_function.dart';
import '../rescourcs/app_colors.dart';

class CustomColumnDivider extends StatelessWidget {
  final String title;
  final String? imagePath;
  const CustomColumnDivider({super.key, required this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              text: title,
              scaleFactor: .05,
              color: AppColors.black,
            ),
            const SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: CustomAssetsImage(
                path: imagePath ?? 'assets/Folded Booklet.png',
                width: screenSize(context).width * .08,
                boxFit: BoxFit.fill,
              ),
            )
          ],
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
    );
  }
}
