import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';
import 'package:selivery_controlle_panal/futures/setting/view/setting_view.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../drivers/views/drivers_license_view.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () {
              return homeController.getHomeData();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSizedBox(value: .02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            print(CacheStorageServices().token);
                            navigateTo(context, const SettingView());
                          },
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
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const ResponsiveText(
                              text: 'معلومات التطبيق',
                              scaleFactor: .05,
                              color: AppColors.black,
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
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(value: .02),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomAssetsImage(path: 'assets/Europe.png'),
                        SizedBox(width: 4),
                        ResponsiveText(
                          text: 'نظرة عامة علي التطبيق',
                          scaleFactor: .05,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => homeController.isLoading.value
                        ? const Center(
                            child: CustomLoadingWidget(
                            color: AppColors.primaryColor,
                          ))
                        : homeController.error.value.isNotEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ResponsiveText(
                                      text: homeController.error.value,
                                      scaleFactor: .04,
                                      color: AppColors.black,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          homeController.getHomeData(),
                                      child: const ResponsiveText(
                                        text: 'refresh',
                                        scaleFactor: .04,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  bestClientWidget(
                                      context,
                                      'عدد السائقين',
                                      'assets/Driving.png',
                                      homeController.homeModel.value.driversNo),
                                  const CustomSizedBox(value: .01),
                                  bestClientWidget(
                                      context,
                                      'عدد العملاء',
                                      'assets/Businessman.png',
                                      homeController.homeModel.value.usersNo),
                                  const CustomSizedBox(value: .01),
                                  bestClientWidget(
                                      context,
                                      'عدد المركبات الذي تم إضافتها للبيع',
                                      'assets/Car.png',
                                      homeController
                                          .homeModel.value.salesVehiclesNo),
                                  const CustomSizedBox(value: .01),
                                  bestClientWidget(
                                      context,
                                      'عدد المركبات الذي تم إضافتها للإيجار',
                                      'assets/Car.png',
                                      homeController
                                          .homeModel.value.rentVehiclesNo),
                                  const CustomSizedBox(value: .03),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        //homeController.refreshToken();
                                        navigateTo(
                                          context, DriversLicenseView());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primaryColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 5),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ResponsiveText(
                                              text: 'فحص بيانات السائق ',
                                              scaleFactor: .04,
                                              color: AppColors.black,
                                            ),
                                            SizedBox(width: 5),
                                            CustomAssetsImage(
                                                path: 'assets/Driving.png'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox bestClientWidget(
      BuildContext context, String title, String imagePath, int number) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomAssetsImage(path: imagePath),
              ),
              const SizedBox(width: 5),
              ResponsiveText(
                text: title,
                scaleFactor: .05,
                color: AppColors.black,
              ),
              const Spacer(),
              ResponsiveText(
                text: number.toString(),
                scaleFactor: .05,
                color: AppColors.black,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
