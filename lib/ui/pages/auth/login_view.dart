import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/bing_nuos_auth/bing_nuos_auth_widget.dart';
import 'package:bingnuos_admin_panel/ui/components/bing_nuos_auth/forgot_password_login_widget.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailTextFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());
  final passwordTextFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final isEmailError = ValueNotifier<bool>(false);
  final isPasswordError = ValueNotifier<bool>(false);
  final isLoading = ValueNotifier<bool>(false);

  void _resetPassword() {
    context.go(resetPasswordLoc);
  }

  void _login() async {
    isEmailError.value = false;
    isPasswordError.value = false;
    isLoading.value = true;

    String email = emailTextFieldController.value.text.trim().toLowerCase();
    String password = passwordTextFieldController.value.text;

    if (_validate(email, password)) {
      Map<bool, String> result =
          await context.read<AuthService>().signInWithEmailAndPassword(
                email: email,
                password: password,
              );

      bool success = result.keys.first;
      String e = result.values.first;
      if (!success && mounted) {
        SnackBarService(context).show(context
            .read<AuthService>()
            .getFirebaseAuthErrorMessage(e, context));
      }
    }
    isLoading.value = false;
  }

  bool _validate(String email, String password) {
    if (!Utils.emailValid(email)) {
      isEmailError.value = true;
      return false;
    }

    if (!Utils.passwordValid(password)) {
      isPasswordError.value = true;
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BingNuosAuthWidget(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocale(context).login,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: isEmailError,
              builder: (context, showError, child) => AppTextField(
                key: const Key("email"),
                labelText: AppLocale(context).email,
                controller: emailTextFieldController.value,
                errorText: AppLocale(context).emailWrong,
                showError: showError,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isPasswordError,
              builder: (context, showError, child) => AppTextField(
                key: const Key("password"),
                labelText: AppLocale(context).password,
                controller: passwordTextFieldController.value,
                inputType: InputType.password,
                errorText: AppLocale(context).passwordWrong,
                showError: showError,
              ),
            ),
            ForgotPasswordLoginWidget(
              text: AppLocale(context).forgotPassword,
              buttonText: AppLocale(context).resetHere,
              onTap: _resetPassword,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, isDisabled, child) {
                      return AppElevatedButton(
                        title: AppLocale(context).login,
                        width: 120,
                        height: 40,
                        isDisabled: isDisabled,
                        onPressed: _login,
                      );
                    },
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (_, value, __) => value
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
