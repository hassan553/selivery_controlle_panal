import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/futures/setting/controller/setting_controller.dart';
import 'package:selivery_controlle_panal/futures/setting/model/category_model.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../widget/custom_input_dailog.dart';

class AllVicale extends StatefulWidget {
  const AllVicale({super.key});

  @override
  State<AllVicale> createState() => _AllVicaleState();
}

class _AllVicaleState extends State<AllVicale> {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarForSearch(context, ''),
      body: Column(
        children: [
          const CustomSizedBox(value: .02),
          const SizedBox(
            height: 80,
            child: Expanded(
              child: CustomColumnDivider(
                title: 'المركبات',
                imagePath: 'assets/Car.png',
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => categoryController.categoryList.isEmpty
                  ? ErrorComponant(
                      function: categoryController.getAllCategories,
                      message: categoryController.categoryError.value)
                  : ListView.builder(
                      itemCount: categoryController.categoryList.length,
                      itemBuilder: (context, index) {
                        return customVicalWidget(
                            context, categoryController.categoryList[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Container customVicalWidget(BuildContext context, CategoryModel? model) {
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomNetworkImage(
                    imagePath: "$baseUri${model?.image}",
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Divider(color: AppColors.black),
            FittedBox(
              child: ResponsiveText(
                text: 'النوع:${model?.name}',
                scaleFactor: .04,
                color: AppColors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog();
                      },
                    );
                  },
                  child: Container(
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
                ),
                InkWell(
                  onTap: () => categoryController.deleteCategory(model?.sId),
                  child: Container(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
