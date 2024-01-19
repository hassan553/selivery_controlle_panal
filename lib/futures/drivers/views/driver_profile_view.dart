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
                  image: driverModel.image,
                  name: driverModel.name,
                ),
              ),
              const CustomDivider(),
              driverCV(),
              const CustomDivider(),
              driverEvaulte(),
              const CustomDivider(),
              if (driverModel.vehicle?.images != null) ...[
                carType(context),
                const CustomDivider(),
              ],
              UserInfo(driverModel: driverModel),
              const CustomDivider(),
              const CustomSizedBox(value: .02),
              //licensesWidget(context),
              //const CustomDivider(),
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

  Row licensesWidget(context) {
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
            CustomNetworkImage(
              imagePath: driverModel.image,
              boxFit: BoxFit.fill,
              width: screenSize(context).width * .2,
              height: 100,
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
            CustomNetworkImage(
              imagePath: driverModel.image,
              boxFit: BoxFit.fill,
              width: screenSize(context).width * .2,
              height: 100,
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
            CustomNetworkImage(
              imagePath: driverModel.image,
              boxFit: BoxFit.fill,
              width: screenSize(context).width * .2,
              height: 100,
            ),
          ],
        ),
      ],
    );
  }

  Widget carType(context) {
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
            Container(
              constraints:
                  BoxConstraints(maxWidth: screenSize(context).width * .4),
              child: Text(
                driverModel.vehicle?.model ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor)),
          child: CustomNetworkImage(
              width: screenSize(context).width * .4,
              height: 100,
              boxFit: BoxFit.fitWidth,
              imagePath: checkImage(driverModel.vehicle?.images ?? [])),
        )
      ],
    );
  }

  String checkImage(List<String>? images) {
    if (images == null) {
      return '';
    } else if (images.isEmpty) {
      return '';
    }
    return images.first;
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
                'مقبول',
                driverModel.rating?.cool ?? 0),
            driverEvaluate(
                const Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                'جيد',
                driverModel.rating?.good ?? 0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CustomText(title: '50%', fontSize: 8),
                driverEvaluate(
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    'رائع',
                    driverModel.rating?.fair ?? 0),
                //  CustomText(title: '50 تفاعل', fontSize: 8),
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

  Widget driverEvaluate(Icon icon, String title, int? rating) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        CustomText(
          title: title,
          fontSize: 14,
        ),
        CustomText(
          title: rating.toString(),
          fontSize: 14,
        ),
      ],
    );
  }
}
