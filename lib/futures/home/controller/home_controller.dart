import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/contants/api.dart';
import 'package:selivery_controlle_panal/futures/auth/view/login_view.dart';
import 'package:selivery_controlle_panal/futures/home/model/home_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/functions/internet_checker.dart';
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
    if (await checkInternet()) {
      isLoading.value = true;
      try {
        print('oooos${CacheStorageServices().token}');
        final response = await http.get(
          Uri.parse('${baseUri}dashboard'),
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
        print(result['message']);
        if (response.statusCode == 200) {
          homeModel.value = HomeModel.fromJson(result['stats']);
          isLoading.value = false;
          error.value = '';
          print(homeModel.value.driversNo);
        } else {
          isLoading.value = false;
          error.value = result['message'];
          print(error.value);
          if (result['message'] == "Token is not valid" ||
              result['message'] == 'Your are not authorized.') {
            if (CacheStorageServices().token.isNotEmpty) {
              await refreshToken();
            } else {
              navigatorOff(LoginView());
            }
          }
        }
      } catch (e) {
        isLoading.value = false;
        error.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      error.value = 'لا يوجد اتصال بالانترنت';
    }
  }

  bool refreshLoading = false;
  Future<void> refreshToken() async {
    print('refresh token');
    if (await checkInternet()) {
      refreshLoading = true;
      update();
      try {
        print('oooorR---${CacheStorageServices().token}');
        final response = await http.get(
          Uri.parse('${authBaseUri}refresh-token'),
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);
        print('message ${result['token']}');
        if (response.statusCode == 200) {
          CacheStorageServices().setToken(result['token']);
          refreshLoading = false;
          error.value = '';
          print('done');
          getHomeData();
        } else {
          refreshLoading = false;
          error.value = result['message'];
          print(error.value);
          if (result['message'] == "Token is not valid" ||
              result['message'] == 'Your are not authorized.') {
            navigatorOff(LoginView());
          }
        }
      } catch (e) {
        refreshLoading = false;
        error.value = e.toString();
      }
    } else {
      error.value = 'لا يوجد اتصال بالانترنت';
    }
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(CacheStorageServices().token);
    getHomeData();
  }
}
