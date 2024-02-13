import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../../../core/widgets/error_compant.dart';
import '../controller/clients_controller.dart';
import '../model/passengers_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class BestClients extends StatefulWidget {
  const BestClients({super.key});

  @override
  State<BestClients> createState() => _BestClientsState();
}

class _BestClientsState extends State<BestClients> {
  final clientController = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    List titles = [
      'الأكثر طلبا ل Selivery هذا الشهر :-',
      'الأكثر تأجيرا من Selivery هذا الشهر :-',
      'الأكثر شراءاً من Selivery هذا السنة :-',
    ];
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return clientController.getTopPassengersData();
        },
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const CustomSizedBox(value: .02),
              const CustomColumnDivider(
                title: 'العملاء',
                imagePath: 'assets/Businessman.png',
              ),
              const CustomSizedBox(value: .02),
              Expanded(
                child: Obx(() {
                  return clientController.isLoading.value == true
                      ? const CustomLoadingWidget()
                      : clientController.passengerList.isEmpty
                          ? ErrorComponent(
                              function: clientController.getTopPassengersData,
                              message:
                                  clientController.passengersDataError.value)
                          : ListView.builder(
                              itemBuilder: (context, index) => bestClientWidget(
                                  context,
                                  titles[index],
                                  clientController.passengerList[index]),
                              itemCount: clientController.passengerList.length,
                            );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column bestClientWidget(
      BuildContext context, String title, PassengerModel model) {
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
              text: title,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ResponsiveText(
                            text: 'الاسم : ${model.passenger ?? ""}',
                            scaleFactor: .05,
                            color: AppColors.black,
                          ),
                          ResponsiveText(
                            text: 'رقم الموبايل\n ${model.phone ?? ""}',
                            scaleFactor: .05,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: CustomNetworkImage(
                      imagePath: model.image,
                      width: p1.maxWidth * .4,
                      height: p1.maxHeight,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
