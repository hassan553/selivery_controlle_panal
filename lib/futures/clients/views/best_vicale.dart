import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/clients/model/vehicle_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../controller/clients_controller.dart';

class BestVicale extends StatefulWidget {
  const BestVicale({super.key});

  @override
  State<BestVicale> createState() => _BestVicaleState();
}

class _BestVicaleState extends State<BestVicale> {
  final clientController = Get.find<ClientController>();
  @override
  void initState() {
    super.initState();
    clientController.getTopVehiclesData();
  }

  @override
  Widget build(BuildContext context) {
    List titles = [
      'إسم السيارة \n Jeep cherokee 2017',
      'إسم الدراجة النارية \n TVS sport 2018',
    ];
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
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
                    title: 'المركبات',
                    imagePath: 'assets/Car.png',
                  ),
                ),
              ],
            ),
            const CustomSizedBox(value: .02),
            Expanded(
              child: Obx(() {
                return clientController.vehicleList.isEmpty
                    ? ErrorComponant(
                        function: clientController.getTopVehiclesData,
                        message: clientController.vehiclesDataError.value)
                    : ListView.builder(
                        itemBuilder: (context, index) => bestClientWidget(
                            context,
                            index,
                            titles[index],
                            clientController.vehicleList[index]),
                        itemCount: clientController.vehicleList.length,
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Column bestClientWidget(
      BuildContext context, int index, String title, VehicleModel model) {
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
              text: 'رقم ${index + 1}',
              scaleFactor: .06,
              color: AppColors.black,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
            height: screenSize(context).height * .2,
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffD9D9D9),
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
                              text: model.model ?? '',
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: screenSize(context).width * .4,
                              child: const Divider(
                                thickness: 2,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const ResponsiveText(
                              text: 'رقم المالك',
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            const ResponsiveText(
                              text: ' 01115690652',
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: screenSize(context).width * .2,
                              child: const Divider(
                                thickness: 2,
                                color: AppColors.primaryColor,
                              ),
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
                    model.images?[0] ?? '',
                    width: p1.maxWidth * .4,
                    height: p1.maxHeight,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
