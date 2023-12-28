import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/responsive_text.dart';

class TopTitleWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final String? image;
  final String? name;

  const TopTitleWidget(
      {super.key,
      required this.title1,
      required this.title2,
      this.name,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (p0, p1) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: ResponsiveText(
                    text: title1,
                    scaleFactor: .25,
                    color: AppColors.primaryColor,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CustomNetworkImage(
                    boxFit: BoxFit.fill,
                    width: 120,
                    imagePath: image ?? '',
                  ),
                ),
                FittedBox(
                  child: ResponsiveText(
                    text: title2,
                    scaleFactor: .25,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            );
          },
        ),
        ResponsiveText(
          text: name ?? ' ',
          scaleFactor: .07,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
