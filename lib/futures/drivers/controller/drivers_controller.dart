import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/functions/internet_checker.dart';
import 'package:selivery_controlle_panal/core/widgets/show_awesomeDialog.dart';
import 'package:selivery_controlle_panal/futures/drivers/views/all_drivers_view.dart';
import '../../../core/services/cache_storage_services.dart';
import '../model/driver_model.dart';

class DriversController extends GetxController {
  var isLoading = false.obs;
  var allDriversLoading = false.obs;
  var allDriverserror = ''.obs;
  var deleteIsLoading = false.obs;
  var error = ''.obs;
  RxList bestDriversList = <DriverModel>[].obs;
  bool isSearch = false;
  void isSearchMethod() {
    isSearch = !isSearch;
    update();
  }

  RxList<DriverModel> driversList = <DriverModel>[
    //
    DriverModel(
      sId: '1',
      name: 'hassan',
      image: 'user.jpg',
      phone: '12121212',
      age: 20,
      gender: 'male',
      rating: Rating(cool: 1, fair: 0, good: 3),
      vehicle: Vehicle(
        category: 'سياره',
        model: "Toyota Crolla 2008",
        images: [
          'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990_640.png'
        ],
      ),
    ),
    DriverModel(
        sId: '2',
        name: 'Marzouk',
        image: 'user.jpg',
        phone: '12121212',
        age: 20,
        gender: 'male',
        rating: Rating(cool: 1, fair: 0, good: 3),
        vehicle: Vehicle(
            category: 'سياره',
            model: "Toyota Crolla 2008",
            images: [
              'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990_640.png'
            ])),
  ].obs;
  final searchText = ''.obs;
  List<DriverModel?> get filteredItems {
    print(searchText.value);
    if (searchText.value.isEmpty) {
      return driversList;
    } else {
      return driversList.where((item) {
        String? name = item.name ?? '';
        print(name);
        return name.toLowerCase().startsWith(searchText.value.toLowerCase());
      }).toList();
    }
  }

  getAllDriversData() async {
    if (await checkInternet()) {
      try {
        driversList.value = <DriverModel>[];
        allDriversLoading.value = true;
        final response = await http.get(
          topDrivers,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('All Drivers  $result');
          var r = result['drivers'] as List;
          r.map((e) {
            driversList.add(DriverModel.fromJson(e));
          }).toList();
          driversList.isEmpty
              ? allDriverserror.value = 'لا يوجد بيانات'
              : allDriverserror.value = '';
          print('i get succ$driversList');
          allDriversLoading.value = false;
        } else {
          allDriversLoading.value = false;
          allDriverserror.value = result['message'];
        }
      } catch (e) {
        print(e.toString());
        allDriversLoading.value = false;
        allDriverserror.value = e.toString();
      } finally {
        allDriversLoading.value = false;
      }
    } else {
      allDriverserror.value = 'لا يوجد اتصال بالانترنت';
    }
    print(allDriverserror.value);
  }

  Future<void> getTopDriversData() async {
    if (await checkInternet()) {
      try {
        bestDriversList.value = <DriverModel>[];
        isLoading.value = true;
        final response = await http.get(
          topDrivers,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('top Drivers  $result');
          var r = result['drivers'] as List;
          r.map((e) {
            bestDriversList.add(DriverModel.fromJson(e));
          }).toList();
          filteredItems.isEmpty
              ? error.value = 'لا يوجد بيانات'
              : error.value = '';
          print('i get succ$bestDriversList');
          isLoading.value = false;
        } else {
          isLoading.value = false;
          error.value = result['message'];
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        error.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      error.value = 'لا يوجد اتصال بالانترنت';
    }
    print(error.value);
  }

  void deleteDriverAccount(String id, BuildContext context) async {
    if (await checkInternet()) {
      try {
        deleteIsLoading.value = true;
        final response = await http.delete(
          deleteDriverAccountUri(id),
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // print('delete Driver  ${result['message']}');
          // showDialogWithGetX(result['message']);
          navigateOff(context, AllDriversView());
          deleteIsLoading.value = false;
        } else {
          deleteIsLoading.value = false;
          showDialogWithGetX(result['message']);
        }
      } catch (e) {
        print(e.toString());
        deleteIsLoading.value = false;
        showDialogWithGetX(e.toString());
      } finally {
        deleteIsLoading.value = false;
      }
    } else {
      showDialogWithGetX('لا يوجد اتصال بالانترنت');
    }
  }
var vehicleLoading = false;
  Future getDriverVehicle(String id) async {
    if (await checkInternet()) {
      vehicleLoading = true;
      update();
      final response = await http.get(
        driverVehicleUri(id),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);

      showDialogWithGetX(result['message']);
      vehicleLoading = false;
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
      vehicleLoading = false;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
