import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/main.dart';

import '../../../const/my_theme.dart';
import '../../../controllers/landing_controller.dart';
import '../../components/custom_text.dart';
import '../../components/grid_view_widget.dart';

class FavouriteScreen extends ShyWidget {
  final LandingController controller;

  FavouriteScreen({super.key,required this.controller});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: MyTheme.blackColor,
      appBar: AppBar(
        title: const CustomText(text: "Favourite Giphy", fontSize: 22, textColor: MyTheme.whiteColor),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridViewWidget(
                controller: controller,
                data: controller.favGif.value,
                isLogin: controller.isLogin.value,
                isLanding: false,
              )),
        );
      }),
    );
  }
}
