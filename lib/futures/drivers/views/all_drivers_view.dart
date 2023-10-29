import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/drivers_controller.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/error_compant.dart';
import '../widgets/driver_widget.dart';
import 'driver_profile_view.dart';

class AllDriversView extends StatefulWidget {
  AllDriversView({super.key});

  @override
  State<AllDriversView> createState() => _AllDriversViewState();
}

class _AllDriversViewState extends State<AllDriversView> {
  final driversController = Get.find<DriversController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //driversController.getAllDriversData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarForSearch(context, driversController.searchText.value),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => driversController.filteredItems.isEmpty
              ? ErrorComponant(
                  function: driversController.getAllDriversData,
                  message: driversController.error.value)
              : ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>navigateTo(context, DriverProfileView(driverModel: driversController.filteredItems[index]!)),
                    child: bestDriverWidget(
                        context, index, driversController.filteredItems[index]!),
                  ),
                  itemCount: driversController.filteredItems.length,
                ),
        ),
      ),
    );
  }
}
