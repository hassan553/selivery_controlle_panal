import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/widgets/image_picker.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  final titleController = TextEditingController();

  Future<void> addCategory() async {
    // isLoading.value = true;
    try {
      //await pickClientImage('image');
      print(token);
      final response = await http.post(
        Uri.parse('http://localhost:8000/dashboard/category'),
        body:
            jsonEncode({'name': titleController.text, 'image': categoryImage}),
        headers: authHeadersWithToken(token),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        //isLoading.value = false;
        // showSnackBarWidget(
        //     context: context,
        //     message:"Category Added Successfully",
        //     requestStates: RequestStates.success);
        print('done');
      } else {
        //isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
      // isLoading.value = false;
      // showSnackBarWidget(
      //     context: context,
      //     message: e.toString(),
      //     requestStates: RequestStates.error);
    } finally {
      //isLoading.value = false;
    }
  }

  // // try this code
  // Future<String?> getImageBase64() async {
  //   final imagePicker = ImagePicker();
  //   final XFile? image =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //
  //   if (image == null) {
  //     return null;
  //   }
  //
  //   final bytes = await image.readAsBytes();
  //   final encodedImage = base64Encode(bytes);
  //
  //   return encodedImage;
  // }

  _uploadImage(String title, File file) async {
    try {
      final Uri url = Uri.parse('http://192.168.1.122:8000/dashboard/category');
      var request = http.MultipartRequest('POST', url);
      request.fields["images"] = title;
      request.files.add(http.MultipartFile.fromBytes(
          'image', File(file!.path).readAsBytesSync(),
          filename: file!.path));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      var res = await request.send();
      print('response ${res.toString()}');
      print('image upload success');
    } catch (error) {
      print(error.toString());
    }
  }
  // _uploadImage(String title, File file) async {
  //   try {
  //     var request = http.MultipartRequest(
  //         'PATCH', Uri.parse('http://192.168.1.122:8000/dashboard/category'));
  //     request.fields["images"] = title;
  //     request.files.add(http.MultipartFile.fromBytes(
  //         'image', File(file!.path).readAsBytesSync(),
  //         filename: file!.path));
  //     request.headers['Authorization'] = 'Bearer $token';
  //     request.headers['Content-Type'] = 'multipart/form-data';
  //     var res = await request.send();
  //     print('response ${res.toString()}');
  //     print('image upload success');
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

////////////////////////

  Future<void> uploadDataWithNameAndImage(String name, File imageFile) async {
    final request = http.MultipartRequest('POST', uploadCategoryUri);
    request.fields['name'] = name;
    request.headers['Authorization'] = 'Bearer $token';

    final fileStream = http.ByteStream(imageFile.openRead());
    final fileLength = await imageFile.length();

    final multipartFile = http.MultipartFile(
      'image',
      fileStream,
      fileLength,
      filename: 'image.jpg',
    );
    request.files.add(multipartFile);
    try {
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final Map<String, dynamic> responseJson = json.decode(responseString);
      print(responseJson['message']);
      if (response.statusCode == 200) {
        // Request successful, you can handle the response here
        final Map<String, dynamic> responseJson = json.decode(responseString);
        print('done upload');
      } else {
        // Request failed, handle the error
        print('Request failed with status ${response.statusCode}');
        print(responseString);
      }
    } catch (e) {
      // Handle any exceptions that occurred during the request
      print('Error sending request: ${e.toString()}');
    }
  }

///////////////////////////////////////
  ///get all category
  List<CategoryModel> categoryList = <CategoryModel>[];
  var categoryError = ''.obs;
  var categoryLoading = false.obs;
  Future<void> getAllCategories() async {
    try {
      categoryLoading.value = true;
      final response =
          await http.get(allCategory, headers: authHeadersWithToken(token));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        result['categories'].forEach((json) {
          categoryList.add(CategoryModel.fromJson(json));
        });

        print("category List ${categoryList}");
        categoryError.value = '';
        categoryLoading.value = false;
      } else {
        final result = json.decode(response.body);
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
      if (categoryImage != null) {
        print('image path ${categoryImage!.path}');
        await postDataWithFile({'name': 'assssssas'}, categoryImage!);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  postDataWithFile(Map data, File? image) async {
    var headers = {
      'Accept': 'application/json',
      "Authorization": 'Bearer $token',
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("tm");
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      print(response.body);
      print('success upload image');
    } else {
      print(response.body);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
