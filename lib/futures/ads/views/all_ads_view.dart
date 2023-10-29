import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_column_divider.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';
import 'package:selivery_controlle_panal/futures/ads/controller/all_ads_controller.dart';
import 'package:selivery_controlle_panal/futures/ads/model/ads_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';

class AllAdsView extends StatefulWidget {
  AllAdsView({super.key});

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
      appBar: customAppBarForSearch(context, ''),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSizedBox(value: .01),
            const CustomColumnDivider(title: 'الإعلانات'),
            const CustomSizedBox(value: .02),
            Expanded(
              child: Obx(
                () => controller.allAdsList.isEmpty
                    ? ErrorComponant(
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
        const SizedBox(height: 5),
        YouTubePlayerWidget(videoId: model.link!),
        // Image.network(
        //   '$baseUri${model.image}',
        //   width: screenSize(context).width,
        //   height: screenSize(context).height * .3,
        //   fit: BoxFit.fill,
        //   errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        // ),
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

class YouTubePlayerWidget extends StatefulWidget {
  final String videoId;

  const YouTubePlayerWidget({super.key, required this.videoId});

  @override
  _YouTubePlayerWidgetState createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  YoutubePlayerController? _controller;

  String? errorMessage;
  initAds() {
    try {
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'حدث خطأ أثناء تشغيل الفيديو.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initAds();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return errorMessage != null
        ? Center(
            child: Text(
              errorMessage!,
              style: const TextStyle(fontSize: 16),
            ),
          )
        : YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller!,
            ),
            builder: (context, player) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: player,
              );
            },
          );
  }
}
