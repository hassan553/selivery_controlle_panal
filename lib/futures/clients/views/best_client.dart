import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/error_compant.dart';
import 'package:selivery_controlle_panal/futures/clients/controller/clients_controller.dart';
import 'package:selivery_controlle_panal/futures/clients/model/passengers_model.dart';
import '../../../core/contants/api.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_column_divider.dart';
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
      appBar: customAppBarForSearch(context,''),
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
                    title: 'العملاء',
                    imagePath: 'assets/Businessman.png',
                  ),
                ),
              ],
            ),
            const CustomSizedBox(value: .02),
            Expanded(
              child: Obx(() {
                return clientController.passengerList.isEmpty
                    ? ErrorComponant(
                        function: clientController.getTopPassengersData,
                        message: clientController.passengersDataError.value)
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
                  Image.network(
                    '$baseUri${model.image}',
                    width: p1.maxWidth * .4,
                    height: p1.maxHeight,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  )
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
