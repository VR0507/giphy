import 'package:get/get.dart';

import '../views/screens/onboarding_screens/landing_screen.dart';
class SplashController extends GetxController {

  @override
  void onReady() {
    navigate();
  }

  //to navigate
  navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off( LandingScreen());
    });
  }
}
