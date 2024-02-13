import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../model/category_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/responsive_text.dart';
import '../controller/setting_controller.dart';

class CustomDialog extends StatefulWidget {
  final CategoryModel? categoryModel;
  const CustomDialog({super.key, this.categoryModel});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final settingController = Get.find<CategoryController>();
  final titleController = TextEditingController();
  final commissionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    commissionController.dispose();
    settingController.categoryImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.categoryModel?.name ?? '';
    commissionController.text =
        widget.categoryModel?.commission.toString() ?? '0';
    return Dialog(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'تعديل القسم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'الاسم القسم',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: commissionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "العموله",
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                settingController.pickImage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FittedBox(
                    child: ResponsiveText(
                      text: 'إضافة صورة',
                      scaleFactor: .05,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GetBuilder<CategoryController>(
                    builder: (controller) {
                      return Container(
                        width: screenSize(context).width * .4,
                        height: screenSize(context).height * .12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: controller.categoryImage == null
                            ? CustomNetworkImage(
                                imagePath: widget.categoryModel?.image ?? '',
                                boxFit: BoxFit.fill)
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  controller.categoryImage!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: AppColors.primaryColor,
                  onPressed: () {
                    
                    settingController.updateDataWithFile(
                        widget.categoryModel?.sId ?? '',
                        {
                          'name': titleController.text,
                          'commission': commissionController.text
                        },
                        settingController.categoryImage);
                  },
                  child: const Text('تعديل'),
                ),
                const SizedBox(width: 30),
                MaterialButton(
                  color: AppColors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('الغاء'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
