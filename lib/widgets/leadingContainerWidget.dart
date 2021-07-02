import 'package:flutter/material.dart';

import '../consts.dart';

class LeadingContainerWidget extends StatelessWidget {
  final String leading;
  const LeadingContainerWidget({
    Key key, this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context) * 0.05,
      color: btnColor,
      child: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(" $leading", style: cardTextStyle),
        ),
      ),
    );
  }
}
