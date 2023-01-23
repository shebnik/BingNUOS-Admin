import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404\n${AppLocale(context).pageNotFound}\n\n${error.toString()}',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
