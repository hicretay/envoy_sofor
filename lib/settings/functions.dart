import 'package:envoy/models.dart/orderDetailJsonModel.dart';
import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/settings/consts.dart';
import 'package:http/http.dart' as http;

//------------------------Login Fonksiyonu--------------------------------------
Future<UserJsonModel> userJsonFunc(String userName, String password) async {
  Map<String, String> header = {"Content-Type": "application/json"};
  final response = await http.post(
    Uri.parse(loginUrl),
    body: '{"userName":' + '"$userName"' + ',' + '"password":' + '"$password"' +'}',
    headers: header,
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//------------------------------------------------------------------------------

//-----------------------------Sipariş Fonksiyonu-------------------------------
Future<OrderJsonModel> orderJsonFunc(int durumId, int companyId) async {
  final response = await http.post(
    Uri.parse(orderUrl),
    body: '{"durumId":' + durumId.toString() + "," + '"companyId":' + companyId.toString() +'}',
    headers: {'Content-type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return orderJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//------------------------------------------------------------------------------

//--------------------------Sipariş Detay Fonksiyonu----------------------------
Future<OrderDetailJsonModel> orderDetailJson(int id) async {
  final response = await http.post(
    Uri.parse(orderDetailUrl),
    body: '{"id":' + id.toString() + '}',
    headers: {'Content-type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return orderDetailJsonModelFromJson(responseString);
  } else {
    return null;
  }
}
//------------------------------------------------------------------------------