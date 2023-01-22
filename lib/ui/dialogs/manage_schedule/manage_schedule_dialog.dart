// // ignore_for_file: must_be_immutable

// import 'package:bing_nuos_admin_panel/dialogs/manage_schedule/manage_schedule_dialog_controller.dart';
// import 'package:bing_nuos_admin_panel/models/schedule.dart';
// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/utils.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ManageScheduleDialog extends StatelessWidget {
//   final int number;
//   final String group;
//   final ScheduleWeekDay day;

//   ScheduleInfo? scheduleInfo;

//   ManageScheduleDialog({
//     Key? key,
//     required this.group,
//     required this.day,
//     required this.number,
//     this.scheduleInfo,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ManageScheduleDialogController());
//     controller.scheduleInfo = scheduleInfo;
//     controller.number = number;
//     return Dialog(
//       insetPadding: const EdgeInsets.only(top: 20, left: 15, right: 15),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//       elevation: 2,
//       backgroundColor: Colors.white,
//       child: Container(
//         padding:
//             const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
//         width: 600,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 AppStrings.manageSchedule,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 '$group ${Utils.nameFromWeekDay(day)} ${number + 1}-ая пара',
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Obx(() => Widgets.textField(
//                     controller: controller.nameTextFieldController.value,
//                     hint: AppStrings.subjectName,
//                     errorText: AppStrings.subjectNameWrong,
//                     showError: controller.isNameError.value,
//                   )),
//               const SizedBox(height: 15),
//               Obx(() => Widgets.textField(
//                     controller: controller.cabinetTextFieldController.value,
//                     hint: AppStrings.cabinetNumber,
//                     errorText: AppStrings.cabinetNumberWrong,
//                     showError: controller.isCabinetError.value,
//                   )),
//               const SizedBox(height: 15),
//               Obx(() => Widgets.textField(
//                     controller: controller.teacherTextFieldController.value,
//                     hint: AppStrings.teacherName,
//                     errorText: AppStrings.teacherNameWrong,
//                     showError: controller.isTeacherError.value,
//                   )),
//               const SizedBox(height: 15),
//               Container(
//                 margin: const EdgeInsets.only(top: 24),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Widgets.textButton(
//                       AppStrings.cancel,
//                       onPressed: controller.close,
//                     ),
//                     if (scheduleInfo != null) ...[
//                       const SizedBox(width: 20),
//                       SizedBox(
//                         width: 120,
//                         child: Widgets.elevatedButton(
//                           AppStrings.remove,
//                           onPressed: () =>
//                               controller.remove(context, group, day),
//                         ),
//                       ),
//                     ],
//                     const SizedBox(width: 20),
//                     SizedBox(
//                       width: 120,
//                       child: Widgets.elevatedButton(
//                         AppStrings.add,
//                         onPressed: () => controller.add(context, group, day),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
