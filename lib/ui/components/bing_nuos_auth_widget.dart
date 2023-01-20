// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bingnuos_admin_panel/ui/components/app_logo_widget.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BingNuosAuthWidget extends StatelessWidget {
  final Widget child;

  const BingNuosAuthWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Row(
            children: [
              if (isLandscape)
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: AppTheme.secondaryColor,
                        constraints: const BoxConstraints.expand(),
                      ),
                      const AppLogoWidget(),
                    ],
                  ),
                ),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
