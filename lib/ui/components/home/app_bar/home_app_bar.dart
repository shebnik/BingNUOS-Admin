import 'package:bingnuos_admin_panel/ui/components/home/app_bar/group_search_bar.dart';
import 'package:bingnuos_admin_panel/ui/components/language_selector.dart';
import 'package:bingnuos_admin_panel/ui/components/theme_switch_icon_button.dart';
import 'package:flutter/material.dart';

import 'home_app_bar_actions.dart';
import 'home_app_bar_title.dart';

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight;

  const HomePageAppBar({
    Key? key,
    this.appBarHeight = 50,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          const HomeAppBarTitle(),
          Expanded(
            child: SizedBox(
              height: appBarHeight,
              child: const GroupSearchBar(),
            ),
          ),
        ],
      ),
      actions: const [
        ThemeSwitchIconButton(),
        LanguageSelector(),
        HomeAppBarActions(),
      ],
    );
  }
}
