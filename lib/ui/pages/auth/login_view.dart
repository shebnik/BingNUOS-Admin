import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/bing_nuos_auth/bing_nuos_auth_widget.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  void login() async {
    isEmailError.value = false;
    isPasswordError.value = false;
    isLoading.value = true;

    String email = emailTextFieldController.value.text.trim().toLowerCase();
    String password = passwordTextFieldController.value.text;

    if (validate(email, password)) {
      await context.read<AuthService>().signInWithEmailAndPassword(
            email: email,
            password: password,
            context: context,
          );
    }

    isLoading.value = false;
  }

  bool validate(String email, String password) {
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
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: isEmailError,
              builder: (context, showError, child) => AppTextField(
                key: const Key("email"),
                label: AppLocale(context).email,
                controller: emailTextFieldController.value,
                errorText: AppLocale(context).emailWrong,
                showError: showError,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isPasswordError,
              builder: (context, showError, child) => AppTextField(
                key: const Key("password"),
                label: AppLocale(context).password,
                controller: passwordTextFieldController.value,
                inputType: InputType.password,
                errorText: AppLocale(context).passwordWrong,
                showError: showError,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 26),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocale(context).forgotPassword,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4),
                        ),
                      ),
                      WidgetSpan(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: Text(
                              AppLocale(context).resetHere,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: AppTheme.primaryLight,
                                  ),
                            ),
                            onTap: () {
                              context.go(resetPasswordLoc);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, isDisabled, child) =>
                          AppElevatedButton(
                        title: AppLocale(context).login,
                        isDisabled: isDisabled,
                        onPressed: login,
                      ),
                    ),
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
