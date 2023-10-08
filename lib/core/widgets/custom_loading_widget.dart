import 'package:flutter/material.dart';

import '../rescourcs/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Color? color;
  const CustomLoadingWidget({super.key,this.color=AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}
