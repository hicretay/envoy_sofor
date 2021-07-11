import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/roots.dart';
import 'package:flutter/material.dart';

void main() async {
 //WidgetsFlutterBinding.ensureInitialized();
  ThemeData theme = ThemeData(
    fontFamily: contentFont, // uygulama yazı tipi
    //------------------------------AppBar teması-------------------------------
    appBarTheme: AppBarTheme(
      centerTitle: true, // appBar başlığı
      backgroundColor: btnColor, // appBar arkaplan rengi
      titleTextStyle: TextStyle(
        fontFamily: leadingFont, // appBar başlık yazı tipi
        color: Colors.white, // appBar başlık yazı rengi
        fontSize: 28, // appBar başlık yazı boyutu
      ),
    ),
    //--------------------------------------------------------------------------
  );
  // await precachePicture(
  //     ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/images/bg.svg'),
  //     null);

  runApp(
    MaterialApp(
      theme: theme,
      onGenerateRoute: Roots.generateRoute, // isimlendirilmiş sayfa yönlendirme
      debugShowCheckedModeBanner: false,
      initialRoute: splashRoute, // uygulama başlangıcı
    ),
  );
}
