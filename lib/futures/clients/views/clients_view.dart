import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/clients/controller/clients_controller.dart';
import 'package:selivery_controlle_panal/futures/clients/views/best_client.dart';
import 'package:selivery_controlle_panal/futures/clients/views/best_vicale.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../home/controller/home_controller.dart';

class ClientsView extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final ClientController controller = Get.put(ClientController());
  ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .02),
              const SizedBox(
                height: 80,
                child: CustomColumnDivider(
                  title: 'العملاء',
                  imagePath: 'assets/Driving.png',
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
                          padding: EdgeInsets.only(bottom: 8),
                          child:
                              CustomAssetsImage(path: 'assets/Businessman.png'),
                        ),
                        const SizedBox(width: 5),
                        const ResponsiveText(
                          text: 'عدد العملاء',
                          scaleFactor: .06,
                          color: AppColors.black,
                        ),
                        const Spacer(),
                        Obx(
                          () => ResponsiveText(
                            text: homeController.homeModel.value.usersNo
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveText(
                    text: ' تفضيلات البحث',
                    scaleFactor: .06,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.search_sharp),
                ],
              ),
              const CustomSizedBox(value: .02),
              InkWell(
                onTap: () => navigateTo(context, const BestClients()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.modulate,
                        ),
                        child: CustomAssetsImage(
                          path: 'assets/Rectangle 252.png',
                          width: screenSize(context).width,
                          height: screenSize(context).height * .15,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetsImage(
                            path: 'assets/Natural User Interface 5.png',
                            // width: screenSize(context).width,
                            //height: screenSize(context).height * .2,
                            boxFit: BoxFit.fill,
                          ),
                          SizedBox(width: 5),
                          ResponsiveText(
                            text: 'أكثر العملاء',
                            scaleFactor: .06,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const CustomSizedBox(value: .015),
              InkWell(
                onTap: () => navigateTo(context, const BestVicale()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.modulate,
                        ),
                        child: CustomAssetsImage(
                          path: 'assets/Rectangle 253 (1).png',
                          width: screenSize(context).width,
                          height: screenSize(context).height * .15,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetsImage(
                            path: 'assets/Natural User Interface 5.png',
                            // width: screenSize(context).width,
                            //height: screenSize(context).height * .2,
                            boxFit: BoxFit.fill,
                          ),
                          SizedBox(width: 5),
                          ResponsiveText(
                            text: 'أكثر المركبات طلباً في Selivery',
                            scaleFactor: .06,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
