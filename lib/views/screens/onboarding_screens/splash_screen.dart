import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/const/app_images.dart';
import 'package:giphy/const/my_theme.dart';
import 'package:giphy/main.dart';

import '../../../controllers/splash_controller.dart';

class SplashScreen extends ShyWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(backgroundColor: MyTheme.blackColor,
      body: Center(child: Image.asset(AppImages.appLogo)),);
  }
}
