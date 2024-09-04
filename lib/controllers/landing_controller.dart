import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/controllers/auth_controller.dart';
import 'package:giphy/helpers/shared_pref.dart';
import 'package:giphy/models/gif_list_model.dart';
import 'package:giphy/models/gif_model.dart';

import '../const/const.dart';
import '../helpers/CommonMethods.dart';
import '../services/api_requested_keys.dart';
import '../services/api_services.dart';
import '../services/callback_listener.dart';

class LandingController extends GetxController implements CallBackListener {
  var isLogin = false.obs;
  var currentUid = ''.obs;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var gifList = GifListModel().obs;
  var favGif = <GifModel>[].obs;
  var gifLists = <GifModel>[].obs;
  bool _isLoading=false;
  @override
  void onReady() {
    checkLogin();
    getTrandingGifs();
    super.onReady();
  }

  @override
  void onInit() {
    scrollController.addListener(onScroll);
    super.onInit();
  }

  @override
  void refresh() {
    checkLogin();
    super.refresh();
  }

  //for infinite scroll
  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !_isLoading) {
      loadMore();
    }
  }

  //to check login
  checkLogin() async {
    isLogin.value = await SharedPref.getBool(key: Const.keepLoggedIn);
    currentUid.value = await SharedPref.getString(key: Const.accessToken);
  }

  //to save favourite from firebase
  saveFav(String url) async {
    currentUid.value = await SharedPref.getString(key: Const.accessToken);
    CollectionReference gifs = FirebaseFirestore.instance.collection('favourite');

    return gifs
        .add({
          "url": url,
          "uid": currentUid.value.toString(),
        })
        .then((value) => CommonMethods.successMsg("Favourite added successfully!"))
        .catchError((error) => CommonMethods.errorMsg("Failed to add favourite: $error"));
  }


  //to get favourite from firebase
  fetchFavGifs() async {
    currentUid.value = await SharedPref.getString(key: Const.accessToken);
    CollectionReference gifs = FirebaseFirestore.instance.collection('favourite');

    return gifs.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        if (currentUid.value == doc.get("uid")) {
          if (favGif.any(
                (element) => element.url == doc.get("url"),
              ) ==
              false) {
            favGif.add(GifModel(id: doc.id, url: doc.get("url")));
          }
        }
      }
    }).catchError((error) => CommonMethods.errorMsg("Failed to fetch favourite: $error"));
  }

  //to un favourite from firebase
  deleteFav(id, url) {
    favGif.removeWhere(
      (element) => element.url == url,
    );
    notifyChildrens();
    CollectionReference gifs = FirebaseFirestore.instance.collection('favourite');
    return gifs.doc(id).delete().then((value) {
      CommonMethods.successMsg("User deleted successfully!");
      fetchFavGifs();
      notifyChildrens();
    }).catchError((error) => CommonMethods.errorMsg("Failed to unfavourite gifs: $error"));
  }

  //to achieve infinite scroll
  loadMore() {
    _isLoading=true;
    if (gifList.value.data?.isNotEmpty == true) {
      for (int i = gifLists.length; i < ((gifLists.length + 25) < (gifList.value.data?.length ?? 0) ? gifLists.length + 25 : gifList.value.data?.length ?? 0); i++) {
        gifLists.add(GifModel(id: "", url: gifList.value.data?[i].images?.original?.url ?? ''));
      }
    }
    notifyChildrens();
    _isLoading=false;
  }

  //to search gif
  void getSearchGifs() {
    if (searchController.text.isNotEmpty) {
      apiServices.apiRequestGet(this, "getSearchGifs", "${apiList.getSearchGifs}200&q=${searchController.text.trim()}");
    } else {
      getTrandingGifs();
    }
  }

  //get tranding gifs
  getTrandingGifs() {
    apiServices.apiRequestGet(this, "getTrandingGifs", "${apiList.getTrandingGifs}200");
  }

  //signout
  signOut() async {
    await AuthController().logout();
    checkLogin();
  }

  //to know the response of api
  @override
  callBackFunction(String action, result) {
    if (action == "getTrandingGifs") {
      gifLists.value = [];
      gifList.value = GifListModel.fromJson(result);
      loadMore();
      notifyChildrens();
    }
    if (action == "getSearchGifs") {
      gifLists.value = [];
      gifList.value = GifListModel.fromJson(result);
      loadMore();
      notifyChildrens();
    }
  }

  //to know when error happen
  @override
  callBackFunctionError(String action, result) {
    CommonMethods.errorMsg('Please try again.');
  }
}
