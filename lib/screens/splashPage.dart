import 'package:envoy/settings/consts.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () { // Sayfanın görünme süresi
    //----Önceki sayfayı silerek LoginPage'e geçiş--------
      Navigator.pushNamedAndRemoveUntil(
          context, "/loginPage", (route) => false);
    //----------------------------------------------------
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}