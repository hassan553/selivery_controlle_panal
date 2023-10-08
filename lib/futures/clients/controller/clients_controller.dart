import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/futures/clients/model/vehicle_model.dart';
import '../model/passengers_model.dart';

class ClientController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  List<PassengerModel> passengerList = [];
  List<VehicleModel> vehicleList = [];
  Future<void> getTopPassengersData() async {
    isLoading.value = true;
    print(token);
    try {
      final response = await http.get(
        topPassengers,
        headers: authHeadersWithToken(token),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        print('top passengers  $result');
        var r = result['users'] as List;
        r.map((e) {
          passengerList.add(e);
        }).toList();
        print(passengerList);
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

  Future<void> getTopVehiclesData() async {
    isLoading.value = true;
    print(token);
    try {
      final response = await http.get(
        topVehicles,
        headers: authHeadersWithToken(token),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        //homeModel.value=HomeModel.fromJson(result['stats']);
        print('top Vehicles  $result');
        var r = result['vehicles'] as List;
        r.map((e) {
          vehicleList.add(e);
        }).toList();
        print(vehicleList);
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