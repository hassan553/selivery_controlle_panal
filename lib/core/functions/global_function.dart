import 'package:flutter/material.dart';

Size screenSize(context) {
  return MediaQuery.of(context).size;
}

navigateOff(BuildContext context,Widget screen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>screen));
}

navigateTo(BuildContext context,Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>screen));
}

pop(BuildContext context) {
  Navigator.of(context).pop();
}
