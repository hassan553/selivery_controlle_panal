import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../ads/views/ads_view.dart';
import '../../clients/views/clients_view.dart';
import '../../drivers/views/top_drivers_view.dart';
import '../controller/home_controller.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
          body: screens[controller.currentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primaryColor,
              currentIndex: controller.currentIndex,
              onTap: (index) => controller.changeBottomNavIndex(index),
              selectedItemColor: AppColors.black,
              unselectedItemColor: CupertinoColors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "الرئيسية",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.campaign),
                  label: "الإعلانات",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "العملاء",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.airline_seat_recline_extra),
                  label: "السائقين",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> screens = [
    HomeView(),
    AdsView(),
    ClientsView(),
    const TopDriversView(),
  ];
}
