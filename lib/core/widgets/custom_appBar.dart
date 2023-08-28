import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/futures/search/view/search_view.dart';
import '../functions/global_function.dart';
import '../rescourcs/app_colors.dart';

PreferredSize customAppBar(context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(150),
    child: InkWell(
      onTap: () => navigateTo(context, SearchView()),
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
              child: const TextField(
                decoration: InputDecoration(
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
  );
}
