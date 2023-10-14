import 'dart:convert';

import 'package:get/get.dart';
import 'package:selivery_controlle_panal/core/functions/internet_checker.dart';
import 'package:http/http.dart' as http;

import '../../../core/contants/api.dart';
import '../model/ads_model.dart';

class AllAdsController extends GetxController {
  var isLoading = false.obs;
  var allAdsDataError = ''.obs;
  RxList allAdsList = <AdsModel>[].obs;

  Future<void> getAllAdsData() async {
    if (await checkInternet()) {
      isLoading.value = true;
      try {
        final response = await http.get(
          getAllAdsUri,
          headers: authHeadersWithToken(token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('all ads   ${result['ads']}');
          var r = result['ads'] as List;
          r.map((e) {
            allAdsList.add(AdsModel.fromJson(e));
          }).toList();
          print('all ads   $allAdsList');
          isLoading.value = false;
        } else {
          isLoading.value = false;
          allAdsDataError.value = result['message'];
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        allAdsDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      allAdsDataError.value = 'لا يوجد اتصال بالانترنت';
    }
    print(allAdsDataError.value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllAdsData();
  }
}
