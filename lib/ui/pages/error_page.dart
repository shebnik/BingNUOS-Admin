import 'dart:math';

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404\nPage not found\n\n${error.toString()}',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
