import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';

// uygulamada sayfa altında yer alan logo görünmünün tanımlaması
class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: maxSpace),
        child: SvgPicture.asset(
          "assets/images/logo.svg",
          color: logoColor,
        ),
      ),
    );
  }
}
