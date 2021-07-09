import 'dart:io';
import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/loginPage.dart';
import 'package:envoy/screens/orderDetailPage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/buttonWidget.dart';

import 'package:envoy/widgets/ordersCardWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:envoy/settings/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final UserJsonModel userData;
  final OrderJsonModel orderData;
  const HomePage({Key key, this.userData, this.orderData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userData: userData, orderData: orderData);
}

class _HomePageState extends State<HomePage> {
  UserJsonModel  userData;
  OrderJsonModel orderData;
  _HomePageState({this.userData, this.orderData});

  SharedPreferences logindata;
  String username;

  @override
  void initState() {
  super.initState();
    setState(() {
    refreshList(1, userData.user.id);
    initial();
   });
  }
    void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  bool selected = false; 
  // sipariş onaylandı mı kontrolü

  List<String> base64DocFill = [];
  // base64 images listesi (yükleme)

  List<String> base64DocEmpty = [];
  // base64 images listesi (boşaltma)

//--------------------Sipariş Listesi Yenileme Fonksiyonu-----------------------
  Future refreshList(int durumId, int companyId) async {
    final OrderJsonModel orderList = await orderJsonFunc(durumId,companyId); 
    setState(() {
      orderData = orderList;
    });
  }
//------------------------------------------------------------------------------

//--------------------seçilen resmi yükleme fonksiyonu--------------------------
  Future uploadSelectedImage(ImageSource source, List<String> base) async {
    final imagePicker = ImagePicker();
    final selected    = await imagePicker.getImage(source: source);

    setState(() {
      if (selected != null) {
        imageCrop(File(selected.path), base);
      }
    });
  }
//------------------------------------------------------------------------------

//-----------------------image kırpma fonksiyonu--------------------------------
  void imageCrop(File image, List<String> base) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath        : image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio7x5
        ]);

    if (croppedImage != null) {
      setState(() {
        selectedImage = croppedImage;
      });
    }
    base.add(imageToBase64(selectedImage));
    //çekilip kesilen resmi base64' dönüştürüp, listeye ekleme
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //--------------------------Appbar Stili--------------------------------
        appBar: AppBar(
        title: Text("siparişler", style: leadingStyle),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){
            logindata.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          })
        ],
        ),
        //----------------------------------------------------------------------
          body : Container(
          color: bgColor, // arkaplan rengi
          child: Column(
            children: [
              SizedBox(height: maxSpace),
              Flexible(child : RefreshIndicator(
                onRefresh: ()=> refreshList(1, userData.user.id),
                child: ListView.builder(
                    itemCount  : orderData.siparisList.length,
                    itemBuilder: (BuildContext context, int index){
                      if(orderData.siparisList.length == 0 && orderData.siparisList == null){
                        return CircularProgressIndicator();
                      }
                      else
                      return OrdersCardWidget(
                        deliveryDate   : orderData.siparisList[index].teslimTarihi,
                        fillingPoint   : orderData.siparisList[index].dolumyeri,
                        deliveryStation: orderData.siparisList[index].teslimatIstasyonu,
                        totalLT        : orderData.siparisList[index].toplamLitre,
                        status         : orderData.siparisList[index].durumId == 1 ? "Onaylandı" : "Yeni Sipariş",
                        statusColor    : selected ? checkedTxtColor : Colors.white,
                        onTap: () async {
                          // slidable onTap'i
                          final int id = 26;
                          final orderDetailData = await orderDetailJsonFunc(id);
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => OrderDetailPage(orderDetailData: orderDetailData,base64DocEmpty: base64DocEmpty,base64DocFill: base64DocFill)));
                        },
                        //sipariş onaylanmışsa doldur - boşalt butonları olan görünüm gelecek
                        
                        child: 
                        (orderData.siparisList[index].durumId == 1) //&&(orderData.siparisList[index].durumId == 3)&&(orderData.siparisList[index].durumId == 4)
                            ?  ButtonWidget(
                                buttonText : "onayla",
                                buttonWidth: deviceWidth(context),
                                buttonColor: btnColor,
                                onPressed  : () async{                                                                
                                  setState(() async{
                                    await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 2, null);
                                    await refreshList(orderData.siparisList[index].durumId, userData.user.id);    
                                  });                                                                                             
                                })

                                :// Sipariş onaylanmamışsa onayla butonu olan görünüm gelecek
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //------------------doldur butonu---------------------
                                  ButtonWidget(
                                    buttonText : "doldur",
                                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                    buttonColor: btnColor,
                                    onPressed  : //orderData.siparisList[index].durumId == 4 ?
                                    () async{
                                        await uploadSelectedImage(ImageSource.camera, base64DocFill);
                                        await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 2, null);
                                        await refreshList(orderData.siparisList[index].durumId, userData.user.id);                                       
                                        //show message
                                        showMessage(context);
                                    } //: (){}
                                  ),
                                  //----------------------------------------------------
                                  //------------------boşalt butonu---------------------
                                  ButtonWidget(
                                    buttonText : "boşalt",
                                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                    buttonColor: checkDateColor,
                                    onPressed  : // orderData.siparisList[index].durumId == 3 ? 
                                    () async{
                                        await uploadSelectedImage(ImageSource.camera, base64DocEmpty);
                                        await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 2, null);
                                        await refreshList(orderData.siparisList[index].durumId, userData.user.id);  
                                        //show message
                                        showMessage(context);
                                    } //: (){}
                                  ),
                                  //----------------------------------------------------
                                ],
                              )
                      );  
                    },
                  ),
               ),
             ),
            ],
          ),
        ),
        bottomNavigationBar: LogoWidget()); // alttaki logo görünümü
  }
}

showMessage(BuildContext context) {
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: Text("Tekrar belge fotoğrafı çekmek ister misiniz ?",style: TextStyle(fontFamily: contentFont)),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [          
          MaterialButton(
            color: btnColor,
            child: Text("Evet",style: TextStyle(fontFamily: leadingFont)),
            onPressed: (){}),
          SizedBox(width: maxSpace),
          MaterialButton(
            color: btnColor,
            child: Text("Hayır",style: TextStyle(fontFamily: leadingFont)),
            onPressed: (){}),
        ],),
        
      ],
    );
  });
    
}
