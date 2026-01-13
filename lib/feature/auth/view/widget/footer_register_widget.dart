import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FooterRegisterWidget extends StatelessWidget {
  const FooterRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: ImageIcon(AssetImage(AppConstants.googlePath), size: 25),
        ),
        SizedBox(width: SizeConfig.width(context) * 0.032),
        IconButton(
          onPressed: () {},
          icon: ImageIcon(AssetImage(AppConstants.applePath), size: 25),
        ),
        SizedBox(width: SizeConfig.width(context) * 0.032),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppConstants.facebookPath,
            height: 25,
            width: 25,
          ),
        ),
      ],
    );
  }
}
