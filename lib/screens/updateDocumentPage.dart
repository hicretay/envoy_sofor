import 'dart:io';

import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../consts.dart';

class UpdateDocumentPage extends StatefulWidget {
  UpdateDocumentPage({Key key}) : super(key: key);

  @override
  _UpdateDocumentPageState createState() => _UpdateDocumentPageState();
}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {
  //-----------------fotograf çekme - kırpma fonksiyonları----------------------
  void uploadSelectedImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final selected = await imagePicker.getImage(source: source);

    setState(() {
      if (selected != null) {
        imageCrop(File(selected.path));
      }
      
    });
  }

  void imageCrop(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
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
    //çekilip kesilen resmi base64'e dönüştürüp, listeye ekleme
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Image img = ModalRoute.of(context).settings.arguments;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "belge güncelle",
            style: TextStyle(
              color: Colors.white,
              fontFamily: leadingFont,
              fontSize: 28,
            ),
          ),
        ),
        body: Container(
          color: bgColor,
          child: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(maxSpace),
                        child: Card(
                          elevation: 20.0,
                          color: darkCardColor,
                          child: Column(
                            children: [
                              SizedBox(height: maxSpace),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "dolum belgesi güncelle",
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
                                child: img,
                              ),
                              SizedBox(
                                height: maxSpace,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonWidget(
                                  buttonColor: btnColor,
                                  buttonText: "güncelle",
                                  buttonWidth: deviceWidth(context),
                                  onPressed: () {
                                    setState(() {
                                      uploadSelectedImage(ImageSource.camera);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                      ),
                      // LogoWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //alttaki Logo görünümü
        bottomNavigationBar: LogoWidget(),
      ),
    );
  }
}
