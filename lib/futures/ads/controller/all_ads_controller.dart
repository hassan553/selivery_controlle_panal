import 'dart:convert';

import 'package:get/get.dart';
import '../../../core/functions/internet_checker.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/cache_storage_services.dart';
import '../../../core/contants/api.dart';
import '../../../core/widgets/show_awesomeDialog.dart';
import '../model/ads_model.dart';

class AllAdsController extends GetxController {
  var isLoading = false.obs;
  var allAdsDataError = ''.obs;
  RxList allAdsList = <AdsModel>[].obs;

  Future<void> getAllAdsData() async {
       
    if (await checkInternet()) {
      try {
        isLoading.value = true;
        allAdsList.value = <AdsModel>[].obs;
        final response = await http.get(
          getAllAdsUri,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          var r = result['ads'] as List;
          r.map((e) {
            allAdsList.add(AdsModel.fromJson(e));
          }).toList();
          allAdsList.isEmpty
              ? allAdsDataError.value = 'لا يوجد بيانات'
              : allAdsDataError.value = '';
          isLoading.value = false;
        } else {
          isLoading.value = false;
          allAdsDataError.value = result['message'];
        }
      } catch (e) {
        isLoading.value = false;
        allAdsDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      allAdsDataError.value = 'لا يوجد اتصال بالانترنت';
    }
  }

  void deleteAds(String? id) async {
     
    if (await checkInternet()) {
      try {
        final response = await http.delete(deleteAdsUri(id!),
            headers: authHeadersWithToken(CacheStorageServices().token));
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          showDialogWithGetX(result['message']);
          getAllAdsData();
        } else {
          showDialogWithGetX(result['message']);
        }
      } catch (error) {
        showDialogWithGetX(error.toString());
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
    update();
  }
}
