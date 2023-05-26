// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/utils/utils.dart';

enum InputType {
  password,
  number,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.inputType,
    this.showError = false,
    this.errorText,
    this.focusNode,
    this.prefixIcon,
    this.accountToggle,
    this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final InputType? inputType;
  final bool showError;
  final String? errorText;
  final FocusNode? focusNode;
  final Icon? prefixIcon;
  final VoidCallback? accountToggle;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    var obscureText = ValueNotifier<bool>(true);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ValueListenableBuilder(
        valueListenable: obscureText,
        builder: (context, value, child) {
          return TextField(
            enabled: enabled,
            focusNode: focusNode,
            enableSuggestions: inputType == InputType.password ? false : true,
            autocorrect: inputType == InputType.password ? false : true,
            controller: controller,
            inputFormatters: Utils.getInputFormatters(
              isNumberType: inputType == InputType.number,
            ),
            obscureText:
                inputType == InputType.password ? obscureText.value : false,
            keyboardType:
                inputType == InputType.number ? TextInputType.number : null,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(
              fillColor: enabled ?? true ? null : Colors.grey.withOpacity(0.1),
              labelStyle: enabled ?? true
                  ? null
                  : TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              labelText: labelText,
              isDense: true,
              hintText: hintText,
              errorText: showError ? errorText : null,
              prefixIcon: prefixIcon,
              suffixIcon: inputType == InputType.password
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        dragStartBehavior: DragStartBehavior.down,
                        onTap: () => obscureText.value = !obscureText.value,
                        child: Icon(
                          obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    )
                  : null,
            ),
            onChanged: (value) {
              if (inputType == InputType.number && value.contains(',')) {
                controller.text = value.replaceAll(',', '.');
                controller.value = controller.value.copyWith(
                  selection: TextSelection(
                    baseOffset: value.length,
                    extentOffset: value.length,
                  ),
                  composing: TextRange.empty,
                );
              }
            },
          );
        },
      ),
    );
  }
}
