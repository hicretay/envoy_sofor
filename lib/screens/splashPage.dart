import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:envoy/models/orderJsonModel.dart';
import 'package:envoy/models/userJsonModel.dart';
import 'package:envoy/screens/homePage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var connectivityResult = Connectivity().checkConnectivity();

  @override
  void initState() {
    //WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    Future<void> loadPictures() async {
    await precachePicture(ExactAssetPicture((SvgPicture.svgStringDecoder),'assets/images/bg.svg'), null);    
  } 
    Future.wait([loadPictures()]);

   // Future.delayed(Duration(seconds: 2), x);

    Future.delayed(Duration(seconds: 2), ()async{ // Sayfanın görünme süresi
      if(await connectivityResult != ConnectivityResult.none){ //await connectivityResult != ConnectivityResult.none     
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString("user");
      String pass = prefs.getString("pass");
      if(user==null)
      Navigator.pushNamedAndRemoveUntil(context, "/loginPage", (route) => false);
      //Önceki sayfayı silerek LoginPage'e geçiş

      else {
      final UserJsonModel  userData  = await userJsonFunc(user, pass); // kullanıcı verileri
      final OrderJsonModel orderData = await orderJsonFunc(globalDurumId, userData.user.id);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
      HomePage(orderData: orderData,userData: userData))); // home verilerini doldur
      }
      //----------------------------------------------------      
  }
  else{
    //await showAlert(context, "İnternet bağlantınızı kontrol ediniz.");
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Text("İnternet bağlantınızı kontrol ediniz.", style: TextStyle(fontFamily: contentFont)),
        actions: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               MaterialButton(
               color: btnColor,
               child: Text("Kapat",style: TextStyle(fontFamily: leadingFont)), // fotoğraf çekilmeye devam edilecek
               onPressed: () async{
                 SystemNavigator.pop();
            }),
          ],
           ),
          
        ],
      );
    });
  }
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
