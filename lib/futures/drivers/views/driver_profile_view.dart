import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/drivers_controller.dart';
import 'package:selivery_controlle_panal/futures/drivers/model/driver_model.dart';

import '../../../../../core/functions/global_function.dart';
import '../../../../../core/rescourcs/app_colors.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/custom_text.dart';

import '../../../../../core/widgets/custom_appBar.dart';
import '../../../../../core/widgets/custom_divider.dart';
import '../../../../../core/widgets/custom_sized_box.dart';
import '../../../../../core/widgets/responsive_text.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../widgets/top_title.dart';
import '../widgets/user_info.dart';

class DriverProfileView extends StatelessWidget {
  final DriverModel driverModel;
   DriverProfileView({super.key, required this.driverModel});
  final DriversController controller = Get.find<DriversController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: GetBuilder<DriversController>(
        builder: (controller) {
          return driverProfileBody(context);
        },
      ),
    );
  }

  SingleChildScrollView driverProfileBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: SizedBox(
          width: screenSize(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetBuilder<DriversController>(
                builder: (controller) => TopTitleWidget(
                  title1: 'سا',
                  title2: 'ئق',
                  image: "$baseUri${driverModel.image}",
                  name: driverModel.name,
                ),
              ),
              const CustomDivider(),
              driverCV(),
              const CustomDivider(),
              driverEvaulte(),
              const CustomDivider(),
              carType(context),
              const CustomDivider(),
              UserInfo(driverModel: driverModel),
              const CustomDivider(),
              const CustomSizedBox(value: .02),
              licensesWidget(),
              const CustomDivider(),
              const CustomSizedBox(value: .02),
              deleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Obx deleteButton(context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.red,
        ),
        child: InkWell(
          onTap: () =>
              controller.deleteDriverAccount(driverModel.sId!, context),
          child: controller.deleteIsLoading.value
              ? const CustomLoadingWidget()
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ResponsiveText(
                      text: 'حذف',
                      scaleFactor: .04,
                      color: AppColors.white,
                    ),
                    Icon(
                      Icons.delete,
                      color: AppColors.white,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Row licensesWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const ResponsiveText(
              text: 'رخصة القيادة',
              scaleFactor: .04,
              color: AppColors.black,
            ),
            Image.network(
              "$baseUri${driverModel.image}",
              // '$baseUri${model.driverLicense}',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ],
        ),
        Column(
          children: [
            const ResponsiveText(
              text: 'رخصة السيارة',
              scaleFactor: .04,
              color: AppColors.black,
            ),
            Image.network(
              "$baseUri${driverModel.image}",
              // '$baseUri${model.vehicleLicense}',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ],
        ),
        Column(
          children: [
            const ResponsiveText(
              text: 'صورة البطاقة',
              scaleFactor: .04,
              color: AppColors.black,
            ),
            Image.network(
              "$baseUri${driverModel.image}",
              //'$baseUri${model.nationalId}',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ],
        ),
      ],
    );
  }

  Row carType(context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: 'نوع السيارة',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              title: driverModel.vehicle?.model ?? '',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryColor)),
            child: const CustomNetworkImage(imagePath: ''),
          ),
        )
      ],
    );
  }

  Row driverEvaulte() {
    return Row(
      children: [
        CustomText(
          title: 'التقيم',
          fontSize: 16,
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.arrow_forward,
          color: AppColors.primaryColor,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            driverEvaluate(
                const Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                'مقبول'),
            driverEvaluate(
                const Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                'جيد'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(title: '50%', fontSize: 8),
                driverEvaluate(
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    'رائع'),
                CustomText(title: '50 تفاعل', fontSize: 8),
              ],
            )
          ],
        )),
      ],
    );
  }

  Row driverCV() {
    return Row(
      children: [
        const ResponsiveText(
          scaleFactor: .03,
          text: 'السيرة الذاتيه',
        ),
        const SizedBox(width: 10),
        GetBuilder<DriversController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.7),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(5),
              child: const Text(
                "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget driverEvaluate(Icon icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        CustomText(
          title: title,
          fontSize: 14,
        ),
      ],
    );
  }
}
