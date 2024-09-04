import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/controllers/landing_controller.dart';
import 'package:giphy/services/callback_listener.dart';

import '../const/const.dart';
import '../helpers/CommonMethods.dart';
import '../helpers/shared_pref.dart';
import '../services/firebase_authentication.dart';
import '../views/screens/onboarding_screens/landing_screen.dart';

class AuthController extends GetxController  {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  //login by firebase
  signIn() async {
    isLoading.value = true;
    notifyChildrens();
    final credential = await AuthenticationHelper().signIn(email: emailController.text, password: passwordController.text);
    if (credential?.user?.uid.isNotEmpty == true) {
      SharedPref.setString(key: Const.accessToken, data: credential?.user?.uid ?? '');
      SharedPref.setBool(key: Const.keepLoggedIn, data: true);
      Get.offAll(LandingScreen());
      LandingController().checkLogin();
    }
    isLoading.value = true;
    notifyChildrens();
  }

  //registration on firebase
  signUp() async {
    isLoading.value = true;
    notifyChildrens();
    final credential = await AuthenticationHelper().signUp(email: emailController.text, password: passwordController.text);
    if (credential?.user?.uid.isNotEmpty == true) {
      SharedPref.setString(key: Const.accessToken, data: credential?.user?.uid ?? '');
      SharedPref.setBool(key: Const.keepLoggedIn, data: true);
      Get.offAll(LandingScreen());
      LandingController().checkLogin();
    }
    isLoading.value = true;
    notifyChildrens();
  }

//logout from firebase
  logout() async{
    await AuthenticationHelper().signOut();
    await SharedPref.clear();
    await SharedPref.setBool(key: Const.keepLoggedIn, data: false);
  }
}
