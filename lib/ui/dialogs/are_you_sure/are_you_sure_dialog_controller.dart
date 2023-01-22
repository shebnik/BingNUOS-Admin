// import 'package:bing_nuos_admin_panel/main_controller.dart';
// import 'package:bing_nuos_admin_panel/models/schedule.dart';
// import 'package:bing_nuos_admin_panel/services/firebase/firestore_service.dart';
// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/state_manager.dart';

// class AreYouSureDialogController extends GetxController {
//   final MainController mainController = Get.find();

//   final Rx<TextEditingController> nameTextFieldController =
//       TextEditingController().obs;
//   final Rx<TextEditingController> cabinetTextFieldController =
//       TextEditingController().obs;
//   final Rx<TextEditingController> teacherTextFieldController =
//       TextEditingController().obs;

//   RxBool isNameError = false.obs;
//   RxBool isCabinetError = false.obs;
//   RxBool isTeacherError = false.obs;

//   ScheduleInfo? scheduleInfo;

//   String? action;

//   void close() {
//     Get.back();
//   }

//   Future<void> remove(BuildContext context, String group) async {
//     bool result = await FirestoreService().removeDoc(group);

//     if (result) {
//       mainController.isLoading = false;
//       Get.back();
//     } else {
//       mainController.isLoading = false;
//       Widgets.openSnackbar(message: AppStrings.groupNumberWrong);
//     }
//   }
// }
