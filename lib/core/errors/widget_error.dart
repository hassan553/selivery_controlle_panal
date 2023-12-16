import 'package:flutter/material.dart';

customErrorWidget() {
  ErrorWidget.builder(FlutterErrorDetails(exception: (error) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
