// import 'package:bing_nuos_admin_panel/dialogs/add_group/manage_group_dialog_controller.dart';
// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ManageGroupDialog extends StatelessWidget {
//   const ManageGroupDialog({
//     Key? key,
//     this.group,
//   }) : super(key: key);

//   final String? group;

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AddGroupDialogController());
//     controller.group = group;
//     return Dialog(
//       insetPadding: const EdgeInsets.only(top: 20, left: 15, right: 15),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//       elevation: 2,
//       backgroundColor: Colors.white,
//       child: Container(
//         padding:
//             const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
//         width: 400,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 AppStrings.groupNumber,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 15),
//               Obx(() => Widgets.textField(
//                     controller: controller.groupNumberTextFieldController.value,
//                     errorText: AppStrings.groupNumberWrong,
//                     showError: controller.isGroupNumberError.value,
//                   )),
//               const SizedBox(height: 14),
//               Container(
//                 margin: const EdgeInsets.only(top: 24),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Widgets.textButton(
//                       AppStrings.cancel,
//                       onPressed: controller.close,
//                     ),
//                     const SizedBox(width: 20),
//                     SizedBox(
//                       width: 120,
//                       child: Widgets.elevatedButton(
//                         AppStrings.done,
//                         onPressed: () => controller.manage(context),
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
