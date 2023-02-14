import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';
import 'package:bingnuos_admin_panel/providers/search_groups_provider.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupSearchBar extends StatefulWidget {
  const GroupSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupSearchBar> createState() => _GroupSearchBarState();
}

class _GroupSearchBarState extends State<GroupSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _showClearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        _showClearButton.value = false;
      } else {
        _showClearButton.value = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          context.read<GroupSearchProvider>().searchValue = value;
        },
        decoration: InputDecoration(
          hintText: AppLocale.of(context).searchGroups,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: ValueListenableBuilder(
            valueListenable: _showClearButton,
            builder: (context, value, child) {
              return value
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _controller.clear();
                          context.read<GroupSearchProvider>().searchValue = "";
                        },
                        child: const Icon(Icons.clear),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Theme.of(context).canvasColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Theme.of(context).canvasColor),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        ),
      ),
    );
  }
}
