import 'dart:convert';
import 'dart:io';
import 'package:envoy/models.dart/documentJsonModel.dart';
import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

Map<String, String> header = {
  "Content-Type": "application/json",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Credentials": true.toString(),
  "Access-Control-Allow-Headers":
  "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS"
};
//-----------------------------------------Login Fonksiyonu---------------------------------------------------

Future<UserJsonModel> userJsonFunc(String userName, String password) async {
  final response = await http.post(Uri.parse(url + "/User"),
      body: '{"userName":' +'"$userName"' + ',' +'"password":' + '"$password"' + '}',
      headers: header
      );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------

//-----------------------------Sipariş Fonksiyonu--------------------------------------------------------------
Future<OrderJsonModel> orderJsonFunc(int durumId, int companyId) async {
  final response = await http.post(
    Uri.parse(url + "/Order"),
    body: '{"durumId":' +durumId.toString() + "," + '"companyId":' + companyId.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return orderJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------

//----------------------------------------Sipariş Detay Fonksiyonu---------------------------------------------
Future<OrderDetailJsonModel> orderDetailJsonFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "/OrderDetail"),
    body: '{"id":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return orderDetailJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//--------------------------------------------------------------------------------------------------------------
//---------------------------------------Döküman Ekleme Fonksiyonu----------------------------------------------
Future<DocumentJsonModel> documentJsnAddFunc(int siparisId, int soforId, int durum, int id, String belge) async{
  var bodys ={};
  bodys["siparisId"] = siparisId;
  bodys["soforId"]   = soforId;
  bodys["durum"]     = durum;
  bodys["id"]        = id;
  bodys["belge"]     = belge;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "/Document"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return documentJsonModelFromJson(responseString);
  } else {
    print(response.statusCode);
    return null;
  }
}
//--------------------------------------------------------------------------------------------------------------
//-------------------------------Kullanıcıya Dönüt - Uyarı Dialog Fonksiyonu------------------------------------
  showAlert(BuildContext context, String content) { 
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Text(content, style: TextStyle(fontFamily: contentFont)),
        actions: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               MaterialButton(
               color: btnColor,
               child: Text("Kapat",style: TextStyle(fontFamily: leadingFont)), // fotoğraf çekilmeye devam edilecek
               onPressed: () async{
                 Navigator.of(context).pop();
            }),
          ],
           ),
          
        ],
      );
    });
  }
//--------------------------------------------------------------------------------------------------------------

//--------------------seçilen resmi yükleme fonksiyonu--------------------------
  Future uploadSelectedImage(ImageSource source,List<String> base) async {
    final imagePicker = ImagePicker();
    final selected    = await imagePicker.getImage(source: source);
   
      if (selected != null) {
          selectedImage = File(selected.path);  
          base.add(imageToBase64(selectedImage));
          //çekilen resim base64 e dönüştürülüp, listeye eklendi
          imageCache.clear(); // İmage önbelleğini temizleme
          imageCache.clearLiveImages();
      }  
  }
//------------------------------------------------------------------------------
//------------------------------Toast Mesaj Gösterme Fonksiyonu-----------------------------------------
showToast(BuildContext context, String content){
  return Toast.show(content, context, backgroundColor: Colors.grey,duration: 3, textColor: Colors.black);
}
//------------------------------------------------------------------------------------------------------