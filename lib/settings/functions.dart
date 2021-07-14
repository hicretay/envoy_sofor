import 'dart:convert';
import 'package:envoy/models.dart/documentJsonModel.dart';
import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/settings/consts.dart';
import 'package:http/http.dart' as http;

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
  final response = await http.post(Uri.parse(loginUrl),
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
    Uri.parse(orderUrl),
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
    Uri.parse(orderDetailUrl),
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
    Uri.parse(documentUrl),
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
//-----------------------------------------Döküman Fonksiyonu----------------------------------------------------
// Future<DocumentJsonModel> documentJsnAddFunc(int siparisId, int soforId, int durum, int id, String belge) async{ // id = belge id'si
//   var bodys ={};
//   bodys["siparisId"] = siparisId;
//   bodys["soforId"]   = soforId;
//   bodys["durum"]     = durum;
//   bodys["belge"]     = belge;

//   var bodyId ={};
//   bodyId["siparisId"] = siparisId;
//   bodyId["soforId"]   = soforId;
//   bodyId["durum"]     = durum;
//   bodyId["id"]        = id;
//   bodyId["belge"]     = belge;

//   String body = json.encode(bodys);
//   String body2 = json.encode(bodyId);


//   final response = await http.post(
//     Uri.parse(documentUrl),
//     body: id==0 ? body2 : body, // id = 0 ise ekleme yapar (id'li olmalı) 
//     headers: header
//   );

//   if (response.statusCode == 200) {
//     final String responseString = response.body;
//     return documentJsonModelFromJson(responseString);
//   } else {
//     print(response.statusCode);
//     return null;
//   }
// }
//--------------------------------------------------------------------------------------------------------------