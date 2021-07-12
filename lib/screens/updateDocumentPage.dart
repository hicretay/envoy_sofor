import 'dart:io';

import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../settings/consts.dart';

class UpdateDocumentPage extends StatefulWidget {
  UpdateDocumentPage({Key key}) : super(key: key);

  @override
  _UpdateDocumentPageState createState() => _UpdateDocumentPageState();
}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {

  List<String> base =[];
  bool isUpdate = false;

  //-----------------fotograf çekme - kırpma fonksiyonları----------------------
  Future uploadSelectedImage(ImageSource source,List<String> base) async {
    final imagePicker = ImagePicker();
    final selected    = await imagePicker.getImage(source: source);
   
      if (selected != null) {
        setState(() {
          selectedImage = File(selected.path);
        });
         base.add(imageToBase64(selectedImage));
        //çekilen resim base64 e dönüştürüldü
      }  
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Belgeleri img = ModalRoute.of(context).settings.arguments;   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("belge güncelle",style: TextStyle(color: Colors.white,fontFamily: leadingFont,fontSize: 28))),
        body: Container(color: bgColor,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                width: deviceWidth(context),
                                height: deviceHeight(context),
                                child: Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(img.belgeLink)))),
                              ),
                              SizedBox( height: maxSpace),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonWidget(
                                  buttonColor: btnColor,
                                  buttonText: "güncelle",
                                  buttonWidth: deviceWidth(context),
                                  onPressed: () async{
                                      isUpdate = true;                                    
                                      uploadSelectedImage(ImageSource.camera,base);
                                      //await documentJsnAddFunc(26, 1, 4, img.belgeLink);                                
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
