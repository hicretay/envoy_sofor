import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/homePage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/functions.dart';
import 'package:envoy/widgets/bgWidget.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
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

  SharedPreferences loginData;
  bool newUser;

  void checkLogin() async {
    final String uSERNAME = "sselman";
    final String pASSWORD = "0";
    final UserJsonModel userData = await userJsonFunc(uSERNAME, pASSWORD);
    final int durumId = 1;
    final OrderJsonModel orderData = await orderJsonFunc(durumId, userData.user.id);

    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage(orderData: orderData,userData: userData)));
    }
  }
 
  @override
  void initState() { 
    super.initState();
    setState(() {
      checkLogin(); 
    });
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
      body: BgWidget(
        child: Column(
          children: [
            SizedBox(height: deviceHeight(context) * 0.2),
            //giriş ikonu - cihaz üstü boşluk
            //--------------giriş ikonunun yer alacağı container----------------
            Container(
              width : 127, //ikon genişliğine göre verildi
              height: 71, //ikon yüksekliğine göre verildi
              decoration: BoxDecoration(
                  image : DecorationImage(
                  image : AssetImage("assets/images/girisikon.png"),//logo resmi                 
                  fit   : BoxFit.cover,
                  // resim erkanı kaplayacak
                ),
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: defaultPadding),
            //logo - giriş ikonu arası boşluk
            //-------------------logo svg'sinin gösterilmesi--------------------
            SvgPicture.asset("assets/images/logo.svg", color: logoColor),
            //------------------------------------------------------------------
            SizedBox(height: deviceHeight(context) * 0.2),
            //logo - textFieldlar arası boşluk
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
            SizedBox(height: deviceHeight(context) * 0.1),
            // textField'lar - giriş butonu arası boşluk

            //------------------------giriş butonu------------------------------
            ButtonWidget(
              buttonColor: btnColor,
              buttonText : "giriş",
              buttonWidth: deviceWidth(context) * 0.52,// buton genişliği             
              onPressed  : () async {
               
                
                //------------------login verisinin çekilmesi-------------------
                final String uSERNAME = "sselman";
                final String pASSWORD = "0";
                final UserJsonModel userData = await userJsonFunc(uSERNAME, pASSWORD);
                //--------------------------------------------------------------

                //----------------sipariş verisinin çekilmesi-------------------
                final int durumId = 1;
                final OrderJsonModel orderData = await orderJsonFunc(durumId, userData.user.id);
                //--------------------------------------------------------------

                String username = txtUsername.text;
                String password = txtPassword.text;

                if (username != '' && password != '') {
                  loginData.setBool('login', false);
                  loginData.setString('username', username);
                
                if(orderData.siparisList.length != 0){
                Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => 
                HomePage(userData: userData, orderData: orderData)));
                //tıklandığında anasayfaya yönlendirilecek    
                          
                }}
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
    );
  }
}
