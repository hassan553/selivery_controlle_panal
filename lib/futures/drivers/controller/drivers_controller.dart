import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';

import '../model/driver_model.dart';

class DriversController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  RxList driversList = <DriverModel>[].obs;
  Future<void> getTopDriversData() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        topDrivers,
        headers: authHeadersWithToken(token),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('top Drivers  $result');
        var r = result['drivers'] as List;
        r.map((e) {
          driversList.add(DriverModel.fromJson(e));
        }).toList();
        print(driversList);
        isLoading.value = false;
        error.value = '';
        isLoading.value = false;
        error.value = '';
      } else {
        isLoading.value = false;
        error.value = 'لقد حدث خطا يرجا اعادة المحاوله';
      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
/*
// Check connectivity before making the API call
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      error.value = 'No internet connection';
      return;
    }
//connectivity
 */