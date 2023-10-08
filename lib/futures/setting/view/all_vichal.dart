import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import 'package:selivery_controlle_panal/futures/setting/controller/setting_controller.dart';
import 'package:selivery_controlle_panal/futures/setting/model/category_model.dart';

import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class AllVicale extends StatefulWidget {
  const AllVicale({super.key});

  @override
  State<AllVicale> createState() => _AllVicaleState();
}

class _AllVicaleState extends State<AllVicale> {
  final CategoryController categoryController = Get.find<CategoryController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
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
              )),
            ],
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: categoryController.categoryList.length,
              itemBuilder: (context, index) {
                print(categoryController.categoryList[index].image);
                return customVicalWidget(
                    context, categoryController.categoryList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container customVicalWidget(BuildContext context, CategoryModel model) {
    print("$baseUri${model.image}");
    return Container(
      width: screenSize(context).width,
      height: screenSize(context).height * .3,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffD9D9D9),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 3),
            Image.network(
              "http://192.168.1.122:8000/images/2023-09-02T15-26-50.951Zimage3.png",
              fit: BoxFit.cover,
            ),
            const Divider(color: AppColors.black),
            FittedBox(
              child: ResponsiveText(
                text: 'النوع:${model.name}',
                scaleFactor: .04,
                color: AppColors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: const FittedBox(
                    child: ResponsiveText(
                      text: 'تعديل ',
                      scaleFactor: .04,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.red,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: const FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ResponsiveText(
                          text: 'حذف ',
                          scaleFactor: .04,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.delete,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
