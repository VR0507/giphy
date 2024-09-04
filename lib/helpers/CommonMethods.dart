import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CommonMethods {
  static String version = "";

  static Future<bool> checkInternetConnectivity() async {
    // String connectionStatus;
    // bool isConnected = false;
    // final Connectivity _connectivity = Connectivity();
    //
    // try {
    //   connectionStatus = (await _connectivity.checkConnectivity()).toString();
    //   if (await _connectivity.checkConnectivity() == [ConnectivityResult.mobile]) {
    //     print("===internet-connected==Mobile$connectionStatus");
    //     isConnected = true;
    //     // I am connected to a mobile network.
    //   } else if (await _connectivity.checkConnectivity() == [ConnectivityResult.wifi]) {
    //     isConnected = true;
    //     print("===internet-connected==wifi$connectionStatus");
    //     // I am connected to a wifi network.
    //   } else if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
    //     isConnected = false;
    //     print("===internet-connected==not$connectionStatus");
    //   }
    // } on PlatformException catch (e) {
    //   print("===internet==not connected$e");
    //   connectionStatus = 'Failed to get connectivity.';
    // }
    // return isConnected;
    return true;
  }

  static void moveCursorToastPos(TextEditingController textField) {
    var cursorPos = TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static void showToast(message) {
    Get.showSnackbar(GetSnackBar(
      message: message.toString(),
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ));
  }

  static void showProgress() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void errorMsg(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void successMsg(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void inputFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isConnect = false;

  static Future<String> createFileOfPdfUrl(link) async {
    String pathPDF = "";
    try {
      final url = link;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      pathPDF = file.path;
      return pathPDF;
    } catch (e) {
      print("error ->>>>${e.toString()}");
      return "Eror";
    }
  }
}
