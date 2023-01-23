import 'package:bingnuos_admin_panel/ui/components/app_logo_widget.dart';
import 'package:bingnuos_admin_panel/ui/components/home/app_bar/home_app_bar_title.dart';
import 'package:bingnuos_admin_panel/ui/components/language_selector.dart';
import 'package:bingnuos_admin_panel/ui/components/theme_switch_icon_button.dart';
import 'package:flutter/material.dart';

class BingNuosAuthWidget extends StatelessWidget {
  final List<Widget> children;

  const BingNuosAuthWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    final isTrueLandscape = isLandscape && width > 800;
    return Scaffold(
      appBar: !isTrueLandscape
          ? AppBar(
              automaticallyImplyLeading: false,
              title: const HomeAppBarTitle(),
              actions: const [
                ThemeSwitchIconButton(),
                LanguageSelector(),
              ],
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Row(
              children: [
                if (isTrueLandscape) ...[
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          color: Theme.of(context).splashColor,
                          constraints: const BoxConstraints.expand(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppLogoWidget(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                ThemeSwitchIconButton(),
                                LanguageSelector(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: isTrueLandscape
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: children,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
