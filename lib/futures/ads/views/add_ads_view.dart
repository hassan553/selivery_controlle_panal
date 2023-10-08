import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/futures/ads/controller/ads_controller.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class AddAdsView extends StatelessWidget {
  final AdsController controller = Get.put(AdsController());
  final formKey = GlobalKey<FormState>();
  AddAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
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
                        child: CustomColumnDivider(title: 'إضافة إعلان جديد')),
                  ],
                ),
                const CustomSizedBox(value: .02),
                customForm(context, 'إسم الإعلان', 40, controller.title),
                const CustomSizedBox(value: .02),
                customForm(context, 'لينك الإعلان', 40, controller.link),
                const CustomSizedBox(value: .02),
                customForm(
                    context, 'تفاصيل الإعلان', 100, controller.description),
                const CustomSizedBox(value: .02),
                customAddImageFormFiled(context),
                const CustomSizedBox(value: .05),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate() &&
                        controller.adsImage != null) {
                      controller.postDataWithFile();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: const ResponsiveText(
                      text: 'إضافة ',
                      scaleFactor: .04,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
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
                  ? CustomAssetsImage(path: 'assets/Add Image.png')
                  : Image.file(controller.adsImage!),
            ),
          ),
        ],
      ),
    );
  }

  Row customForm(
      BuildContext context, String title, double maxLine, String? newValue) {
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
          height: maxLine,
          width: screenSize(context).width * .6,
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return 'Not Valid Empty Value';
              } else if (value.isEmpty) {
                return 'Not Valid Empty Value';
              }
              return null;
            },
            onChanged: (value) {
              newValue = value;
            },
            maxLines: 4,
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
