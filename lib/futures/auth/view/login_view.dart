import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:selivery_controlle_panal/core/rescourcs/app_colors.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_button.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_sized_box.dart';
import 'package:selivery_controlle_panal/core/widgets/responsive_text.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_image.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSizedBox(value: .04),
                      const ResponsiveText(
                        text: 'Admin',
                        scaleFactor: .09,
                        color: AppColors.white,
                      ),
                      CustomAssetsImage(
                        path: 'assets/Admin Settings Male.png',
                        width: screenSize(context).width * .6,
                        boxFit: BoxFit.fill,
                      ),
                      const CustomSizedBox(value: .02),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: ResponsiveText(
                          text: 'البريد الإلكتروني',
                          scaleFactor: .06,
                          color: AppColors.white,
                        ),
                      ),
                      customTextFormField(controller.email, (String? value) {
                        if (value == null) {
                          return 'not valid empty value';
                        } else if (!value.contains('@')) {
                          return 'enter valid email';
                        }
                        return null;
                      }, context),
                      const CustomSizedBox(value: .01),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: ResponsiveText(
                          text: 'كلمة المرور',
                          scaleFactor: .06,
                          color: AppColors.white,
                        ),
                      ),
                      customTextFormField(controller.password, (String? value) {
                        if (value == null) {
                          return 'not valid empty password';
                        } else if (value.length < 6) {
                          return 'short Password';
                        }
                        return null;
                      }, context),
                      const CustomSizedBox(value: .04),
                      Obx(
                        () => controller.isLoading.value
                            ? const CustomLoadingWidget(
                                color: Colors.white,
                              )
                            : CustomButton(
                                function: () {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    controller.login(context);
                                  }
                                },
                                title: 'دخول',
                                fontSize: 25,
                                color: AppColors.black),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox customTextFormField(TextEditingController controller,
      String? Function(String?)? validator, BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        autovalidateMode: AutovalidateMode.always,
        cursorColor: AppColors.primaryColor,
        controller: controller,
        validator: validator,
        onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
