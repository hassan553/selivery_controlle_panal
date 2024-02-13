import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/contants/api.dart';
import '../../../core/functions/internet_checker.dart';
import '../model/passengers_model.dart';
import '../model/vehicle_model.dart';

import '../../../core/services/cache_storage_services.dart';

class ClientController extends GetxController {
  var isLoading = false.obs;
  var vehicleIsLoading = false.obs;
  var passengersDataError = ''.obs;
  var vehiclesDataError = ''.obs;
  RxList passengerList = <PassengerModel>[].obs;
  RxList vehicleList = <VehicleModel>[].obs;

  Future<void> getTopPassengersData() async {
    passengerList.value = <PassengerModel>[];
    if (await checkInternet()) {
      isLoading.value = true;
      try {
        final response = await http.get(
          topPassengers,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          var r = result['users'] as List;
          r.map((e) {
            passengerList.add(PassengerModel.fromJson(e));
          }).toList();
          isLoading.value = false;
          passengerList.isEmpty
              ? passengersDataError.value = 'لا يوجد بيانات'
              : passengersDataError.value = '';
        } else {
          isLoading.value = false;
          passengersDataError.value = result['message'];
        }
      } catch (e) {
        isLoading.value = false;
        passengersDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      passengersDataError.value = 'لا يوجد اتصال بالانترنت';
    }
  }

  Future<void> getTopVehiclesData() async {
    vehicleList.value = <VehicleModel>[];
    if (await checkInternet()) {
      vehicleIsLoading.value = true;

      try {
        final response = await http.get(
          topVehicles,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          var r = result['vehicles'] as List;
          r.map((e) {
            vehicleList.add(VehicleModel.fromJson(e));
          }).toList();
          vehicleIsLoading.value = false;
          vehicleList.isEmpty
              ? vehiclesDataError.value = 'لا يوجد بيانات'
              : vehiclesDataError.value = '';
        } else {
          vehicleIsLoading.value = false;
          vehiclesDataError.value = 'لقد حدث خطا يرجا اعادة المحاوله';
        }
      } catch (e) {
        vehicleIsLoading.value = false;
        vehiclesDataError.value = e.toString();
      } finally {
        vehicleIsLoading.value = false;
      }
    } else {
      vehiclesDataError.value = 'لا يوجد اتصال بالانترنت';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTopPassengersData();
    getTopVehiclesData();
  }
}
