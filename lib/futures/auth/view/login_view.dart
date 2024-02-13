import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_image.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    customTextFormField(
                        loginController.email,
                        (String? value) {
                          if (value == null) {
                            return 'not valid empty value';
                          } else if (!value.contains('@')) {
                            return 'enter valid email';
                          }
                          return null;
                        },
                        context,
                        loginController.emailFocus,
                        false,
                        (value) {
                          FocusScope.of(context)
                              .requestFocus(loginController.passwordFocus);
                        }),
                    const CustomSizedBox(value: .01),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: ResponsiveText(
                        text: 'كلمة المرور',
                        scaleFactor: .06,
                        color: AppColors.white,
                      ),
                    ),
                    customTextFormField(
                        loginController.password,
                        (String? value) {
                          if (value == null) {
                            return 'not valid empty password';
                          } else if (value.length < 6) {
                            return 'short Password';
                          }
                          return null;
                        },
                        context,
                        loginController.passwordFocus,
                        true,
                        (value) {
                          if (formKey.currentState!.validate()) {
                            loginController.login(context);
                          }
                        }),
                    const CustomSizedBox(value: .04),
                    Obx(
                      () => loginController.isLoading.value
                          ? const CustomLoadingWidget(
                              color: Colors.white,
                            )
                          : CustomButton(
                              function: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  loginController.login(context);
                                  
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
    );
  }

  SizedBox customTextFormField(
      TextEditingController controller,
      String? Function(String?)? validator,
      BuildContext context,
      FocusNode focusNode,
      bool obscure,
      void Function(String)? onsubmit) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColors.primaryColor,
        controller: controller,
        obscureText: obscure,
        validator: validator,
        focusNode: focusNode,
        onFieldSubmitted: onsubmit,
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
