import 'package:flutter/material.dart';
import '../rescourcs/app_colors.dart';

customErrorWidget() {
  ErrorWidget.builder(FlutterErrorDetails(exception: (error) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.red),
              Text(error.toString()),
              const SizedBox(height: 20),
              const Text('يرجاء اعادة المحاوله'),
            ],
          ),
        ),
      ),
    );
  }));
}
