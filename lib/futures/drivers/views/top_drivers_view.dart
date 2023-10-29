import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/drivers_controller.dart';
import 'package:selivery_controlle_panal/futures/drivers/views/all_drivers_view.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../home/controller/home_controller.dart';
import '../widgets/driver_widget.dart';

class TopDriversView extends StatefulWidget {
  const TopDriversView({super.key});

  @override
  State<TopDriversView> createState() => _DriversViewState();
}

class _DriversViewState extends State<TopDriversView> {
  final homeController = Get.find<HomeController>();
  DriversController driversController = Get.put(DriversController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //driversController.getTopDriversData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSizedBox(value: .02),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => navigateTo(context, AllDriversView()),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.people,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: CustomColumnDivider(
                      title: 'السائقين',
                      imagePath: 'assets/Driving.png',
                    ),
                  ),
                ],
              ),
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
                      const Padding(
                        padding:  EdgeInsets.only(bottom: 8),
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
                          text: homeController.homeModel.value.driversNo
                              .toString(),
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
                () => driversController.bestDriversList.isEmpty
                    ? ErrorComponant(
                        function: driversController.getTopDriversData,
                        message: driversController.error.value)
                    : ListView.builder(
                        itemBuilder: (context, index) => bestDriverWidget(
                            context,
                            index,
                            driversController.bestDriversList[index]),
                        itemCount: driversController.bestDriversList.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
