import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import '../const/app_images.dart';
import '../const/const.dart';
import '../const/strings.dart';
import '../helpers/CommonMethods.dart';
import '../helpers/shared_pref.dart';
import 'callback_listener.dart';

class ApiServices {
  http.Client client = http.Client();
  late CallBackListener apiCallBackListener;
  late String apiUrl;
  late String apiAction;
  late bool loaderShow;
  late Map<String, dynamic> apiFileMap;
  late Map<String, dynamic> apiBodyMap;
  late String reqType;

  Future<dynamic> apiRequestGet(CallBackListener callBackListener, String action, url, {showLoader = true}) async {
    http.Response response;
    reqType = "get";
    apiCallBackListener = callBackListener;
    apiAction = action;
    apiUrl = url;
    loaderShow = showLoader;

    var isConnected = await CommonMethods.checkInternetConnectivity();
    if (isConnected) {
      String token = await SharedPref.getString(key: Const.accessToken);
      Map<String, String> headers = {};
      headers["Accept"] = "application/json";
      
        headers["token"] = token;
      
      print('token==>$token');
      try {
        if (loaderShow) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            barrierDismissible: false,
            useSafeArea: true,
          );
        }
        response = await client.get(Uri.parse(apiUrl), headers: headers);
        if (loaderShow) {
          loaderShow = false;
          Get.back();
        }

        if (kDebugMode) {
          print("UrlCheck===" + url);
        }

        if (kDebugMode) {
          print("ResponseCode===${response.statusCode}");
        }
        if (kDebugMode) {
          print("ResponseCheck===${response.body}");
        }
        
        if (response.statusCode == 200) {
          
          apiCallBackListener.callBackFunction(apiAction, json.decode(response.body));
        } else {
          apiCallBackListener.callBackFunctionError(action, response.body);
        }
      } on SocketException catch (cc) {
        if (loaderShow) {
          loaderShow = false;
          Get.back();
        }
        CommonMethods.errorMsg(cc.message);
        print("SocketError------> ${cc.message}");
      } catch (e) {
        if (loaderShow) {
          loaderShow = false;
          Get.back();
        }
        print('Error--->$e');
      }
    } else {
      if (loaderShow) {
        loaderShow = false;
        Get.back();
      }
      showDailog();
    }
  }

  Future<dynamic> apiRequestPostJSON(CallBackListener callBackListener, String action, url, body, {showLoader = true}) async {
    http.Response response;
    reqType = "post";
    apiCallBackListener = callBackListener;
    apiAction = action;
    apiUrl = url;
    apiBodyMap = body;
    loaderShow = showLoader;

    var isConnected = await CommonMethods.checkInternetConnectivity();
    if (isConnected) {
      String token = await SharedPref.getString(key: Const.accessToken);
      Map<String, String> headers = {};
      headers["Accept"] = "application/json";
      if (token.isNotEmpty) {
        headers["token"] = token;
      }
      if (loaderShow) {
        Get.dialog(
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            barrierDismissible: false,
            useSafeArea: true);
      }
      response = await client.post(Uri.parse(apiUrl), body: apiBodyMap, headers: headers, encoding: Encoding.getByName("utf-8"));

      print("UrlCheck===" + url);
      print("BodyCheck===$apiBodyMap");
      print("ResponseCheck===${response.body}");
      print("ResponseCode===${response.statusCode}");
      if (loaderShow) {
        loaderShow = false;
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      }
      if (response.statusCode == 200) {
        apiCallBackListener.callBackFunction(apiAction, json.decode(response.body));
      } else {
        apiCallBackListener.callBackFunctionError(action, response.body);
      }
    } else {
      if (loaderShow) {
        loaderShow = false;
        Get.back();
      }
      showDailog();
    }
  }

  Future<dynamic> apiRequestMultipart(CallBackListener callBackListener, String action, url, fileMap, bodyMap, {showLoader = true}) async {
    http.Response response;
    reqType = "multipart";
    apiCallBackListener = callBackListener;
    apiAction = action;
    apiUrl = url;
    apiFileMap = fileMap;
    apiBodyMap = bodyMap;
    loaderShow = showLoader;

    var isConnected = await CommonMethods.checkInternetConnectivity();
    if (isConnected) {
      List<String> keysForImage = [];
      for (int i = 0; i < apiFileMap.length; i++) {
        String key = apiFileMap.keys.elementAt(i);
        keysForImage.add(key);
      }

      try {
        if (loaderShow) {
          Get.dialog(
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              barrierDismissible: false,
              useSafeArea: true);
        }
        var uri = Uri.parse(apiUrl);
        var request = http.MultipartRequest("POST", uri);
        String token = await SharedPref.getString(key: Const.accessToken);
        Map<String, String> headers = {};
        headers["Accept"] = "application/json";
        if (token.isNotEmpty) {
          headers["Authorization"] = "Bearer $token";
        }

        headers["Access-Control-Allow-Origin"] = "*";
        headers["Access-Control-Allow-Headers"] = "*";
        request.headers.addAll(headers);
        response = await http.Response.fromStream(await request.send());

        if (loaderShow) {
          loaderShow = false;
          await Future.delayed(const Duration(seconds: 1));
          Get.back();
        }
        if (response.statusCode == 200) {
          print("UrlCheck===" + url);
          print("Response Check===${response.body}");
          apiCallBackListener.callBackFunction(apiAction, json.decode(response.body));
        } else {
          apiCallBackListener.callBackFunctionError(action, response.body);
        }
      } on SocketException catch (cc) {
        if (loaderShow) {
          loaderShow = false;
          Get.back();
        }
        print('Hello SocketException------> ${cc.message}');
        showDailog();
      } catch (e) {
        if (loaderShow) {
          loaderShow = false;
          Get.back();
        }
        print("Error InMultiPasswordRequest Api ------> $e");
      }
    } else {
      if (loaderShow) {
        loaderShow = false;
        Get.back();
      }
      showDailog();
    }
  }


  showNetworkDialog(context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    AppImages.noInternet,
                    height: 44,
                    width: 44,
                  ),
                ),
                Text(
                  appStrings.noInternet,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  appStrings.checkInternet,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(appStrings.ok),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  static showDailog() {
    Get.defaultDialog(
        title: '',
        content: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                AppImages.noInternet,
                height: 44,
                width: 44,
              ),
            ),
            Text(
              appStrings.noInternet,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              appStrings.checkInternet,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 1));
              Get.back();
            },
            child: Text(appStrings.ok),
          )
        ]);
  }

  static ApiServices newApiService() {
    final apiServices = ApiServices();
    return apiServices;
  }
}

final apiServices = ApiServices.newApiService();
class _ApiRequest {
  final CallBackListener callBackListener;
  final String action;
  final String url;
  final bool showLoader;

  _ApiRequest(this.callBackListener, this.action, this.url, this.showLoader);
}