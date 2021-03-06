import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:envoy/models/orderJsonModel.dart';
import 'package:envoy/models/userJsonModel.dart';
import 'package:envoy/screens/homePage.dart';
import 'package:envoy/settings/connection.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/functions.dart';
import 'package:envoy/widgets/bgWidget.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

    @override
    initState() {
        super.initState();
        ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
        _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    }

    void connectionChanged(dynamic hasConnection) {      
        isOffline = !hasConnection;
        setState(() {});
    }

  @override
  void didChangeDependencies() {   
    super.didChangeDependencies();   
  }

  @override
  void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    _connectionChangeStream.cancel();
    super.dispose();
  }
  var connectivityResult = Connectivity().checkConnectivity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(builder:(context)=>
           Stack(
             children: 
               [
                 BgWidget(),
                 SingleChildScrollView(
                   reverse: true,
                   child: Padding(
                     padding: EdgeInsets.only(
                     bottom: MediaQuery.of(context).viewInsets.bottom),
                     child: Column(
                     children: [
                       SizedBox(height: deviceHeight(context) * 0.2), // giri?? ikonu - cihaz ??st?? bo??luk          
                       //--------------giri?? ikonunun yer alaca???? container----------------
                       Container(
                         width : 127, //ikon geni??li??ine g??re verildi
                         height: 71, //ikon y??ksekli??ine g??re verildi
                         decoration: BoxDecoration(
                             image : DecorationImage(
                             image : AssetImage("assets/images/girisikon.png"), //logo resmi                 
                             fit   : BoxFit.cover, // resim erkan?? kaplayacak                 
                           ),
                         ),
                       ),
                       //------------------------------------------------------------------
                       SizedBox(height: defaultPadding), // logo - giri?? ikonu aras?? bo??luk          
                       SvgPicture.asset("assets/images/logo.svg", color: logoColor),  // logo svg'sinin g??sterilmesi           
                       SizedBox(height: deviceHeight(context) * 0.2),  //logo - textFieldlar aras?? bo??luk   
               
                       SingleChildScrollView( 
                         reverse: true,                          
                         child: Column(
                           children:[
                             //--------------------Kullan??c?? ad?? textField'??---------------------
                             Padding(padding: const EdgeInsets.all(maxSpace),
                               child       : TextFieldWidget(textEditingController: txtUsername,
                               keyboardType: TextInputType.name,
                               hintText    : "Kullan??c?? Ad??", //ipucu metni
                               obscureText : false, // yaz??lanlar gizlenmesin
                             ),
                         ),
                         //-------------------------??ifre textField'??------------------------
                       Padding(padding: const EdgeInsets.all(maxSpace),
                           child: TextFieldWidget(
                           textEditingController: txtPassword,
                           keyboardType: TextInputType.visiblePassword,
                           obscureText : true, // yaz??lanlar gizlensin
                           hintText    : "??ifre", //ipucu metni
                         ),
                       ),
                       //------------------------------------------------------------------
                       SizedBox(height: deviceHeight(context) * 0.1), // textField'lar - giri?? butonu aras?? bo??luk           
                       //------------------------giri?? butonu------------------------------
                       ButtonWidget(
                         buttonColor: btnColor,
                         buttonText : "giri??",
                         buttonWidth: deviceWidth(context) * 0.52,// buton geni??li??i             
                         onPressed  : () async { 
                           
                           final progressUHD = ProgressHUD.of(context);
                           if(!isOffline) {
                            progressUHD.show();              
                           //----------------------USER DATASININ DOLDURULMASI-----------------------
                           final UserJsonModel userData = await userJsonFunc(txtUsername.text, txtPassword.text);
                           //------------------------------------------------------------------------
                       
                           
                           //---------------------------------------------------------------------------
                           String username = txtUsername.text; // Kullan??c?? Ad?? TextField'??n??n texti = username
                           String password = txtPassword.text; // ??ifre TextField'??n??n texti = password

                            if(userData==null){
                              showToast(context,"Kullan??c?? Ad?? veya ??ifre Yanl????");
                              progressUHD.dismiss();
                            }else{ // kullan??c?? ad?? ve ??ifre bo?? de??ilse
                           //--------------------S??PAR???? DATASININ DOLDURULMASI-------------------------             
                            OrderJsonModel orderData = await orderJsonFunc(globalDurumId,userData.user.id);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("user", username);     
                            prefs.setString("pass", password);                           
                            Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => 
                            HomePage(userData: userData, orderData: orderData)));
                           //t??kland??????nda anasayfaya y??nlendirilecek 
                            progressUHD.dismiss();
                           //do??ru giri??
                           showToast(context,"Giri?? ba??ar??l?? !");
                            }                           
                           }
                           else {               
                            await showAlert(context, "??nternet ba??lant??n??z?? kontrol ediniz.");
                           }
                         },
                       ),
                       ],
                         ),
                       ),
                       //------------------------------------------------------------------
                       
                       //------------------------------------------------------------------
                       //----------------------??ifremi unuttum butonu----------------------
                       // Flexible(
                       //     child    : Align(
                       //     alignment: Alignment.bottomCenter,// butonu en alta konumland??racak            
                       //       child  : TextButton(
                       //       child  : Text("??ifremi unuttum", // buton metni
                       //           style: TextStyle(
                       //           color     : Colors.white,
                       //           fontFamily: leadingFont,
                       //           fontSize  : 17)),
                       //           onPressed : () {
                                   
                       //           },
                       //     ),
                       //   ),
                       // ),
                       //------------------------------------------------------------------
                     ],
               ),
                   ),
                 ),
             ],
           ),
        ),
      ),
    );
  }
}
