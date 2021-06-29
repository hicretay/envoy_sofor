import 'package:flutter/material.dart';
import '../consts.dart';
import 'buttonWidget.dart';

class ConfirmCardWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const ConfirmCardWidget({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  _ConfirmCardWidgetState createState() => _ConfirmCardWidgetState();
}

class _ConfirmCardWidgetState extends State<ConfirmCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(maxSpace),
      ),
      elevation: 20.0,
      child: Column(
        children: [
          SizedBox(height: maxSpace),
          //----------------------teslim tarihi satırı------------------------
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: Row(
              children: [
                Container(
                  width: deviceWidth(context) * 0.35,
                  //teslim tarihi yazısının genişliği
                  child: Text("teslim tarihi", style: cardTextStyle),
                ),
                Text(" : 23.06.2021 17:00", style: contentTextStyle),
              ],
            ),
          ),
          //------------------------------------------------------------------
          //------------------------dolum yeri satırı-------------------------
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: Row(
              children: [
                Container(
                  width: deviceWidth(context) * 0.35,
                  //dolum yeri yazısının genişliği
                  child: Text("dolum yeri", style: cardTextStyle),
                ),
                Text(" : mersin aytemiz", style: contentTextStyle),
              ],
            ),
          ),
          //------------------------------------------------------------------
          //-------------------teslimat istasyonu satırı----------------------
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: Row(
              children: [
                Container(
                  width: deviceWidth(context) * 0.35,
                  //teslimat istasyonu yazısının genişliği
                  child: Text("teslimat istasyonu", style: cardTextStyle),
                ),
                Container(
                  child: Text(
                    ":",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: deviceWidth(context) * 0.55,
                  child: Text(" MERSİN - AYHANLAR MADENCİLİK",
                      style: contentTextStyle),
                ),
              ],
            ),
          ),
          //------------------------------------------------------------------
          //-----------------------toplam litre satırı------------------------
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: Row(
              children: [
                Container(
                  width: deviceWidth(context) * 0.35,
                  //toplam litre yazısının genişliği
                  child: Text("toplam litre", style: cardTextStyle),
                ),
                Text(
                  " : 100.00 LT",
                  style: TextStyle(color: totalLtTxtColor),
                  // litre yazı tipi
                ),
              ],
            ),
          ),
          //------------------------------------------------------------------
          //---------------------------durum satırı---------------------------
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: Row(
              children: [
                Container(
                  width: deviceWidth(context) * 0.35,
                  child: Text("durum", style: cardTextStyle),
                ),
                Text(
                  " : Yeni Sipariş",
                  style: TextStyle(color: Colors.white),
                  //durum card oluşturulurken alınacak
                ),
              ],
            ),
          ),
          //------------------------------------------------------------------
          SizedBox(height: defaultPadding),
          //butonlar - card arası üst boşluk
          Padding(
            padding: const EdgeInsets.all(minSpace),
            child: ButtonWidget(
                buttonText: "onayla",
                buttonWidth: deviceWidth(context),
                buttonColor: btnColor,
                onPressed: widget.onPressed),
            //carda eklenecek butonlar child ile tanımlanacak
          ),
          SizedBox(height: maxSpace),
          //butonlar - card arası alt boşluk
        ],
      ),
    );
  }
}
