import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/get_driverLicense_controller.dart';
import 'package:selivery_controlle_panal/futures/drivers/model/driver_license_model.dart';
import 'package:selivery_controlle_panal/futures/drivers/views/image_details.dart';
import '../../../core/contants/api.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';

class DriversLicenseView extends StatelessWidget {
  final controller = Get.put(GetDriverLicenseController());
  DriversLicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () {
          return controller.getAllLicenseData();
        },
        child: Column(
          children: [
            SizedBox(height: screenSize(context).height * .02),
            const CustomColumnDivider(
              title: 'رخص السائقين',
              imagePath: 'assets/Identification Documents.png',
            ),
            SizedBox(height: screenSize(context).height * .03),
            Expanded(
              child: Obx(() {
                return controller.isLoading.value == true
                    ? const CustomLoadingWidget()
                    : controller.allLicenseList.isEmpty
                        ? ErrorComponent(
                            function: controller.getAllLicenseData,
                            message: controller.allLicenseDataError.value)
                        : ListView.builder(
                            itemBuilder: (context, index) => licenseWidget(
                                context, controller.allLicenseList[index]),
                            itemCount: controller.allLicenseList.length,
                          );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Column licenseWidget(BuildContext context, DriverLicenseModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                children: [
                                  ResponsiveText(
                                    text:
                                        'إسم السائق :  ${model.driverData!.isEmpty ? '' : model.driverData?[0].name ?? ''}',
                                    scaleFactor: .06,
                                    color: AppColors.black,
                                  ),
                                  const ResponsiveText(
                                    text: 'رقم الموبايل ',
                                    scaleFactor: .06,
                                    color: AppColors.black,
                                  ),
                                  ResponsiveText(
                                    text: model.driverData!.isEmpty
                                        ? ''
                                        : model.driverData?[0].name ?? '',
                                    scaleFactor: .06,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        CustomNetworkImage(
                          imagePath: checkImage(model.driverData),
                          width: p1.maxWidth * .4,
                          height: p1.maxHeight,
                          boxFit: BoxFit.fill,
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
                          InkWell(
                            onTap: () => navigateTo(
                                context,
                                ImageDetails(
                                    imagePath: model.driverLicense ?? '')),
                            child: CustomNetworkImage(
                              imagePath: model.driverLicense,
                              boxFit: BoxFit.fill,
                              width: screenSize(context).width * .2,
                              height: 100,
                            ),
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
                          InkWell(
                            onTap: () => navigateTo(
                                context,
                                ImageDetails(
                                    imagePath: model.vehicleLicense ?? '')),
                            child: CustomNetworkImage(
                              imagePath: model.vehicleLicense,
                              boxFit: BoxFit.fill,
                              width: screenSize(context).width * .2,
                              height: 100,
                            ),
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
                          InkWell(
                            onTap: () => navigateTo(
                                context,
                                ImageDetails(
                                    imagePath: model.nationalId ?? '')),
                            child: CustomNetworkImage(
                              imagePath: model.nationalId,
                              boxFit: BoxFit.fill,
                              width: screenSize(context).width * .2,
                              height: 100,
                            ),
                          ),
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
            GetBuilder<GetDriverLicenseController>(
              builder: (controller) => controller.approveLoading
                  ? const CustomLoadingWidget()
                  : InkWell(
                      onTap: () => controller.approveDriver(model.sId ?? ''),
                      child: Container(
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
                    ),
            ),
            const SizedBox(width: 20),
            GetBuilder<GetDriverLicenseController>(
              builder: (controller) => controller.rejectLoading
                  ? const CustomLoadingWidget()
                  : InkWell(
                      onTap: () => controller.rejectDriver(model.sId ?? ''),
                      child: Container(
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
                    ),
            ),
          ],
        ),
      ],
    );
  }

  String checkImage(List<DriverData>? images) {
    if (images == null) {
      return '';
    } else if (images.isEmpty) {
      return '';
    }
    return images.first.image ?? '';
  }
}
