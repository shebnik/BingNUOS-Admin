import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({ Key? key }) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResetPasswordViewPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ResetPasswordViewPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
