import 'dart:async';
import 'package:envoy/models/orderDetailJsonModel.dart';
import 'package:envoy/models/userJsonModel.dart';
import 'package:envoy/screens/updateDocumentPage.dart';
import 'package:envoy/settings/connection.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/settings/functions.dart';
import 'package:envoy/widgets/leadingContainerWidget.dart';
import 'package:envoy/widgets/leadingDateContainerWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/orderDetailCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class OrderDetailPage extends StatefulWidget {
  final OrderDetailJsonModel orderDetailData;
  final UserJsonModel userData;

   List<String> base64DocFill = [];
  // base64 images listesi (yükleme)

  List<String> base64DocEmpty = [];
  // base64 images listesi (boşaltma)
  OrderDetailPage({Key key, this.orderDetailData,this.base64DocEmpty,this.base64DocFill, this.userData}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState(orderDetailData: orderDetailData,base64DocEmpty: base64DocEmpty,base64DocFill: base64DocFill,userData: userData);
}

class _OrderDetailPageState extends State<OrderDetailPage> {
   List<String> base64DocFill = [];
  // base64 images listesi (yükleme)

  List<String> base64DocEmpty = [];
  // base64 images listesi (boşaltma)

  List<String> base = [];

  OrderDetailJsonModel orderDetailData;
  UserJsonModel userData;
  _OrderDetailPageState({this.orderDetailData, this.base64DocEmpty, this.base64DocFill, this.userData});

