import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/services/cache_storage_services.dart';
import 'package:selivery_controlle_panal/core/widgets/snack_bar_widget.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';
import 'package:selivery_controlle_panal/main.dart';

import '../../../core/contants/api.dart';
import '../../../core/functions/internet_checker.dart';
import '../../../core/widgets/show_awesomeDialog.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  Future<void> login(context) async {
    isLoading.value = true;
    if (await checkInternet()) {
      try {
        final response = await http.post(
          loginUri,
          body: {
            'email': email.text.trim(),
            'password': password.text.trim(),
            'deviceToken': '121212',
          },
        );
        final result = jsonDecode(response.body);
        if (response.statusCode == 200){
        await  CacheStorageServices().setToken(result['token']);
          print('my token ${result['token']}');
          navigateTo(context, MainView());
          isLoading.value = false;
          showSnackBarWidget(
              context: context,
              message: 'Admin loggedIn successfully',
              requestStates: RequestStates.success);
        } else {
          print(result);
          showDialogWithGetX(result['message']);
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        showDialogWithGetX(e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
      isLoading.value = false;
      print(CacheStorageServices().token);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
