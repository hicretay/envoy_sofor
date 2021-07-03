import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/leadingContainerWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/orderDetailCardWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetailPage extends StatefulWidget {
  final OrderDetailJsonModel orderDetailData;
  List<List<String>> base64Doc = [];
  OrderDetailPage({Key key, this.orderDetailData, this.base64Doc})
      : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState(
      orderDetailData: orderDetailData, base64Doc: base64Doc);
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<List<String>> base64Doc = [];
  OrderDetailJsonModel orderDetailData;
  _OrderDetailPageState({this.orderDetailData, this.base64Doc});

  List<Image> imagesFill = [];
  // image türünde image tutacak liste(yükleme)

  List<Image> imagesEmpty = [];
  // image türünde image tutacak liste(boşaltma)

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
                    Padding(
                      padding: const EdgeInsets.all(minSpace),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          // card kenarlarının yuvarlatılması
                          borderRadius: BorderRadius.circular(maxSpace),
                        ),
                        color: darkCardColor,
                        elevation: 30.0,
                        child: Column(
                          children: [
                            SizedBox(height: maxSpace), // card - içerik arası boşluk
                            OrderDetailCardWidget(
                              company        : orderDetailData.siparisDetay.siparisDetay.sirket,
                              deliveryDate   : orderDetailData.siparisDetay.siparisDetay.teslimTarihi,
                              fillingPoint   : orderDetailData.siparisDetay.siparisDetay.dolumyeri,
                              deliveryStation: orderDetailData.siparisDetay.siparisDetay.teslimatIstasyonu,
                              deliveryAddress: orderDetailData.siparisDetay.siparisDetay.teslimatAdresi,
                              totalLT        : orderDetailData.siparisDetay.siparisDetay.toplamLitre,
                              ),
                            //------------------------------------------------------------

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
                                child: Padding(
                                  padding: const EdgeInsets.only(top: maxSpace,bottom: maxSpace),
                                  child: ListView.builder(
                                      shrinkWrap : true,
                                      itemCount  : orderDetailData.siparisDetay.depoIcerigi.length,
                                      itemBuilder:(BuildContext context, int index){
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: maxSpace),
                                              child  : Text(orderDetailData.siparisDetay.depoIcerigi[index].yakitTipi,style: cardTextStyle),
                                            ),
                                            SizedBox(width: deviceWidth(context)*0.3),
                                            Text(orderDetailData.siparisDetay.depoIcerigi[index].litre,style: contentTextStyle)
                                          ],
                                        );
                                      }),
                                )),
                            //------------------------------------------------------------
                            SizedBox(height: maxSpace),
                            //depo içeriği açıklması - şöför onay tarihi arası boşluk
                            //------------şöför onay tarihi container'ı-------------------
                            Container(
                              width : deviceWidth(context),
                              height: deviceHeight(context) * 0.05,
                              color : checkDateColor,
                              child : Center(child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" şoför onay tarihi",style: cardTextStyle),
                                      Padding(padding: const EdgeInsets.only(right: minSpace),
                                        child: Text(orderDetailData.siparisDetay.soforonayTarihi,style: contentTextStyle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //------------------------------------------------------------
                            SizedBox(height: maxSpace),
                            // şöför onay tarihi - yükleme belgeleri arası boşluk
                            //-------------yükleme belgeleri başlık container'ı------------------
                            LeadingContainerWidget(
                                leading: "yükleme belgeleri"),
                            //------------------------------------------------------------
                            //----------------yükleme belgeleri içeriği-------------------
                            Container(
                              height: deviceHeight(context) * 0.3,
                              color : lightCardColor,
                              width : deviceWidth(context),
                              child : Padding(padding: const EdgeInsets.only(top: maxSpace),
                                    child       : GridView.builder(
                                    itemCount   : base64Doc[0].length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: maxSpace,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      for (var item in base64Doc[0]) {
                                        imagesFill.add(base64ToImage(item));
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,"/updateDocumentPage", arguments: imagesFill[index]);
                                        },
                                        child: imagesFill[index],
                                      );
                                    }),
                              ),
                            ),
                            //------------------------------------------------------------
                            SizedBox(height: maxSpace),
                            //-------------boşaltma belgeleri başlık container'ı---------
                            LeadingContainerWidget(
                                leading: "boşaltma belgeleri"),
                            //------------------------------------------------------------
                            //----------------boşaltma belgeleri içeriği------------------
                            Container(
                              height: deviceHeight(context) * 0.3,
                              color : lightCardColor,
                              width : deviceWidth(context),
                              child : Padding(padding: const EdgeInsets.only(top: maxSpace),
                              child : GridView.builder(
                                    itemCount: base64Doc[1].length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: maxSpace),
                                    itemBuilder:(BuildContext context, int index){
                                      for (var item in base64Doc[1]) {
                                        imagesEmpty.add(base64ToImage(item));
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed( context,"/updateDocumentPage",arguments: imagesEmpty[index]);
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
                    ),
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


