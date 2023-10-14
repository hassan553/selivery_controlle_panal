import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/drivers_controller.dart';
import 'package:selivery_controlle_panal/futures/drivers/model/driver_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../home/controller/home_controller.dart';

class DriversView extends StatefulWidget {
  const DriversView({super.key});

  @override
  State<DriversView> createState() => _DriversViewState();
}

class _DriversViewState extends State<DriversView> {
  final homeController = Get.find<HomeController>();
  DriversController driversController = Get.put(DriversController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    driversController.getTopDriversData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: CustomColumnDivider(
                  title: 'السائقين',
                  imagePath: 'assets/Driving.png',
                )),
              ],
            ),
            const CustomSizedBox(value: .01),
            SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Divider(
                    thickness: 1,
                    color: AppColors.primaryColor,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomAssetsImage(path: 'assets/Driving.png'),
                      ),
                      const SizedBox(width: 5),
                      const ResponsiveText(
                        text: 'عدد السائقين',
                        scaleFactor: .06,
                        color: AppColors.black,
                      ),
                      const Spacer(),
                      Obx(
                        () => ResponsiveText(
                          text:
                              homeController.homeModel.value.usersNo.toString(),
                          scaleFactor: .06,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomSizedBox(value: .02),
            Container(
              width: screenSize(context).width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.white,
                        AppColors.primaryColor,
                      ])),
              child: const FittedBox(
                child: ResponsiveText(
                  text: 'أفضل ثلاث سائقين حاصلين علي تقييم رائع هذا الأسبوع',
                  scaleFactor: .06,
                  color: AppColors.black,
                ),
              ),
            ),
            const CustomSizedBox(value: .02),
            Expanded(
              child: Obx(
                () => driversController.driversList.isEmpty
                    ? const Center(
                        child: Text('is Empty'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => bestDriverWidget(
                            context,
                            index,
                            driversController.driversList[index]),
                        itemCount: driversController.driversList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column bestDriverWidget(
      BuildContext context, int index, DriverModel driverModel) {
    return Column(
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
              scaleFactor: .04,
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
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            const ResponsiveText(
                              text: 'رقم الموبيل',
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            ResponsiveText(
                              text: driverModel.phone ?? "",
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.red,
                              ),
                              child: const Row(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.network(
                    '$baseUri${driverModel.image}',
                    width: p1.maxWidth * .4,
                    height: p1.maxHeight,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
