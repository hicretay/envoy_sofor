import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../settings/consts.dart';
import 'orderRowWidget.dart';

class OrdersCardWidget extends StatefulWidget {
  final VoidCallback onTap, fillOnTap, emptyOnTap;
  final String deliveryDate, fillingPoint, deliveryStation, status,totalLT;
  final Widget child;
  final Color statusColor;
  //
  OrdersCardWidget({
    Key key,
    this.onTap,
    this.deliveryDate,
    this.fillOnTap,
    this.emptyOnTap,
    this.fillingPoint,
    this.deliveryStation,
    this.status,
    this.totalLT,
    this.child, this.statusColor,
  }) : super(key: key);

  @override
  _OrdersCardWidgetState createState() => _OrdersCardWidgetState();
}

class _OrdersCardWidgetState extends State<OrdersCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      //--------------Slidable sağa kaydırılınca çıkacak görünüm----------------
      secondaryActions: [
        Container(
          decoration  : BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child       : IconSlideAction(
            iconWidget: Text("sipariş\ndetayı", style: cardTextStyle),
            color     : btnColor,
            onTap     : widget.onTap,
          ),
        ),
      ],
      //------------------------------------------------------------------------
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
            OrderRowWidget(
            leading: "teslim tarihi",
            content: widget.deliveryDate),
            //------------------------------------------------------------------
            //------------------------dolum yeri satırı-------------------------
            OrderRowWidget(
            leading: "dolum yeri",
            content: widget.fillingPoint),
            //------------------------------------------------------------------
            //-------------------teslimat istasyonu satırı----------------------
            OrderRowWidget(
            leading: "teslimat istasyonu",
            content: widget.deliveryStation),
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
                  Text(" :",style: TextStyle(color: Colors.white)),
                  Text(" ${widget.totalLT}",style: TextStyle(color: totalLtTxtColor)),
                ],
              ),
            ),
            //------------------------------------------------------------------
            //---------------------------durum satırı---------------------------
            Padding(
              padding : const EdgeInsets.all(minSpace),
              child   : Row(
              children: [
                  Container(
                    width: deviceWidth(context) * 0.35,
                    child: Text("durum", style: cardTextStyle),
                  ),
                  Text(" :",style: TextStyle(color: Colors.white)),
                  Text( widget.status,style: TextStyle(color: widget.statusColor),)
                    //durum card oluşturulurken alınacak                
                ],
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: defaultPadding),
            //butonlar - card arası üst boşluk
            Padding(padding: const EdgeInsets.all(minSpace), child: widget.child),
              //carda eklenecek butonlar child ile tanımlanacak          
            SizedBox(height: maxSpace),
            //butonlar - card arası alt boşluk
          ],
        ),
      ),
    );
  }
}
