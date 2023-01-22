// // ignore_for_file: must_be_immutable

// import 'package:bing_nuos_admin_panel/utils/app_strings.dart';
// import 'package:bing_nuos_admin_panel/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'are_you_sure_dialog_controller.dart';

// class AreYouSureDialog extends StatelessWidget {
//   final String action;
//   final String group;

//   const AreYouSureDialog({
//     Key? key,
//     required this.action,
//     required this.group,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AreYouSureDialogController());
//     controller.action = action;
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
//                 AppStrings.areYouSure,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 15),
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
//                     const SizedBox(width: 20),
//                     SizedBox(
//                       width: 120,
//                       child: Widgets.elevatedButton(
//                         AppStrings.remove,
//                         onPressed: () => controller.remove(context, group),
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
