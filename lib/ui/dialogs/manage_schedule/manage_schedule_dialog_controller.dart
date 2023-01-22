// import 'package:bing_nuos_admin_panel/main_controller.dart';
// import 'package:bing_nuos_admin_panel/models/schedule.dart';
// import 'package:bing_nuos_admin_panel/services/firebase/firestore_service.dart';
// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/utils.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/state_manager.dart';

// class ManageScheduleDialogController extends GetxController {
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

//   late int number;

//   ScheduleInfo? scheduleInfo;

//   void close() {
//     Get.back();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     if (scheduleInfo != null) {
//       nameTextFieldController.value.text = scheduleInfo!.name;
//       cabinetTextFieldController.value.text = scheduleInfo!.cabinet;
//       teacherTextFieldController.value.text = scheduleInfo!.teacher;
//     }
//   }

//   Future<void> remove(
//       BuildContext context, String group, ScheduleWeekDay day) async {
//     final fieldScheduleInfo = readFields(context);
//     if (fieldScheduleInfo == null) return;
//     bool result =
//         await FirestoreService().removeSchedule(group, day, fieldScheduleInfo);

//     if (result) {
//       mainController.isLoading = false;
//       Get.back();
//     } else {
//       mainController.isLoading = false;
//       Widgets.openSnackbar(message: AppStrings.groupNumberWrong);
//     }
//   }

//   Future<void> add(
//       BuildContext context, String group, ScheduleWeekDay day) async {
//     final fieldScheduleInfo = readFields(context);
//     if (fieldScheduleInfo == null) return;

//     bool result = scheduleInfo != null
//         ? await FirestoreService()
//             .updateSchedule(group, day, scheduleInfo!, fieldScheduleInfo)
//         : await FirestoreService().addSchedule(group, day, fieldScheduleInfo);

//     if (result) {
//       mainController.isLoading = false;
//       Get.back();
//     } else {
//       mainController.isLoading = false;
//       Widgets.openSnackbar(message: AppStrings.error);
//     }
//   }

//   ScheduleInfo? readFields(context) {
//     String name = nameTextFieldController.value.text;
//     String cabinet = cabinetTextFieldController.value.text;
//     String teacher = teacherTextFieldController.value.text;

//     if (!validate(name, cabinet, teacher)) return null;
//     FocusScope.of(context).unfocus();
//     mainController.isLoading = true;

//     return ScheduleInfo(
//       name: name,
//       cabinet: cabinet,
//       teacher: teacher,
//       number: number,
//     );
//   }

//   bool validate(String name, String cabinet, String teacher) {
//     if (name.length < 3) {
//       isNameError.value = true;
//       return false;
//     } else {
//       isNameError.value = false;
//     }
//     if (cabinet.length < 3) {
//       isCabinetError.value = true;
//       return false;
//     } else {
//       isCabinetError.value = false;
//     }
//     if (teacher.length < 3) {
//       isTeacherError.value = true;
//       return false;
//     } else {
//       isTeacherError.value = false;
//     }
//     return true;
//   }
// }
