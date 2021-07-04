import 'package:envoy/settings/consts.dart';
import 'package:flutter/material.dart';

import 'orderRowWidget.dart';

class OrderDetailCardWidget extends StatelessWidget {
  final String company, deliveryDate, fillingPoint, deliveryStation, deliveryAddress, totalLT ;
  const OrderDetailCardWidget({
    Key key,
    this.company, this.deliveryDate, this.fillingPoint, this.deliveryStation, this.deliveryAddress, this.totalLT,
  }) : super(key: key);

  //final OrderDetailJsonModel orderDetailData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //-------------------şirket bilgisi satırı--------------------
        OrderRowWidget(
            leading: "şirket",
            content: company),
        //------------------teslim tarihi satırı----------------------
        OrderRowWidget(
            leading: "teslim tarihi",
            content: deliveryDate),
        //------------------------------------------------------------
        //-------------------dolum yeri satırı------------------------
        OrderRowWidget(
            leading: "dolum yeri",
            content: fillingPoint),
        //------------------------------------------------------------
        //----------------teslimat istasyonu satırı-------------------
        OrderRowWidget(
            leading: "teslimat istasyonu",
            content: deliveryStation),
        //------------------------------------------------------------
        //------------------teslimat adresi satırı--------------------
        OrderRowWidget(
            leading: "teslimat adresi",
            content: deliveryAddress),
        //------------------------------------------------------------
        //-------------------toplam litre satırı----------------------
        Padding(
          padding: const EdgeInsets.all(minSpace),
          child: Row(
            children: [
              Container(
                width: deviceWidth(context) * 0.35,
                child: Text("toplam litre",style: cardTextStyle,),
              ),
              Text(" : ",style:TextStyle(color: Colors.white)),
              Text(totalLT,style:TextStyle(color: totalLtTxtColor)),
            ],
          ),
        ),
      ],
    );
  }
}