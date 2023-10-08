import 'package:flutter/material.dart';
import 'package:get/get.dart';

Size screenSize(context) {
  return MediaQuery.of(context).size;
}

navigateOff(BuildContext context,Widget screen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>screen));
}
navigatorOff(Widget screen) {
  Get.off(()=>screen);
}

navigateTo(BuildContext context,Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>screen));
}

pop(BuildContext context) {
  Navigator.of(context).pop();
}
