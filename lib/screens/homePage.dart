import 'dart:io';

import 'package:envoy/consts.dart';
import 'package:envoy/widgets/fillEmptyCardWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/confirmCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;
  List<FillEmptyCardWidget> orders = [];

  List<String> base64DocFill = [];
  // base64 images listesi yükleme

  List<String> base64DocEmpty = [];
  // base64 images listesi boşaltma

//--------------------seçilen resmi yükleme fonksiyonu--------------------------
  void uploadSelectedImage(ImageSource source, List<String> base) async {
    final imagePicker = ImagePicker();
    final selected = await imagePicker.getImage(source: source);

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
    base.add(imageToBase64(selectedImage));
    //çekilip kesilen resmi base64' dönüştürüp, listeye ekleme
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //--------------------------Appbar Stili--------------------------------
        appBar: AppBar(
          title: Text(
            "siparişler",
            style: leadingStyle, // text stili
          ),
        ),
        //----------------------------------------------------------------------
        body: Container(
          color: bgColor, // arkaplan rengi
          child: Column(
            children: [
              SizedBox(height: maxSpace),
              Flexible(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        selected == true
                            ? FillEmptyCardWidget(
                                deliveryDate: "23.06.2021 17:00",
                                fillingPoint: "mersin aytemiz",
                                deliveryStation:
                                    " MERSİN - AYHANLAR MADENCİLİK",
                                totalLT: 100.00,
                                onTap: () { // slidable onTapi
                                  Navigator.pushNamed(
                                    context, "/orderDetailPage",
                                    arguments: <List<String>>[base64DocFill,base64DocEmpty]
                                    // base64Doc listesi sipariş detay sayfasına gönderiliyor
                                  );
                                },
                                fillOnTap: () {
                                  setState(() {
                                    uploadSelectedImage(
                                        ImageSource.camera, base64DocFill);
                                  });
                                },
                                emptyOnTap: () {
                                  setState(() {
                                    uploadSelectedImage(
                                        ImageSource.camera, base64DocEmpty);
                                  });
                                },
                              )
                            : ConfirmCardWidget(
                                onPressed: () {
                                  setState(
                                    () {
                                      selected = true;
                                    },
                                  );
                                },
                              ),
                      ],
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
