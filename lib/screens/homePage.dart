import 'dart:io';

import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/orderDetailPage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/buttonWidget.dart';

import 'package:envoy/widgets/ordersCardWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:envoy/settings/functions.dart';

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

  bool selected = false; 
  // sipariş onaylandı mı kontrolü

  List<String> base64DocFill = [];
  // base64 images listesi (yükleme)

  List<String> base64DocEmpty = [];
  // base64 images listesi (boşaltma)

//--------------------seçilen resmi yükleme fonksiyonu--------------------------
  void uploadSelectedImage(ImageSource source, List<String> base) async {
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
        ),
        //----------------------------------------------------------------------
          body : Container(
          color: bgColor, // arkaplan rengi
          child: Column(
            children: [
              SizedBox(height: maxSpace),
              Flexible(child : ListView.builder(
                  itemCount  : orderData.siparisList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrdersCardWidget(
                      deliveryDate   : orderData.siparisList[index].teslimTarihi,
                      fillingPoint   : orderData.siparisList[index].dolumyeri,
                      deliveryStation: orderData.siparisList[index].teslimatIstasyonu,
                      totalLT        : orderData.siparisList[index].toplamLitre,
                      status         : selected ? "Onaylandı" : "Yeni Sipariş",
                      statusColor    : selected ? checkedTxtColor : Colors.white,
                      onTap: () async {
                        // slidable onTap'i
                        final int id = 26;
                        final orderDetailData = await orderDetailJsonFunc(id);
                        Navigator.push(context,
                            MaterialPageRoute( builder: (context) => OrderDetailPage(base64Doc: [base64DocFill,base64DocEmpty],orderDetailData: orderDetailData)));
                      },
                      //sipariş onaylanmışsa doldur - boşalt butonları olan görünüm gelecek
                      child: selected  
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //------------------doldur butonu---------------------
                                ButtonWidget(
                                  buttonText : "doldur",
                                  buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                  buttonColor: btnColor,
                                  onPressed  : () {
                                    setState(() {
                                      uploadSelectedImage(ImageSource.camera, base64DocFill);
                                    });
                                  },
                                ),
                                //----------------------------------------------------
                                //------------------boşalt butonu---------------------
                                ButtonWidget(
                                  buttonText : "boşalt",
                                  buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                  buttonColor: checkDateColor,
                                  onPressed  : () {
                                    setState(() {
                                      uploadSelectedImage(ImageSource.camera, base64DocEmpty);
                                    });
                                  },
                                ),
                                //----------------------------------------------------
                              ],
                            )
                          // Sipariş onaylanmamışsa onayla butonu olan görünüm gelecek
                          : ButtonWidget(
                              buttonText : "onayla",
                              buttonWidth: deviceWidth(context),
                              buttonColor: btnColor,
                              onPressed  : () {
                                setState(() {
                                  selected = true;
                                });
                              }),
                    );
                  },
                ),
              ),
              // alttaki logo görünümü
            ],
          ),
        ),
        bottomNavigationBar: LogoWidget());
  }
}
