import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../rescourcs/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Color? color;
  const CustomLoadingWidget({super.key, this.color = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    final plateForm = Theme.of(context).platform;
    return Center(
      child: plateForm == TargetPlatform.iOS
          ? CupertinoActivityIndicator(color: color)
          : CircularProgressIndicator(color: color),
    );
  }
}
