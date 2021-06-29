import 'package:envoy/consts.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/ordersCardWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------------------Appbar Stili----------------------------------
      appBar: AppBar(
        title: Text(
          "siparişler",
          style: leadingStyle, // text stili
        ),
      ),
      //------------------------------------------------------------------------
      body: Container(
        color: bgColor, // arkaplan rengi
        child: Column(
          children: [
            SizedBox(height: maxSpace),
            Flexible(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    OrdersCardWidget(
                      orderStatus: "Yeni Sipariş",
                      textColor: Colors.white,
                      child: ButtonWidget(
                        buttonText: "onayla",
                        buttonWidth: deviceWidth(context),
                        buttonColor: btnColor,
                        onPressed: () {},
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/orderDetailPage");
                        // Slidable'a tıklandığında sipariş detaya gidecek
                      },
                    ),
                    OrdersCardWidget(
                      orderStatus: "Onaylandı",
                      textColor: checkedTxtColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //------------------doldur butonu---------------------
                          ButtonWidget(
                            buttonText: "doldur",
                            buttonWidth:
                                deviceWidth(context) * 0.46, // buton genişliği
                            buttonColor: btnColor,
                            onPressed: () {},
                          ),
                          //----------------------------------------------------
                          //------------------boşalt butonu---------------------
                          ButtonWidget(
                            buttonText: "boşalt",
                            buttonWidth:
                                deviceWidth(context) * 0.46, // buton genişliği
                            buttonColor: checkDateColor,
                            onPressed: () {},
                          ),
                          //----------------------------------------------------
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/orderDetailPage");
                        // Slidable'a tıklandığında sipariş detaya gidecek
                      },
                    ),
                  ],
                ),
              ),
            ),
            // alttaki logo görünümü
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: bgColor,
        height: 50,
        child: LogoWidget(),
      ),
    );
  }
}
