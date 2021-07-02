import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/leadingContainerWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/orderRowWidget.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<Image> imagesFill = [];
  // image türünde image tutacak liste(yükleme)

  List<Image> imagesEmpty = [];
  // image türünde image tutacak liste(boşaltma)

  @override
  Widget build(BuildContext context) {
    List<List<String>> base64Doc = ModalRoute.of(context).settings.arguments;

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
                          OrderRowWidget(
                              leading: "şirket",
                              content:
                                  "AYHANLAR MADENCİLİK MÜHENDİSLİK OTOMOTİV NAKLİYAT İNŞAAT SANAYİ VE TİCARET LTD.ŞTİ."),
                          //------------------------------------------------------------
                          //------------------teslim tarihi satırı----------------------
                          OrderRowWidget(
                              leading: "teslim tarihi",
                              content: "23.06.2021 17:00"),
                          //------------------------------------------------------------
                          //-------------------dolum yeri satırı------------------------
                          OrderRowWidget(
                              leading: "dolum yeri", content: "mersin aytemiz"),
                          //------------------------------------------------------------
                          //----------------teslimat istasyonu satırı-------------------
                          OrderRowWidget(
                              leading: "teslimat istasyonu",
                              content: "MERSİN - AYHANLAR MADENCİLİK"),
                          //------------------------------------------------------------
                          //------------------teslimat adresi satırı--------------------
                          OrderRowWidget(
                              leading: "teslimat adresi", content: "Mersin"),
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
                          LeadingContainerWidget(leading: "depo içeriği"),
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
                          //-------------yükleme belgeleri başlık container'ı------------------
                          LeadingContainerWidget(leading: "yükleme belgeleri"),
                          //------------------------------------------------------------
                          //----------------yükleme belgeleri içeriği-------------------
                          Container(
                            height: deviceHeight(context) * 0.3,
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: maxSpace),
                              child: GridView.builder(
                                  itemCount: base64Doc[0].length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: maxSpace,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    for (var item in base64Doc[0]) {
                                      imagesFill.add(base64ToImage(item));
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/updateDocumentPage",
                                          arguments: imagesFill[index],
                                        );
                                      },
                                      child: imagesFill[index],
                                    );
                                  }),
                            ),
                          ),
                          //------------------------------------------------------------
                          SizedBox(height: maxSpace),
                          //-------------boşaltma belgeleri başlık container'ı---------
                          LeadingContainerWidget(leading: "boşaltma belgeleri"),
                          //------------------------------------------------------------
                          //----------------boşaltma belgeleri içeriği------------------
                          Container(
                            height: deviceHeight(context) * 0.3,
                            color: lightCardColor,
                            width: deviceWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.only(top: maxSpace),
                              child: GridView.builder(
                                  itemCount: base64Doc[1].length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: maxSpace,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    for (var item in base64Doc[1]) {
                                      imagesEmpty.add(base64ToImage(item));
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/updateDocumentPage",
                                          arguments: imagesEmpty[index],
                                        );
                                      },
                                      child: imagesEmpty[index],
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

/////////////////////////////////////////////////////////////////////////////////
class ImageGridWidget extends StatefulWidget {
  ImageGridWidget({Key key}) : super(key: key);

  @override
  _ImageGridWidgetState createState() => _ImageGridWidgetState();
}

class _ImageGridWidgetState extends State<ImageGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
