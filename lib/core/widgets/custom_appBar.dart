import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/drivers/controller/drivers_controller.dart';
import '../functions/global_function.dart';
import '../rescourcs/app_colors.dart';

final controller = Get.find<DriversController>();
PreferredSize customAppBarForSearch(context, String value) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(150),
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: SafeArea(
        child: Container(
          width: screenSize(context).width,
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              Container(
                height: 40,
                width: screenSize(context).width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onChanged: (newValue) {
                    controller.searchText.value = newValue;
                  },
                  decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppColors.white,
                        size: 25,
                      ),
                      contentPadding: EdgeInsets.only(right: 20),
                      hintText: 'ابحث',
                      hintStyle: TextStyle(color: AppColors.white),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none),
                ),
              ),
              Image.asset(
                'assets/Untitled-1 2.png',
                height: 80,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

PreferredSize customAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(70),
    child: SafeArea(
      child: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/Untitled-1 2.png',
                height: 70,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
