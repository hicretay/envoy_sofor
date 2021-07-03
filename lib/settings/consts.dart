import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// Renkler
const bgColor = Color(0xff212224);
const logoColor = Color(0xffFF0006);
const btnColor = Color(0xffE30613);
const passiveBtnColor = Color(0xffE30613);
const checkDateColor = Color(0xff4E2225);
const checkedTxtColor = Color(0xff00EE00);
const totalLtTxtColor = Color(0xffFA6400);
const lightCardColor = Color(0xff3B3B3B);
const darkCardColor = Color(0xff2A2A2A);

deviceHeight(BuildContext context) => MediaQuery.of(context).size.width;
// Cihaz ekran yüksekliği

deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
//Cihaz ekran genişliği

// Fonts
const leadingFont = "envoyRegular";
const contentFont = "montserratRegular";

//satır boşlukları
const minSpace = 5.0;
const maxSpace = 10.0;
const defaultPadding = 20.0;

//metin stilleri
const leadingStyle = TextStyle(
  fontFamily: leadingFont,
  fontSize: 28,
);

const cardTextStyle = TextStyle(
  fontFamily: leadingFont,
  color: Colors.white,
);

const contentTextStyle = TextStyle(color: Colors.white, fontSize: 12);

//URLs
//Fotoğraflar
const imagesUrl = "http://portalservice.kirbag.com/api/Image/imageId";
//Kullanıcı
const loginUrl = "http://portalservice.kirbag.com/api/User";
//Sipariş
const orderUrl = "http://portalservice.kirbag.com/api/Order";
//Sipariş Detay
const orderDetailUrl = "http://portalservice.kirbag.com/api/OrderDetail";

File selectedImage; // cihazdan çekilen resim

//-----------------------Resmi base64'e dönüştürme(encode)----------------------
String imageToBase64(File imagePath) {
  var imageBytes = imagePath.readAsBytesSync();
  var encodedImage = base64.encode(imageBytes);
  //encodedImage: base64' e dönüşmüş resim
  return encodedImage;
}
//------------------------------------------------------------------------------

//------------------------base64'ü resme dönüştürme-----------------------------
Image base64ToImage(String image) {
  Uint8List _imageBytesDecoded;
  _imageBytesDecoded = base64.decode(image);
  return Image.memory(_imageBytesDecoded);
}
//------------------------------------------------------------------------------
