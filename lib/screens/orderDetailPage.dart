import 'package:envoy/consts.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<Image> documents = [];
  // image türünde image tutacak liste
  //int counter;
  // toplam imageları tutacak liste

  @override
  Widget build(BuildContext context) {
    List<String> base64Doc = ModalRoute.of(context).settings.arguments;
    // homePage'den gelen base64 listeyi base64Doc adlı listeye atama
    //counter = base64Doc.length; //+ documents.length;
    //toplam imagelar base64Doc listesi ve document listesinin uzunluğu

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
                                    child:
                                        Text("şirket", style: cardTextStyle)),
                                Container(
                                  child: Text(" : ",
                                      style: TextStyle(color: Colors.white)),
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
                            height: deviceHeight(context) * 0.05,
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
                            height: deviceHeight(context) * 0.05,
                            color: checkDateColor,
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(" şoför onay tarihi",
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
                            height: deviceHeight(context) * 0.05,
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
                            height: deviceHeight(context) * 0.3,
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: maxSpace),
                              child: GridView.builder(
                                  itemCount: base64Doc.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: maxSpace,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    for (var item in base64Doc) {
                                      documents.add(base64ToImage(item));
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/updateDocumentPage",
                                          arguments: documents[index],
                                        );
                                      },
                                      child: documents[index],
                                    );
                                  }),
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: maxSpace),
                          //-------------boşaltma belgeleri container'ı------------------
                          Container(
                            width: deviceWidth(context),
                            height: deviceHeight(context) * 0.05,
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
                            height: deviceHeight(context) * 0.3,
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: maxSpace),
                              child: GridView.builder(
                                  itemCount: base64Doc.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: maxSpace,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    for (var item in base64Doc) {
                                      documents.add(base64ToImage(item));
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/updateDocumentPage",
                                          arguments: documents[index],
                                        );
                                      },
                                      child: documents[index],
                                    );
                                  }),
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
      bottomNavigationBar: LogoWidget(),
    );
  }
}
