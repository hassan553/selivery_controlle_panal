import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/drivers_controller.dart';
import '../model/driver_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_text.dart';

class UserInfo extends StatefulWidget {
  final DriverModel? driverModel;
  const UserInfo({super.key, this.driverModel});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    //DriverProfileController controller = Get.find();
    return Container(
      width: screenSize(context).width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<DriversController>(
              builder: (controller) => CustomText(
                title: 'النوع : ذكر',
                fontSize: 16,
              ),
            ),
            GetBuilder<DriversController>(
              builder: (controller) => CustomText(
                title: 'السن : 20',
                fontSize: 16,
              ),
            ),
            GetBuilder<DriversController>(
              builder: (controller) => CustomText(
                title:
                    'رقم الموبايل : ${widget.driverModel?.phone ?? "00000000"} ',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
