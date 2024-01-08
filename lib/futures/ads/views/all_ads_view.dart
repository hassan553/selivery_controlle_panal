import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_column_divider.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_loading_widget.dart';
import 'package:selivery_controlle_panal/futures/ads/controller/all_ads_controller.dart';
import 'package:selivery_controlle_panal/futures/ads/model/ads_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../../main.dart';
import '../widget/web_view_widget.dart';

class AllAdsView extends StatefulWidget {
  const AllAdsView({super.key});

  @override
  State<AllAdsView> createState() => _AllAdsViewState();
}

class _AllAdsViewState extends State<AllAdsView> {
  final controller = Get.find<AllAdsController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllAdsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getAllAdsData();
        },
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .01),
              const CustomColumnDivider(title: 'الإعلانات'),
              const CustomSizedBox(value: .02),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value == true
                      ? const CustomLoadingWidget()
                      : controller.allAdsList.isEmpty
                          ? ErrorComponent(
                              function: controller.getAllAdsData,
                              message: controller.allAdsDataError.value)
                          : ListView.builder(
                              itemBuilder: (context, index) => customAdsWidget(
                                  context, index, controller.allAdsList[index]),
                              itemCount: controller.allAdsList.length,
                            ),
                ),
              ),
              const CustomSizedBox(value: .02),
            ],
          ),
        ),
      ),
    );
  }

  Column customAdsWidget(BuildContext context, int index, AdsModel model) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              color: AppColors.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ResponsiveText(
              text: '# الإعلان ${index + 1} ',
              scaleFactor: .04,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // YouTubePlayerWidget(videoId: model.link!),
        Align(alignment: Alignment.centerRight, child: Text(model.name ?? '')),
        const SizedBox(height: 8),
        // YouTubePlayerWidget(videoId: model.link!),
        Align(
            alignment: Alignment.centerRight,
            child: Text(model.description ?? '')),
        const SizedBox(height: 8),
        SizedBox(
          width: screenSize(context).width,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomNetworkImage(
                  imagePath: model.image,
                  boxFit: BoxFit.fitWidth,
                  width: screenSize(context).width,
                  height: 120,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return WebPage(link: model.link ?? '');
                  }));
                },
                child: Card(
                  elevation: 10,
                  semanticContainer: true,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 80,
                      child: Image.asset(
                        'assets/Screenshot 2023-11-05 224007.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const CustomSizedBox(value: .02),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomAssetsImage(
                          width: 20,
                          path: 'assets/Natural User Interface 5.png'),
                      ResponsiveText(
                        text: 'عدد النقرات :${model.views} ',
                        scaleFactor: .03,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              height: 50,
              width: 1,
              color: Colors.black,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.deleteAds(model.id);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.red,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: const FittedBox(
                    child: Row(
                      children: [
                        ResponsiveText(
                          text: 'حذف الإعلان ',
                          scaleFactor: .03,
                          color: AppColors.white,
                        ),
                        Icon(
                          Icons.delete,
                          color: AppColors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),


      ],
    );
  }
}
