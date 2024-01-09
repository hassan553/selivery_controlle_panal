import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/functions/internet_checker.dart';
import 'package:selivery_controlle_panal/core/widgets/image_picker.dart';
import 'package:selivery_controlle_panal/core/widgets/show_awesomeDialog.dart';
import '../../../core/services/cache_storage_services.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var addLoading = false.obs;
  final titleController = TextEditingController();
  final commissionController = TextEditingController();

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  var categoryError = ''.obs;
  var categoryLoading = false.obs;
  Future<void> getAllCategories() async {
    try {
      categoryLoading.value = true;
      categoryList.value = <CategoryModel>[];
      final response = await http.get(allCategory,
          headers: authHeadersWithToken(CacheStorageServices().token));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        print(result['categories']);
        result['categories'].forEach((json) {
          categoryList.add(CategoryModel.fromJson(json));
        });
        categoryList.isEmpty
            ? categoryError.value = 'لا يوجد بيانات'
            : categoryError.value = '';
        categoryLoading.value = false;
      } else {
        print('error');
        categoryError.value = result['message'];
        categoryLoading.value = false;
      }
    } catch (error) {
      categoryError.value = error.toString();
      print(error.toString());
      categoryLoading.value = false;
    }
  }
  /////////////////upload///////////

  File? categoryImage;

  Future pickImage() async {
    try {
      categoryImage = await PickImage().pickImage();
    } catch (error) {
      showDialogWithGetX(error.toString());
    }
    update();
  }

  postDataWithFile(Map data, File? image) async {
    if (await checkInternet()) {
      try {
        addLoading.value = true;
        var headers = {
          'Accept': 'application/json',
          "Authorization": 'Bearer ${CacheStorageServices().token}',
          "Content-Type": 'multipart/form-data',
        };

        var request = http.MultipartRequest("POST", uploadCategoryUri);
        request.headers.addAll(headers);
        var fileExtension = image!.path;

        var length = await image.length();
        var stream = http.ByteStream(image.openRead());

        var multipartFile =
            http.MultipartFile("image", stream, length, filename: image.path);
        request.files.add(multipartFile);

        data.forEach((key, value) {
          request.fields[key] = value;
        });

        var myrequest = await request.send();

        var response = await http.Response.fromStream(myrequest);
        Map responsebody = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          showDialogWithGetX("تم الاضافه بنجاح");
          addLoading.value = false;
          clearData();
          getAllCategories();
        } else {
          print('//////');
          print(CacheStorageServices().token);
          print(responsebody['message']);
          showDialogWithGetX(responsebody['message']);
          addLoading.value = false;
        }
      } catch (error) {
        showDialogWithGetX(error.toString());
        addLoading.value = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
      addLoading.value = false;
    }
  }

  bool updateLoading = false;
  updateDataWithFile(String id, Map data, File? image) async {
    if (await checkInternet()) {
      try {
        updateLoading = true;
        update();
        var headers = {
          'Accept': 'application/json',
          "Authorization": 'Bearer ${CacheStorageServices().token}',
          "Content-Type": 'multipart/form-data',
        };

        var request =  http.MultipartRequest("PATCH", updateCategoryUri(id));
        request.headers.addAll(headers);
        if (image != null) {
          var fileExtension = image.path;

          var length = await image.length();
          var stream = http.ByteStream(image.openRead());

          var multipartFile =
              http.MultipartFile("image", stream, length, filename: image.path);
          request.files.add(multipartFile);
        }
        data.forEach((key, value) {
          request.fields[key] = value;
        });

        var myrequest = await request.send();

        var response = await http.Response.fromStream(myrequest);
        Map responsebody = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          showDialogWithGetX("تم التعديل بنجاح");
          getAllCategories();
          updateLoading = false;
        } else {
          print('cccccccccc');
          showDialogWithGetX(responsebody['message']);
          updateLoading = false;
        }
      } catch (error) {
        print(error.toString());
        showDialogWithGetX(error.toString());
        updateLoading = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
    update();
  }

  void deleteCategory(String? id) async {
    if (await checkInternet()) {
      try {
        print(deleteCategoryUri(id));
        final response = await http.delete(deleteCategoryUri(id),
            headers: authHeadersWithToken(CacheStorageServices().token));
        final result = jsonDecode(response.body);
        print('result ${result['message']} ${response.statusCode}');
        if (response.statusCode == 200) {
          showDialogWithGetX(result['message']);
          getAllCategories();
        } else {
          showDialogWithGetX(result['message']);
        }
      } catch (error) {
        showDialogWithGetX(error.toString());
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
  }

  clearData() {
    titleController.clear();
    categoryImage = null;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllCategories();
  }

  @override
  void dispose() {
    titleController.dispose();
    commissionController.dispose();
    clearData();
    // TODO: implement dispose
    super.dispose();
  }
}
