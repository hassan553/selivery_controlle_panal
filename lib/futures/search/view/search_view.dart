import 'package:flutter/material.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          width: screenSize(context).width,
          height: screenSize(context).height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                AppColors.white,
                AppColors.white.withOpacity(.5),
                AppColors.primaryColor.withOpacity(.1),
                AppColors.primaryColor,
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomSizedBox(value: .03),
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
              const Spacer(),
              searchResultWidget(context),
              Align(
                alignment: Alignment.center,
                child: CustomAssetsImage(
                  path: 'assets/Untitled-1 2.png',
                  width: screenSize(context).width,
                  boxFit: BoxFit.fill,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  searchResultWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: screenSize(context).width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffD9D9D9),
      ),
      child: LayoutBuilder(
        builder: (p0, p1) => Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ResponsiveText(
                        text: 'الاسم : Mahmoud Ahmed',
                        scaleFactor: 0.06,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Divider(
                          thickness: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const ResponsiveText(
                        text: 'رقم الموبيل',
                        scaleFactor: 0.06,
                        color: AppColors.black,
                      ),
                      const ResponsiveText(
                        text: '01115690652',
                        scaleFactor: 0.06,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Divider(
                          thickness: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const ResponsiveText(
                        text: ' المهنة : عميل',
                        scaleFactor: 0.06,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Divider(
                          thickness: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor,
                            ),
                            child: const ResponsiveText(
                              text: 'تفصيل',
                              scaleFactor: 0.06,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.red,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                ResponsiveText(
                                  text: 'حذف',
                                  scaleFactor: 0.06,
                                  color: AppColors.white,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            CustomAssetsImage(
              boxFit: BoxFit.fill,
              height: p1.maxHeight,
              width: p1.maxWidth * .5,
              path: 'assets/Rectangle 253.png',
            ),
          ],
        ),
      ),
    );
  }
}
