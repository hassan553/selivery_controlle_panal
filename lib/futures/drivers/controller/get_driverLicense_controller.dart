import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/contants/api.dart';
import '../../../core/functions/internet_checker.dart';
import '../../../core/services/cache_storage_services.dart';
import '../model/driver_license_model.dart';

class GetDriverLicenseController extends GetxController {
  var isLoading = false.obs;
  var allLicenseDataError = ''.obs;
  RxList<DriverLicenseModel> allLicenseList = <DriverLicenseModel>[].obs;

  Future<void> getAllLicenseData() async {
    if (await checkInternet()) {
      isLoading.value = true;
      try {
        allLicenseList.value = [];
        final response = await http.get(
          getAllDriverLicenseAdsUri,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('all ads   ${result['requests']}');
          var r = result['requests'] as List;
          r.map((e) {
            allLicenseList.add(DriverLicenseModel.fromJson(e));
          }).toList();
          print(allLicenseList[0].driverLicense);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          allLicenseDataError.value = result['message'];
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        allLicenseDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      allLicenseDataError.value = 'لا يوجد اتصال بالانترنت';
    }
    print(allLicenseDataError.value);
  }
Future approveDriver(String id)async{
 
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://localhost:8000/dashboard/request/64e2ba58ce5e2848b5df1fb7/approve'));

    request.headers.addAll(authHeadersWithToken(CacheStorageServices().token));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      
    } else {
      print(response.reasonPhrase);
    }

}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllLicenseData();
  }
}
