import 'package:flutter/material.dart';

import '../consts.dart';

class DocumentViewWidget extends StatefulWidget {
  const DocumentViewWidget({
    Key key,
  }) : super(key: key);

  @override
  _DocumentViewWidgetState createState() => _DocumentViewWidgetState();
}

class _DocumentViewWidgetState extends State<DocumentViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        child: Container(
          width: deviceWidth(context),
          height: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/document.png"),
            ),
          ),
        ),
        onTap: (){
          Navigator.pushNamed(context, "/updateDocumentPage");
          // belge güncelle sayfasına yönlendirme
        },
      ),
    );
  }
}