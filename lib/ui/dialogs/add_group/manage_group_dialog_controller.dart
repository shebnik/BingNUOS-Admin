// import 'package:bing_nuos_admin_panel/main_controller.dart';
// import 'package:bing_nuos_admin_panel/services/firebase/firestore_service.dart';
// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/state_manager.dart';

// class AddGroupDialogController extends GetxController {
//   final Rx<TextEditingController> groupNumberTextFieldController =
//       TextEditingController().obs;

//   final MainController mainController = Get.find();
//   RxBool isGroupNumberError = false.obs;

//   String? group;

//   void close() {
//     Get.back();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     if (group != null) groupNumberTextFieldController.value.text = group!;
//   }

//   Future<void> manage(BuildContext context) async {
//     String number = groupNumberTextFieldController.value.text;

//     if (!validate(number)) return;
//     FocusScope.of(context).unfocus();

//     mainController.isLoading = true;

//     if (group != null) {
//       if (await FirestoreService().renameGroup(group!, number)) {
//         mainController.isLoading = false;
//         Get.back();
//       } else {
//         mainController.isLoading = false;
//         Widgets.openSnackbar(message: AppStrings.error);
//       }
//       return;
//     }
//     if (await FirestoreService().createGroup(number)) {
//       mainController.isLoading = false;
//       Get.back();
//     } else {
//       mainController.isLoading = false;
//       Widgets.openSnackbar(message: AppStrings.error);
//     }
//   }

//   bool validate(String number) {
//     if (number.isEmpty || number.contains(' ')) {
//       isGroupNumberError.value = true;
//       return false;
//     } else {
//       isGroupNumberError.value = false;
//     }
//     return true;
//   }
// }
