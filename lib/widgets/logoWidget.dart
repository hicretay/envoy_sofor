import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../settings/consts.dart';

// uygulamada sayfa altında yer alan logo görünmünün tanımlaması
class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: maxSpace, top: maxSpace),
        child: SvgPicture.asset(
          "assets/images/logo.svg",
          color: logoColor,
        ),
      ),
    );
  }
}
