import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../consts.dart';
import 'buttonWidget.dart';

class FillEmptyCardWidget extends StatefulWidget {
  final VoidCallback onTap;

  FillEmptyCardWidget({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  _FillEmptyCardWidgetState createState() => _FillEmptyCardWidgetState();
}

class _FillEmptyCardWidgetState extends State<FillEmptyCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),

      //--------------Slidable sağa kaydırılınca çıkacak görünüm----------------
      secondaryActions: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: IconSlideAction(
            iconWidget: Text("sipariş\ndetayı", style: cardTextStyle),
            color: btnColor,
            onTap: widget.onTap,
          ),
        ),
      ],
      //----------------------------------------------------------------------
      child: Card(
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
                    " : Onaylandı",
                    style: TextStyle(color: checkedTxtColor),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //------------------doldur butonu---------------------
                  ButtonWidget(
                    buttonText: "doldur",
                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                    buttonColor: btnColor,
                    onPressed: () {},
                  ),
                  //----------------------------------------------------
                  //------------------boşalt butonu---------------------
                  ButtonWidget(
                    buttonText: "boşalt",
                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                    buttonColor: checkDateColor,
                    onPressed: () {},
                  ),
                  //----------------------------------------------------
                ],
              ),
              //carda eklenecek butonlar child ile tanımlanacak
            ),
            SizedBox(height: maxSpace),
            //butonlar - card arası alt boşluk
          ],
        ),
      ),
    );
  }
}
