import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:selivery_controlle_panal/core/functions/internet_checker.dart';
import 'package:selivery_controlle_panal/core/widgets/image_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/widgets/snack_bar_widget.dart';

import '../../../core/contants/api.dart';
import '../../../core/widgets/show_awesomeDialog.dart';

class AdsController extends GetxController {
  final titleController = TextEditingController();
  final youtubeLinkController = TextEditingController();
  final descriptionController = TextEditingController();
  var isLoading = false.obs;
  var adsError = ''.obs;
  File? adsImage;

  Future pickImage() async {
    try {
      adsImage = await PickImage().pickImage();
      update();
    } catch (error) {}
  }

  postDataWithFile() async {
    if (await checkInternet()) {
      try {
        isLoading.value = true;
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

        var multipartFile = http.MultipartFile("image", stream, length,
            filename: adsImage!.path);
        request.files.add(multipartFile);
        final Map data = {
          'name': titleController.text,
          'description': descriptionController.text,
          'youtubelink': youtubeLinkController.text.trim()
        };
        data.forEach((key, value) {
          request.fields[key] = value;
        });

        var myrequest = await request.send();

        var response = await http.Response.fromStream(myrequest);
        Map responsebody = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("tm");
          print(response.body);
          clearData();
          isLoading.value = false;
          showDialogWithGetX(responsebody['message']);
        } else {
          print(response.body);
          showDialogWithGetX(responsebody['message']);

          isLoading.value = false;
        }
      } catch (error) {
        print(error.toString());
        isLoading.value = false;
        showDialogWithGetX(error.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
  }

  clearData() {
    titleController.clear();
    descriptionController.clear();
    youtubeLinkController.clear();
    adsImage = null;
    update();
  }

  disposeControllers() {
    titleController.dispose();
    descriptionController.dispose();
    youtubeLinkController.dispose();
    adsImage = null;
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
