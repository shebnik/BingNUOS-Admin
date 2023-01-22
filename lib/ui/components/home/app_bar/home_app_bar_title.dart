import 'package:bingnuos_admin_panel/utils/app_assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              height: 30,
              child: SvgPicture.asset(
                AppAssets.logo,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
