import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';
import 'package:selivery_controlle_panal/futures/ads/controller/ads_controller.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class AddAdsView extends StatefulWidget {
  const AddAdsView({super.key});

  @override
  State<AddAdsView> createState() => _AddAdsViewState();
}

class _AddAdsViewState extends State<AddAdsView> {
  final formKey = GlobalKey<FormState>();

  final controller = Get.find<AdsController>();
  @override
  void dispose() {
    controller.isLoading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CustomSizedBox(value: .02),
                  const CustomColumnDivider(title: 'إضافة إعلان جديد'),
                  const CustomSizedBox(value: .02),
                  customForm(
                      context, 'إسم الإعلان', 1, controller.titleController),
                  const CustomSizedBox(value: .02),
                  customForm(context, 'لينك الإعلان', 1,
                      controller.youtubeLinkController),
                  const CustomSizedBox(value: .02),
                  customForm(context, 'تفاصيل الإعلان', 5,
                      controller.descriptionController),
                  const CustomSizedBox(value: .02),
                  customAddImageFormFiled(context),
                  const CustomSizedBox(value: .05),
                  Obx(
                    () => controller.isLoading.value
                        ? const CustomLoadingWidget()
                        : InkWell(
                            onTap: () {
                              //formKey.currentState!.validate()
                              // if (controller.youtubeLinkController.text.isNotEmpty||
                              //     controller.adsImage != null) {
                              controller.postDataWithFile({
                                'name': controller.titleController.text,
                                'description':
                                    controller.descriptionController.text,
                                'youtubeLink':
                                    controller.youtubeLinkController.text.trim()
                              });
                              //}
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              child: const ResponsiveText(
                                text: 'إضافة ',
                                scaleFactor: .04,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customAddImageFormFiled(context) {
    return InkWell(
      onTap: () {
        controller.pickImage();
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
          GetBuilder<AdsController>(
            builder: (controller) => Container(
              width: screenSize(context).width * .6,
              height: screenSize(context).height * .12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: controller.adsImage == null
                  ? const CustomAssetsImage(path: 'assets/Add Image.png')
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        controller.adsImage!,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Row customForm(BuildContext context, String title, int maxLine,
      TextEditingController controller) {
    return Row(
      children: [
        FittedBox(
          child: ResponsiveText(
            text: title,
            scaleFactor: .05,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: screenSize(context).width * .6,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null) {
                return 'Not Valid Empty Value';
              } else if (value.isEmpty) {
                return 'Not Valid Empty Value';
              }
              return null;
            },
            maxLines: maxLine,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
