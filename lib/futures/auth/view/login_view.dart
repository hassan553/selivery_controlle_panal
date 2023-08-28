import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:selivery_controlle_panal/core/rescourcs/app_colors.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_button.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_sized_box.dart';
import 'package:selivery_controlle_panal/core/widgets/responsive_text.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_image.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              customTextFormField(),
              const CustomSizedBox(value: .01),
              const Align(
                alignment: Alignment.bottomRight,
                child: ResponsiveText(
                  text: 'كلمة المرور',
                  scaleFactor: .06,
                  color: AppColors.white,
                ),
              ),
              customTextFormField(),
              const CustomSizedBox(value: .04),
              CustomButton(
                function: () => navigateTo(context, MainView()),
                title: 'دخول',
                fontSize: 25,
                color: AppColors.black,
              )
            ]),
          ),
        ),
      ),
    );
  }

  SizedBox customTextFormField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: AppColors.primaryColor,
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
