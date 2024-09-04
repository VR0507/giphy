// import 'package:giphy/controllers/landing_controller.dart';
// import 'package:giphy/models/gif_list_model.dart';
// import 'package:giphy/services/api_requested_keys.dart';
// import 'package:giphy/services/api_services.dart';
// import 'package:giphy/services/callback_listener.dart';
//
// import '../../helpers/CommonMethods.dart';
//
// class LandingService extends CallBackListener {
//   LandingController controller = LandingController();
//
//   getTrandingGifs(int? itemPerPage) {
//     apiServices.apiRequestGet(this, "getTrandingGifs", "${apiList.getTrandingGifs}$itemPerPage");
//   }
//
//   getSearchedGifs(int? itemPerPage, String? search) {
//     apiServices.apiRequestGet(this, "getSearchGifs", "${apiList.getSearchGifs}$itemPerPage&q=$search");
//   }
//
//   @override
//   callBackFunction(String action, result) {
//     if (action == "getTrandingGifs") {
//       GifListModel gifListModel = GifListModel.fromJson(result);
//       // controller.gifList.value=GifListModel.fromJson(result);
//       controller.appendAllData(gifListModel.data??[]);
//       notifyChildrens();
//     }
//     if (action == "getSearchGifs") {
//       GifListModel gifListModel = GifListModel.fromJson(result);
//       controller.appendAllData(gifListModel.data??[]);
//       notifyChildrens();
//     }
//   }
//
//   @override
//   callBackFunctionError(String action, result) {
//     CommonMethods.errorMsg('Please try again.');
//   }
// }
