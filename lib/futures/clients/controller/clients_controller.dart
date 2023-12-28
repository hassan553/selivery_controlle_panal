import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/functions/internet_checker.dart';
import 'package:selivery_controlle_panal/futures/clients/model/passengers_model.dart';
import 'package:selivery_controlle_panal/futures/clients/model/vehicle_model.dart';

import '../../../core/services/cache_storage_services.dart';

class ClientController extends GetxController {
  var isLoading = false.obs;
  var passengersDataError = ''.obs;
  var vehiclesDataError = ''.obs;
  RxList passengerList = <PassengerModel>[
    PassengerModel(
        email: 'hassan@gmail.com',
        image: '',
        passenger: 'hassan',
        phone: '01000',
        sId: '12',
        tripsCount: 12),
  ].obs;
  RxList vehicleList = <VehicleModel>[
    VehicleModel(tripsCount: 2, model: 'frirrai', images: null),
    VehicleModel(tripsCount: 2, model: 'frirrai', images: [
      '2023-12-28T07-33-58.547Zscaled_IMG-20231227-WA0003.jpg',
    ]),
  ].obs;

  Future<void> getTopPassengersData() async {
    if (await checkInternet()) {
      isLoading.value = true;
      try {
        final response = await http.get(
          topPassengers,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('top passengers  $result');
          var r = result['users'] as List;
          r.map((e) {
            passengerList.add(e);
          }).toList();
          print(passengerList);
          isLoading.value = false;
          passengerList.isEmpty
              ? passengersDataError.value = 'لا يوجد بيانات'
              : passengersDataError.value = '';
        } else {
          isLoading.value = false;
          passengersDataError.value = result['message'];
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        passengersDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      passengersDataError.value = 'لا يوجد اتصال بالانترنت';
    }
    print(passengersDataError.value);
  }

  Future<void> getTopVehiclesData() async {
    if (await checkInternet()) {
      isLoading.value = true;

      try {
        final response = await http.get(
          topVehicles,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          //homeModel.value=HomeModel.fromJson(result['stats']);
          print('top Vehicles  $result');
          var r = result['vehicles'] as List;
          r.map((e) {
            vehicleList.add(e);
          }).toList();
          print(vehicleList);
          isLoading.value = false;
          vehicleList.isEmpty
              ? vehiclesDataError.value = 'لا يوجد بيانات'
              : vehiclesDataError.value = '';
        } else {
          isLoading.value = false;
          vehiclesDataError.value = 'لقد حدث خطا يرجا اعادة المحاوله';
        }
      } catch (e) {
        isLoading.value = false;
        vehiclesDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      vehiclesDataError.value = 'لا يوجد اتصال بالانترنت';
    }
    print(vehiclesDataError.value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getTopPassengersData();
    //getTopVehiclesData();
  }
}
