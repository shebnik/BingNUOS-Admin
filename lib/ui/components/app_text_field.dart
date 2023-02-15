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

  @override
  Widget build(BuildContext context) {
    var obscureText = ValueNotifier<bool>(true);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ValueListenableBuilder(
        valueListenable: obscureText,
        builder: (context, value, child) {
          return TextField(
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
