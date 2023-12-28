import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_appBar.dart';
import 'package:selivery_controlle_panal/core/widgets/custom_image.dart';

class ImageDetails extends StatelessWidget {
  final String imagePath;
  const ImageDetails({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomNetworkImage(
            boxFit: BoxFit.fill,
            height: screenSize(context).height / 2,
            imagePath: imagePath,
            width: screenSize(context).width,
          ),
        ),
      ),
    );
  }
}
