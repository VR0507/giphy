import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/const/my_theme.dart';
import 'package:giphy/controllers/landing_controller.dart';
import 'package:giphy/main.dart';
import 'package:giphy/views/components/custom_text.dart';
import 'package:giphy/views/components/custom_text_field.dart';
import 'package:giphy/views/components/grid_view_widget.dart';

import '../auth_screens/sign_in_screen.dart';
import '../other_screens/favourite_screen.dart';

class LandingScreen extends ShyWidget {
  final LandingController controller = Get.put(LandingController());

  LandingScreen({super.key});

  Timer? _debounce;
//Search when search field changes
  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      print(value);
      controller.getSearchGifs();
    });
  }

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Obx(() {
      controller.checkLogin();
      //to update the ui whenever fav gif increases
      print(controller.favGif.length);
      return Scaffold(
          backgroundColor: MyTheme.blackColor,
          appBar: AppBar(
            backgroundColor: MyTheme.blackColor,
            title: const CustomText(text: "Giphy", fontSize: 22, textColor: MyTheme.whiteColor),
            actions: [
              IconButton(
                  onPressed: () {
                    if (controller.isLogin.value) {
                      controller.fetchFavGifs();
                      Get.to(FavouriteScreen(
                        controller: controller,
                      ));
                    } else {
                      Get.to(const SignInScreen());
                    }
                  },
                  icon: const Icon(CupertinoIcons.heart)),
              if (controller.isLogin.value) IconButton(onPressed: () => controller.signOut(), icon: const Icon(Icons.output)) else IconButton(onPressed: () => Get.to(const SignInScreen()), icon: const Icon(CupertinoIcons.person_circle)),
            ],
          ),
          body: InkWell(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomTextField(
                    title: "",
                    hintText: "Search",
                    controller: controller.searchController,
                    onChanged: _onSearchTextChanged,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: h * 0.7,
                  child: controller.gifList.value.data?.isNotEmpty == true
                      ? SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: GridViewWidget(
                                    controller: controller,
                                    data: controller.gifLists,
                                    // data: controller.gifList.value.data
                                    //         ?.map(
                                    //           (e) => GifModel(id: "", url: e.images?.original?.url ?? ''),
                                    //         )
                                    //         .toList() ??
                                    //     [],
                                    isLogin: controller.isLogin.value,
                                    isLanding: true,
                                  )),
                            ],
                          ),
                        )
                      : const Center(
                          child: CustomText(text: "No Giphy Found", fontSize: 20, textColor: MyTheme.whiteColor),
                        ),
                ),
              ],
            ),
          ));
    });
  }
}
