import 'package:envoy/consts.dart';
import 'package:envoy/widgets/documentViewWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sipariş detay", style: leadingStyle),
      ),
      body: Container(
        color: bgColor,
        child: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: maxSpace), // card - üst ekran arası boşluk
                    Card(
                      shape: RoundedRectangleBorder(
                        // card kenarlarının yuvarlatılması
                        borderRadius: BorderRadius.circular(maxSpace),
                      ),
                      color: darkCardColor,
                      elevation: 20.0,
                      child: Column(
                        children: [
                          SizedBox(height: maxSpace),
                          // card - içerik arası boşluk
                          //-------------------şirket bilgisi satırı--------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  // şirket yazısı genişliği
                                  child: Text("şirket", style: cardTextStyle),
                                ),
                                Container(
                                  child: Text(
                                    " : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: deviceWidth(context) * 0.55,
                                  // açıklama yazısı genişliği
                                  child: Text(
                                    "AYHANLAR MADENCİLİK MÜHENDİSLİK OTOMOTİV NAKLİYAT İNŞAAT SANAYİ VE TİCARET LTD.ŞTİ.",
                                    style: contentTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          //------------------teslim tarihi satırı----------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  child: Text(
                                    "teslim tarihi",
                                    style: cardTextStyle,
                                  ),
                                ),
                                Text(
                                  " : 23.06.2021 17:00",
                                  style: contentTextStyle,
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          //-------------------dolum yeri satırı------------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  child: Text(
                                    "dolum yeri",
                                    style: cardTextStyle,
                                  ),
                                ),
                                Text(
                                  " : mersin aytemiz",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          //----------------teslimat istasyonu satırı-------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  child: Text(
                                    "teslimat istasyonu",
                                    style: cardTextStyle,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    " : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: deviceWidth(context) * 0.5,
                                  child: Text(
                                    "MERSİN - AYHANLAR MADENCİLİK",
                                    style: contentTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          //------------------teslimat adresi satırı--------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  child: Text(
                                    "teslimat adresi",
                                    style: cardTextStyle,
                                  ),
                                ),
                                Text(
                                  " : Mersin",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          //-------------------toplam litre satırı----------------------
                          Padding(
                            padding: const EdgeInsets.all(minSpace),
                            child: Row(
                              children: [
                                Container(
                                  width: deviceWidth(context) * 0.35,
                                  child: Text(
                                    "toplam litre",
                                    style: cardTextStyle,
                                  ),
                                ),
                                Text(
                                  " : 1000.00 LT",
                                  style: TextStyle(color: totalLtTxtColor),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: minSpace),
                          // divider - satırlar arası boşluk
                          Divider(color: Colors.grey),
                          // satırlar - depo içeriği arası çizgi

                          //------------depo içeriği başlık containerı------------------
                          Container(
                            width: deviceWidth(context),
                            height: 22,
                            color: btnColor,
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text(" depo içeriği", style: cardTextStyle),
                              ),
                            ),
                          ),
                          //------------------------------------------------------------
                          //--------------depo içeriği içerik containerı----------------
                          Container(
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Column(
                              children: [
                                SizedBox(height: maxSpace),
                                // üst boşluk
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("motorin", style: cardTextStyle),
                                    Text("500 LT", style: contentTextStyle),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("benzin", style: cardTextStyle),
                                    Text("500 LT", style: contentTextStyle),
                                  ],
                                ),
                                SizedBox(height: maxSpace),
                                //alt boşluk
                              ],
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: maxSpace),
                          //depo içeriği açıklması - şöför onay tarihi arası boşluk
                          //------------şöför onay tarihi container'ı-------------------
                          Container(
                            width: deviceWidth(context),
                            height: 22,
                            color: checkDateColor,
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(" şöför onay tarihi",
                                        style: cardTextStyle),
                                    Text("23.06.2021 17:00 ",
                                        style: contentTextStyle),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: maxSpace),
                          // şöför onay tarihi - yükleme belgeleri arası boşluk
                          //-------------yükleme belgeleri container'ı------------------
                          Container(
                            width: deviceWidth(context),
                            height: 22,
                            color: btnColor,
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(" yükleme belgeleri",
                                    style: cardTextStyle),
                              ),
                            ),
                          ),
                          //------------------------------------------------------------
                          //----------------yükleme belgeleri içeriği-------------------
                          Container(
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  DocumentViewWidget(),
                                  DocumentViewWidget(),
                                  DocumentViewWidget(),
                                ],
                              ),
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: maxSpace),
                          //-------------boşaltma belgeleri container'ı------------------
                          Container(
                            width: deviceWidth(context),
                            height: 22,
                            color: btnColor,
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(" boşaltma belgeleri",
                                    style: cardTextStyle),
                              ),
                            ),
                          ),
                          //------------------------------------------------------------
                          //----------------boşaltma belgeleri içeriği-------------------
                          Container(
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  DocumentViewWidget(),
                                  DocumentViewWidget(),
                                  DocumentViewWidget(),
                                ],
                              ),
                            ),
                          ),
                          //-----------------------------------------------------------
                        ],
                      ),
                    ),
                    //LogoWidget(),
                    // Altta yer alan uygulama logosu
                  ],
                ),
              ),
            ),
            SizedBox(height: maxSpace),
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


