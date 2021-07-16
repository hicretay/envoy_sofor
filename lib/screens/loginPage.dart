import 'dart:ui';
import 'package:connectivity/connectivity.dart';
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

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();


//--------------------Kullanıcı Giriş Kontrolü Fonksiyonu-----------------------


//------------------------------------------------------------------------------


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
              

                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                  return Column(
                    children:[
                      //--------------------Kullanıcı adı textField'ı---------------------
                      Padding(padding: const EdgeInsets.all(maxSpace),
                        child       : TextFieldWidget(textEditingController: txtUsername,
                        keyboardType: TextInputType.name,
                        hintText    : "Kullanıcı Adı", //ipucu metni
                        obscureText : false, // yazılanlar gizlenmesin
                      ),
                  ),
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
                    
                    var connectivityResult = Connectivity().checkConnectivity();
                    if(await connectivityResult != ConnectivityResult.none){

                    //----------------------USER DATASININ DOLDURULMASI-----------------------
                    final UserJsonModel userData = await userJsonFunc(uSERNAME, pASSWORD);
                    //------------------------------------------------------------------------
                
                    //--------------------SİPARİŞ DATASININ DOLDURULMASI-------------------------             
                    OrderJsonModel orderData = await orderJsonFunc(globalDurumId,userData.user.id);
                    //---------------------------------------------------------------------------

                    String username = txtUsername.text; // Kullanıcı Adı TextField'ının texti = username
                    String password = txtPassword.text; // Şifre TextField'ının texti = password

                    
                    if (username != "" && password != "") { // kullanıcı adı ve şifre boş değilse
                    
                    if(orderData.siparisList.length != 0){ // siparişler boş değilse anasayfaya yönlendir
                    progressUHD.show();
                    Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => 
                    HomePage(userData: userData, orderData: orderData)));
                    //tıklandığında anasayfaya yönlendirilecek 
                    progressUHD.dismiss();}}}

                    else {
                    progressUHD.dismiss();
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        content: Text("İnternet bağlantınızı kontrol ediniz.", style: TextStyle(fontFamily: contentFont)),
                        actions: <Widget>[
                           MaterialButton(
                           color: btnColor,
                           child: Text("Kapat",style: TextStyle(fontFamily: leadingFont)), // fotoğraf çekilmeye devam edilecek
                           onPressed: () async{
                             Navigator.of(context).pop();
                          }),
                          
                        ],
                      );
                    });
                    }
                  },
                ),
                ],
                  );
                }),
                //------------------------------------------------------------------
                
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
