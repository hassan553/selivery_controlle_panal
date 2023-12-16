import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/futures/auth/view/login_view.dart';
import 'package:selivery_controlle_panal/futures/home/model/home_model.dart';
import 'package:selivery_controlle_panal/main.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/services/cache_storage_services.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var homeModel = HomeModel().obs;
  var error = ''.obs;
  int currentIndex = 0;
  void changeBottomNavIndex(int index) {
    currentIndex = index;
    update();
  }

  Future<void> getHomeData() async {
    
    isLoading.value = true;
    
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.122:8000/dashboard'),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        homeModel.value = HomeModel.fromJson(result['stats']);
        isLoading.value = false;
        error.value = '';
        print(homeModel.value.driversNo);
      } else {
        isLoading.value = false;
        error.value = result['message'];
        print(error.value);
        if (result['message'] == "Token is not valid"||result['message']=='Your are not authorized.') {
          CacheStorageServices().clear();
          navigatorOff(LoginView());
        }
      }
    } catch (e) {
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
    getHomeData();
  }
}
