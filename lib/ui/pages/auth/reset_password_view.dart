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

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final emailTextFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final isEmailError = ValueNotifier<bool>(false);

  void _login() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      context.go(loginLoc);
    }
  }

  Future<void> _resetPassword() async {
    isEmailError.value = false;
    String email = emailTextFieldController.value.text.trim().toLowerCase();

    if (!Utils.emailValid(email)) {
      isEmailError.value = true;
      return;
    }

    await context.read<AuthService>().resetPassword(email);
    if (!mounted) return;
    SnackBarService(context).show(AppLocale(context).resetPasswordEmailSent);
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
                AppLocale(context).resetPassword,
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
            ForgotPasswordLoginWidget(
              text: AppLocale(context).rememberPassword,
              buttonText: AppLocale(context).loginHere,
              onTap: _login,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppElevatedButton(
                    width: 200,
                    title: AppLocale(context).resetPassword,
                    onPressed: _resetPassword,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
