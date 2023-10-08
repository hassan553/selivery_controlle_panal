import 'dart:convert';
import 'dart:io';
import 'package:selivery_controlle_panal/core/widgets/image_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/contants/api.dart';

class AdsController extends GetxController {
  String title = '', link = '', description = '';
  File? adsImage;

  Future pickImage() async {
    try {
      adsImage = await PickImage().pickImage();
      if (adsImage != null) {
        print('image path ${adsImage!.path}');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  postDataWithFile() async {
    try {
      var headers = {
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
        "Content-Type": 'multipart/form-data',
      };

      var request = http.MultipartRequest("POST", addAdsUri);
      request.headers.addAll(headers);
      var fileExtension = adsImage!.path;

      var length = await adsImage!.length();
      var stream = http.ByteStream(adsImage!.openRead());

      var multipartFile =
          http.MultipartFile("image", stream, length, filename: adsImage!.path);
      request.files.add(multipartFile);
      final Map data = {'name': title, 'description': description};
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("tm");
        print(response.body);
        Map responsebody = jsonDecode(response.body);
        print(response.body);
        print('success upload image');
      } else {
        print(response.body);
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