  List<Belgeleri> docEmpty = [];
  List<Belgeleri> docFill = [];
  //--------------------Sipariş Listesi Yenileme Fonksiyonu-----------------------
  Future refreshList() async {
    final OrderDetailJsonModel orderList = await orderDetailJsonFunc(orderDetailData.siparisDetay.siparisDetay.id); 
    setState(() {
      orderDetailData = orderList;
    });
  }
//------------------------------------------------------------------------------

  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() { 
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
        _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
        isOffline = !hasConnection;
    });
}
 @override
   void dispose() {
     _connectionChangeStream.cancel();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {    
    imageCache.clearLiveImages();
    imageCache.clear();
    // Listeleri servis verileri ile doldurma
    docEmpty= orderDetailData.siparisDetay.bosaltmaBelgeleri;
    docFill= orderDetailData.siparisDetay.yuklemeBelgeleri;
    return Scaffold(
      appBar: AppBar(title: Text("sipariş detay", style: leadingStyle)),
      body: ProgressHUD(
        child: Builder(builder: (context)=>
            Container(
            color: bgColor,
            child: Column(children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: maxSpace), // card - üst ekran arası boşluk
                        Padding(padding: const EdgeInsets.all(minSpace),
                          child: Card(
                            shape    : RoundedRectangleBorder(borderRadius: BorderRadius.circular(maxSpace)),
                            // card kenarlarının yuvarlatılması
                            color     : darkCardColor,
                            elevation : 30.0,
                              child   : Column(
                              children: [
                                SizedBox(height: maxSpace), // card - içerik arası boşluk
                                //------------------------------Sipariş Detay Card İçeriği-------------------------------------
                                OrderDetailCardWidget(
                                  company        : orderDetailData.siparisDetay.siparisDetay.sirket,
                                  deliveryDate   : orderDetailData.siparisDetay.siparisDetay.teslimTarihi,
                                  fillingPoint   : orderDetailData.siparisDetay.siparisDetay.dolumyeri,
                                  deliveryStation: orderDetailData.siparisDetay.siparisDetay.teslimatIstasyonu,
                                  deliveryAddress: orderDetailData.siparisDetay.siparisDetay.teslimatAdresi,
                                  totalLT        : orderDetailData.siparisDetay.siparisDetay.toplamLitre,
                                  ),
                                //-----------------------------------------------------------------------------------------------
                                SizedBox(height: minSpace), // divider - satırlar arası boşluk                          
                                Divider(color: Colors.grey), // satırlar - depo içeriği arası çizgi
                                
                                //------------depo içeriği başlık containerı------------------
                                LeadingContainerWidget(leading: "depo içeriği"),
                                //------------------------------------------------------------
                                //---------------------------------depo içeriği içerik containerı---------------------------------------
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
                                                Padding(padding: const EdgeInsets.only(left: maxSpace), child: 
                                                Text(orderDetailData.siparisDetay.depoIcerigi[index].yakitTipi.toLowerCase(),style: cardTextStyle)), // Yakıt Tipi
                                                SizedBox(width: deviceWidth(context)*0.3),
                                                Text(orderDetailData.siparisDetay.depoIcerigi[index].litre,style: contentTextStyle), // Yakıt Miktarı
                                              ],
                                            );
                                          }),
                                    )),
                                //-------------------------------------------------------------------------------------------
                                SizedBox(height: maxSpace), // depo içeriği açıklması - şöför onay tarihi arası boşluk
                                //------------------------------------------------------şöför onay tarihi container'ı-----------------------------------------------------------
                                LeadingDateContainerWidget(containerColor: checkDateColor,content: orderDetailData.siparisDetay.soforonayTarihi,leading: "şoför onay tarihi",),
                                //---------------------------------------------------------------------------------------------------------------------------------------------
                                SizedBox(height: maxSpace), // şöför onay tarihi - yükleme belgeleri arası boşluk

                                //-----------------------------------------------yükleme belgeleri başlık container'ı--------------------------------------------------------------
                                LeadingDateContainerWidget(containerColor: btnColor,leading: "yükleme belgeleri",content: docFill.isNotEmpty? orderDetailData.siparisDetay.yuklemeBelgeleri.last.tarih : "",),
                                //-------------------------------------------------------------------------------------------------------------------------------------------------
                                //-----------------------------------------------------yükleme belgeleri içeriği-------------------------------------------------------------------
                                Container(
                                  height: deviceHeight(context) * 0.3,
                                  color : lightCardColor,
                                  width : deviceWidth(context),
                                  child : Padding(padding: const EdgeInsets.only(top: maxSpace),
                                        child       : GridView.builder(
                                        itemCount   : docFill.length + 1, // Fotoğrafların uzunluğu + ekle butonu
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount : 4,
                                          mainAxisSpacing: maxSpace,
                                        ),
                                        itemBuilder: (BuildContext context, int index) {
                                          if(index == docFill.length){ // index dökümanların uzunluğu kadar ise ekleme butonunu çizdir
                                          //----------------------------------GRİDVİEWDEN FOTOĞRAF EKLE BUTONU (DOLDUR)-----------------------------------
                                            return GestureDetector(
                                              child: Column(children: [
                                                Container(height: deviceHeight(context)*0.23,width: deviceWidth(context)*0.175,color: bgColor,child: 
                                                Column(children: [
                                                  SizedBox(height: deviceHeight(context)*0.05),
                                                  Icon(Icons.image,color: btnColor,size: 30),
                                                  Text("Ekle",style: contentTextStyle),
                                                  ]))]),

                                              onTap: ()async{
                                                final progressUHD = ProgressHUD.of(context);
                                                if(!isOffline){
                                                progressUHD.show();
                                                if(orderDetailData.siparisDetay.siparisDetay.durumId == 4 || orderDetailData.siparisDetay.siparisDetay.durumId == 3){ 
                                                  await uploadSelectedImage(ImageSource.camera, base64DocFill);
                                                  if(base64DocFill.length != 0){                                            
                                                  await documentJsnAddFunc(orderDetailData.siparisDetay.siparisDetay.id, userData.user.id, orderDetailData.siparisDetay.siparisDetay.durumId == 4 ? orderDetailData.siparisDetay.siparisDetay.durumId-1 :orderDetailData.siparisDetay.siparisDetay.durumId, -1, base64DocFill.first);
                                                  showToast(context,"DOLDURMA belgesi eklendi !");
                                                  imageCache.clear(); // İmage önbelleğini temizleme
                                                  imageCache.clearLiveImages();
                                                  refreshList();
                                                  base64DocFill.clear();} 
                                                  else
                                                  {
                                                    showToast(context,"DOLDURMA belgesi eklenmedi !");
                                                  }
                                                } 
                                                 else{
                                                  showToast(context,"Doldur butonunu kullanınız !");
                                                }
                                                progressUHD.dismiss();
                                              }
                                              else{
                                                 showAlert(context, "İnternet bağlantınızı kontrol ediniz.");
                                              }},
                                            );
                                            //-----------------------------------------------------------------------------------------------------------
                                          }
                                          // fotoğrafları listeye doldurma
                                          //------------------------------- FOTOĞRAFLAR (DOLDURMA FOTOĞRAFLARI)------------------------------------
                                          return GestureDetector(
                                            child: Image.network(docFill[index].belgeLink, // doldurma fotoğrafının linki
                                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) return child; // fotoğraf yüklenirken circular döndürme
                                                return Center(
                                                child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null 
                                                ?  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                : null,
                                              ));
                                            }
                                            ),
                                            onTap: () async{ 
                                              final progressUHD = ProgressHUD.of(context);
                                              if(!isOffline){
                                              progressUHD.show();                                                                               
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                                              UpdateDocumentPage(img: docFill[index],userData: userData, orderDetailData: orderDetailData))); 
                                              // döküman güncelleme sayfasına yönlendirme
                                              progressUHD.dismiss();
                                            }
                                            else{
                                                 showAlert(context, "İnternet bağlantınızı kontrol ediniz.");
                                              }
                                            },
                                          );
                                          //-----------------------------------------------------------------------------------------------------------------------
                                        }),
                                  ),
                                ),
                                //------------------------------------------------------------
                                SizedBox(height: maxSpace),
                                //-------------boşaltma belgeleri başlık container'ı---------
                                LeadingDateContainerWidget(containerColor: btnColor,leading: "boşaltma belgeleri",content: docEmpty.isNotEmpty? orderDetailData.siparisDetay.bosaltmaBelgeleri.last.tarih : ""),
                                //------------------------------------------------------------
                                //----------------boşaltma belgeleri içeriği------------------
                                Container(
                                  height: deviceHeight(context) * 0.3,
                                  color : lightCardColor,
                                  width : deviceWidth(context),
                                  child : Padding(padding: const EdgeInsets.only(top: maxSpace),
                                  child : GridView.builder(
                                        itemCount: docEmpty.length + 1, // Fotoğrafların uzunluğu + ekle butonu
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: maxSpace),
                                        itemBuilder:(BuildContext context, int index){

                                          if(index == docEmpty.length){ // index dökümanların uzunluğu kadar ise ekleme butonunu çizdir
                                            //---------------------------------GRİDVİEWDEN FOTOĞRAF EKLE BUTONU (BOŞALT)---------------------------------------
                                            return GestureDetector(
                                              child: Column(children: [
                                                Container(height: deviceHeight(context)*0.23,width:deviceWidth(context)*0.175,color: bgColor,child: 
                                                Column(children: [
                                                  SizedBox(height: deviceHeight(context)*0.05),
                                                  Icon(Icons.image,color: btnColor,size: 30),
                                                  Text("Ekle",style: contentTextStyle),
                                                  ]))]),
                                              
                                               onTap: ()async{
                                                  final progressUHD = ProgressHUD.of(context);
                                                  if(!isOffline){
                                                  progressUHD.show(); 
                                                  if(orderDetailData.siparisDetay.siparisDetay.durumId == 4){
                                                  await uploadSelectedImage(ImageSource.camera, base64DocEmpty);
                                                  if(base64DocEmpty.length != 0){
                                                  await documentJsnAddFunc(orderDetailData.siparisDetay.siparisDetay.id, userData.user.id, orderDetailData.siparisDetay.siparisDetay.durumId, -1, base64DocEmpty.first);
                                                  showToast(context,"BOŞALTMA belgesi eklendi !");
                                                  imageCache.clear(); // İmage önbelleğini temizleme
                                                  imageCache.clearLiveImages();
                                                  refreshList();
                                                  base64DocEmpty.clear();
                                                  }
                                                  else
                                                  {
                                                    showToast(context,"BOŞALTMA belgesi eklenmedi !");
                                                  }
                                                }
                                                else{
                                                  showToast(context,"Boşalt butonunu kullanınız !");
                                                }
                                                progressUHD.dismiss();
                                            }
                                            else{
                                              showAlert(context, "İnternet bağlantınızı kontrol ediniz.");
                                            }},
                                            );
                                            //-----------------------------------------------------------------------------------------------------------------    
                                          }
                                          //---------------------------------- FOTOĞRAFLAR (BOŞALTMA FOTOĞRAFLARI)---------------------------------------
                                          return GestureDetector(
                                            child: Image.network(docEmpty[index].belgeLink, // boşaltma fotoğrafının linki
                                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) return child; // fotoğraf yüklenirken circular döndürme
                                                return Center(
                                                child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null 
                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                : null,
                                              ));
                                            }),
                                  
                                            onTap: () async{  
                                              final progressUHD = ProgressHUD.of(context);
                                              if(!isOffline){
                                              progressUHD.show();                                      
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                                              UpdateDocumentPage(img: docEmpty[index],userData: userData, orderDetailData: orderDetailData))); 
                                              // döküman güncelleme sayfasına yönlendirme
                                              progressUHD.dismiss();
                                            }
                                            else{
                                              showAlert(context, "İnternet bağlantınızı kontrol ediniz.");
                                            }
                                            },
                                          );
                                          //----------------------------------------------------------------------------------------------------------------------
                                        }),
                                  ),
                                ),
                                //---------------------------------------------------------------------------------------------------------------------------
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: maxSpace), // card - logo arası uzaklık
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: LogoWidget(),  // bottomda yer alan logo görünüm widgetı
    );
  }
}


