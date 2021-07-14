import 'dart:io';
import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/settings/functions.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../settings/consts.dart';

// ignore: must_be_immutable
class UpdateDocumentPage extends StatefulWidget {
  Belgeleri img;
  final UserJsonModel userData;
  final OrderDetailJsonModel orderDetailData;


  UpdateDocumentPage({Key key, this.img, this.userData, this.orderDetailData}) : super(key: key);

  @override
  _UpdateDocumentPageState createState() =>  
  _UpdateDocumentPageState(img: img,userData: userData, orderDetailData: orderDetailData);

}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {


  UserJsonModel userData;
  OrderDetailJsonModel orderDetailData;
  Belgeleri img;

  _UpdateDocumentPageState({this.img,this.userData, this.orderDetailData});

  //-----------------fotograf çekme - kırpma fonksiyonları----------------------
  Future uploadSelectedImage(ImageSource source, List<String> base) async {
    final imagePicker = ImagePicker();
    final selected = await imagePicker.getImage(source: source);

    if (selected != null) {
      setState(() {
        selectedImage = File(selected.path);
      });
      base.add(imageToBase64(selectedImage));
      //çekilen resim base64 e dönüştürüldü
    }
  }
//------------------------------------------------------------------------------
  List<String> base = [];
  @override
  Widget build(BuildContext context) {
    String link = img.belgeLink;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title : Text("belge güncelle", 
        style : TextStyle(
        color : Colors.white,
        fontFamily: leadingFont,
        fontSize  : 28))),
          body : Container(
          color: bgColor,
          child: Column(children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(maxSpace),
                        child: Card(
                          elevation: 20.0,
                          color: darkCardColor,
                          child: Column(children: [
                              SizedBox(height: maxSpace),
                              Padding( padding: const EdgeInsets.all(8.0),
                                child: Text("dolum belgesi güncelle",
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: leadingFont,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey),
                              Container(
                                width : deviceWidth(context),
                                height: deviceHeight(context),
                                child : Image.network(link,
                                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null 
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                    ));
                                  }),
                              ),
                              SizedBox(height: maxSpace),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonWidget(
                                  buttonColor: btnColor,
                                  buttonText : "güncelle",
                                  buttonWidth: deviceWidth(context),
                                  onPressed  : () async {
                                      await uploadSelectedImage(
                                      ImageSource.camera,base);
                                      await documentJsnAddFunc(orderDetailData.siparisDetay.siparisDetay.id, userData.user.id, orderDetailData.siparisDetay.siparisDetay.durumId, img.id, base.first);
                                      setState(() {
                                        link=img.belgeLink;
                                      });
                                  },
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: LogoWidget(), // alttaki Logo görünümü
      ),
    );
  }
}
