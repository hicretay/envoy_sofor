import 'dart:ui';

import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/homePage.dart';
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

  SharedPreferences loginData; // SharedPreferences nesnesi
  bool newUser; // Kullanıcı aktif ise false değilse true verilecek

//--------------------Kullanıcı Giriş Kontrolü Fonksiyonu-----------------------
  void checkLogin() async {
    //---------------kullanıcı ve sipariş verilerinin çekilmesi-----------------
    final String uSERNAME = "sselman";
    final String pASSWORD = "0";
    final int durumId = 1;
    final UserJsonModel  userData  = await userJsonFunc(uSERNAME, pASSWORD); // kullanıcı verileri
    final OrderJsonModel orderData = await orderJsonFunc(durumId, userData.user.id); // sipariş verileri
    //--------------------------------------------------------------------------

    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool('login') ?? true; // login olunmamışsa true 
    if (newUser == false) { // daha önceden login olunmuşsa false
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
      HomePage(orderData: orderData,userData: userData)));
      // kullanıcı giriş yapmışsa direkt HomePage 'e gidecek
    }
  }
//------------------------------------------------------------------------------

  @override
  void initState() { 
    super.initState();
    setState(() {
      checkLogin(); // Sayfa yüklenirken kullanıcı giriş kontrolü yapılacak     

    });
    
  }

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    
  }

  @override
  void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(builder:(context)=>
           BgWidget(
            child: Column(
              children: [
                SizedBox(height: deviceHeight(context) * 0.2), // giriş ikonu - cihaz üstü boşluk          
                //--------------giriş ikonunun yer alacağı container----------------
                Container(
                  width : 127, //ikon genişliğine göre verildi
                  height: 71, //ikon yüksekliğine göre verildi
                  decoration: BoxDecoration(
                      image : DecorationImage(
                      image : AssetImage("assets/images/girisikon.png"), //logo resmi                 
                      fit   : BoxFit.cover, // resim erkanı kaplayacak                 
                    ),
                  ),
                ),
                //------------------------------------------------------------------
                SizedBox(height: defaultPadding), // logo - giriş ikonu arası boşluk          
                SvgPicture.asset("assets/images/logo.svg", color: logoColor),  // logo svg'sinin gösterilmesi           
                SizedBox(height: deviceHeight(context) * 0.2),  //logo - textFieldlar arası boşluk   

                //--------------------Kullanıcı adı textField'ı---------------------
                Padding(padding: const EdgeInsets.all(maxSpace),
                    child       : TextFieldWidget(textEditingController: txtUsername,
                    keyboardType: TextInputType.name,
                    hintText    : "Kullanıcı Adı", //ipucu metni
                    obscureText : false, // yazılanlar gizlenmesin
                  ),
                ),
                //------------------------------------------------------------------
                //-------------------------Şifre textField'ı------------------------
                Padding(padding: const EdgeInsets.all(maxSpace),
                    child: TextFieldWidget(
                    textEditingController: txtPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText : true, // yazılanlar gizlensin
                    hintText    : "Şifre", //ipucu metni
                  ),
                ),
                //------------------------------------------------------------------
                SizedBox(height: deviceHeight(context) * 0.1), // textField'lar - giriş butonu arası boşluk           
                //------------------------giriş butonu------------------------------
                ButtonWidget(
                  buttonColor: btnColor,
                  buttonText : "giriş",
                  buttonWidth: deviceWidth(context) * 0.52,// buton genişliği             
                  onPressed  : () async { 
                    final progressUHD = ProgressHUD.of(context);              
                    //------------------login verisinin çekilmesi-------------------
                    final String uSERNAME = "sselman";
                    final String pASSWORD = "0";
                    final UserJsonModel userData = await userJsonFunc(uSERNAME, pASSWORD);
                    //--------------------------------------------------------------

                    //----------------sipariş verisinin çekilmesi-------------------
                    final int durumId = 1;
                    final OrderJsonModel orderData = await orderJsonFunc(durumId, userData.user.id);
                    //--------------------------------------------------------------

                    String username = txtUsername.text; // Kullanıcı Adı TextField'ının texti = username
                    String password = txtPassword.text; // Şifre TextField'ının texti = password

                    
                    if (username != "" && password != "") { // kullanıcı adı ve şifre boş değilse
                      loginData.setBool("login", false); // login işlemi yapıldı
                      loginData.setString("username", username);
                    
                    if(orderData.siparisList.length != 0){ // siparişler boş değilse anasayfaya yönlendir
                    progressUHD.show();
                    Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => 
                    HomePage(userData: userData, orderData: orderData)));
                    //tıklandığında anasayfaya yönlendirilecek 
                    progressUHD.dismiss();                            
                    }
                    // Boş ise beklet
                    else progressUHD.dismiss();
                    }
                  },
                ),
                //------------------------------------------------------------------
                //----------------------şifremi unuttum butonu----------------------
                Flexible(
                    child    : Align(
                    alignment: Alignment.bottomCenter,// butonu en alta konumlandıracak            
                      child  : TextButton(
                      child  : Text("şifremi unuttum", // buton metni
                          style: TextStyle(
                          color     : Colors.white,
                          fontFamily: leadingFont,
                          fontSize  : 17)),
                          onPressed : () {
                            
                          },
                    ),
                  ),
                ),
                //------------------------------------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }
}
