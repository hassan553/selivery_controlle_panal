import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:selivery_controlle_panal/core/functions/global_function.dart';
import 'package:selivery_controlle_panal/core/widgets/snack_bar_widget.dart';
import 'package:selivery_controlle_panal/futures/home/view/main_view.dart';
import 'package:selivery_controlle_panal/main.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login(context) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.122:8000/auth/login/admin'),
        body: {
          'email': email.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        await sharedPreferences.setString('token', result['token']);
        navigatorOff(MainView());
        isLoading.value = false;
        showSnackBarWidget(
            context: context,
            message: 'Admin loggedIn successfully',
            requestStates: RequestStates.success);
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBarWidget(
          context: context,
          message: e.toString(),
          requestStates: RequestStates.error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
