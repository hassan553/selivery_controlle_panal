import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../controller/setting_controller.dart';

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({Key? key}) : super(key: key);

  @override
  _AddVehicleViewState createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  String selectedValue = 'سياره'; // Initial selected value

  List<String> dropdownItems = ['سياره', 'توكتوك', 'متوسكل', 'دراجه'];
  final CategoryController settingController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomSizedBox(value: 0.02),
                Row(
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
                        title: 'إضافة مركبة',
                        imagePath: 'assets/Car.png',
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(value: 0.1),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        const FittedBox(
                          child: ResponsiveText(
                            text: 'نوع المركبة',
                            scaleFactor: 0.05,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(width: 55),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                             controller: settingController.titleController,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: AppColors.primaryColor,
                              validator: (value) {
                                if (value == null) {
                                  return 'not valid empty value';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                fillColor: AppColors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                      //     Container(
                      //       width: screenSize(context).width * 0.6,
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15),
                      //         border: Border.all(color: AppColors.primaryColor),
                      //       ),
                      //       alignment: Alignment.centerLeft,
                      //       child: Row(
                      //         children: [
                      //           const Icon(
                      //             Icons.arrow_circle_down_sharp,
                      //             color: AppColors.primaryColor,
                      //           ),
                      //           const Spacer(),
                      //           DropdownButton<String>(
                      //             value: selectedValue,
                      //             onChanged: (String? newValue) {
                      //               setState(() {
                      //                 selectedValue = newValue!;
                      //               });
                      //             },
                      //             items: dropdownItems
                      //                 .map<DropdownMenuItem<String>>(
                      //                     (String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: ResponsiveText(
                      //                   text: value,
                      //                   scaleFactor: 0.04,
                      //                   color: AppColors.black,
                      //                 ),
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: screenSize(context).height * 0.01),
                      customAddCategoryImageForm(context),
                      SizedBox(height: screenSize(context).height * 0.02),
                      addButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  customAddCategoryImageForm(context) {
    return InkWell(
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
          const Spacer(),
          GetBuilder<CategoryController>(
            builder: (controller) {
              return Container(
                width: screenSize(context).width * .6,
                height: screenSize(context).height * .12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: controller.categoryImage == null
                    ? CustomAssetsImage(path: 'assets/Add Image.png')
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
    );
  }

  Widget addButton(BuildContext context) {
    return InkWell(
      onTap: () {
        settingController.postDataWithFile(
            {'name': settingController.titleController.text},
            settingController.categoryImage);
      },
      child: Obx(
        ()=>settingController.addLoading.value?const CustomLoadingWidget(): Container(
          width: screenSize(context).width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: const FittedBox(
            child: ResponsiveText(
              text: 'إضافة',
              scaleFactor: 0.04,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
