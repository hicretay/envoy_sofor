import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/bgWidget.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

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
              width: 127, //ikon genişliğine göre verildi
              height: 71, //ikon yüksekliğine göre verildi
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/girisikon.png"),
                  //logo resmi
                  fit: BoxFit.cover,
                  // resim erkanı kaplayacak
                ),
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: defaultPadding),
            //logo - giriş ikonu arası boşluk
            //-------------------logo svg'sinin gösterilmesi--------------------
            SvgPicture.asset(
              "assets/images/logo.svg",
              color: logoColor,
            ),
            //------------------------------------------------------------------
            SizedBox(height: deviceHeight(context) * 0.2),
            //logo - textFieldlar arası boşluk
            //--------------------Kullanıcı adı textField'ı---------------------
            Padding(
              padding: const EdgeInsets.all(maxSpace),
              child: TextFieldWidget(
                textEditingController: txtUsername,
                keyboardType: TextInputType.name,
                hintText: "Kullanıcı Adı", //ipucu metni
                obscureText: false, // yazılanlar gizlenmesin
              ),
            ),
            //------------------------------------------------------------------
            //-------------------------Şifre textField'ı------------------------
            Padding(
              padding: const EdgeInsets.all(maxSpace),
              child: TextFieldWidget(
                textEditingController: txtPassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // yazılanlar gizlensin
                hintText: "Şifre", //ipucu metni
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: deviceHeight(context) * 0.1),
            // textField'lar - giriş butonu arası boşluk

            //------------------------giriş butonu------------------------------
            ButtonWidget(
              buttonColor: btnColor,
              buttonText: "giriş",
              buttonWidth: deviceWidth(context) * 0.52,
              // buton genişliği
              onPressed: () {                
                Navigator.pushNamedAndRemoveUntil(
                    context, "/homePage", (route) => false);
                //tıklandığında anasayfaya yönlendirilecek
              },
            ),
            //------------------------------------------------------------------
            //----------------------şifremi unuttum butonu----------------------
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                // butonu en alta konumlandıracak
                child: TextButton(
                  child: Text(
                    "şifremi unuttum", // buton metni
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: leadingFont,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () {},
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
