import 'package:flutter/material.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/responsive_text.dart';
import '../model/driver_model.dart';

Widget bestDriverWidget(
    BuildContext context, int index, DriverModel driverModel) {
  return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(.5),
              radius: 16,
              child: const Icon(
                Icons.star,
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
            const SizedBox(width: 5),
            ResponsiveText(
              text: "السائق رقم  ${index + 1}",
              scaleFactor: .06,
              color: AppColors.black,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
            height: screenSize(context).height * .2,
            margin: const EdgeInsets.only(right: 30),
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor,
            ),
            child: LayoutBuilder(
              builder: (p0, p1) => Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            ResponsiveText(
                              text: 'الاسم : ${driverModel.name ?? ""}',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                            const ResponsiveText(
                              text: 'رقم الموبيل',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                            ResponsiveText(
                              text: driverModel.phone ?? "",
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  CustomNetworkImage(
                  imagePath:  driverModel.image,
                  width: p1.maxWidth * .4,
                  height: p1.maxHeight,
                  boxFit: BoxFit.fill,

                  ),
                  
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    
  );
}
