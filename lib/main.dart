import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/services/cache_storage_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:flutter/services.dart';
import 'core/errors/widget_error.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  setupOrientation();
  customErrorWidget();
  runApp(const SeliveryControl());
}

setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
