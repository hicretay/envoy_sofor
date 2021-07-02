import 'package:envoy/settings/consts.dart';
import 'package:flutter/material.dart';

class OrderRowWidget extends StatelessWidget {
  final String leading, content;

  const OrderRowWidget({
    Key key,
    this.leading,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(minSpace),
      child: Row(
        children: [
          Container(
            width: deviceWidth(context) * 0.35,
            child: Text(
              leading,
              style: cardTextStyle,
            ),
          ),
          Container(
            child: Text(
              " : ",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: deviceWidth(context) * 0.55,
            child: Text(
              " $content",
              style: contentTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
