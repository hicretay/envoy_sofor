import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/homePage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  Future<void> loadPictures() async {
    await precachePicture(ExactAssetPicture((SvgPicture.svgStringDecoder),'assets/images/bg.svg'), null);    
  } 
    Future.wait([loadPictures()]);
    Future.delayed(Duration(seconds: 2), ()async{
      // Sayfanın görünme süresi
      //----Önceki sayfayı silerek LoginPage'e geçiş--------
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString("user");
      String pass = prefs.getString("pass");
      //bool login = prefs.getBool("login");
      if(user==null)
      Navigator.pushNamedAndRemoveUntil(context, "/loginPage", (route) => false);

      else{
      final UserJsonModel  userData  = await userJsonFunc(user, pass); // kullanıcı verileri
      final OrderJsonModel orderData = await orderJsonFunc(globalDurumId, userData.user.id);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
      HomePage(orderData: orderData,userData: userData))); // home verilerini doldur
      }
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
          image: AssetImage("assets/images/splash.jpg"), // arkaplan resmi
          fit: BoxFit.cover, // ekranı kaplasın
        ),
      ),
    );
  }
}
