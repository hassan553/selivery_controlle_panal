import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/functions/global_function.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../../home/view/main_view.dart';
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
        if (response.statusCode == 200) {
          await CacheStorageServices().setToken(result['token']);
          navigateOff(context, MainView());
          isLoading.value = false;
          email.clear();
          password.clear();
          showSnackBarWidget(
              context: context,
              message: 'تم التسجيل بنجاح',
              requestStates: RequestStates.success);
        } else {
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
