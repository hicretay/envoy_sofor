import 'package:envoy/screens/loginPage.dart';
import 'package:envoy/screens/orderDetailPage.dart';
import 'package:envoy/screens/homePage.dart';
import 'package:envoy/screens/splashPage.dart';
import 'package:envoy/screens/updateDocumentPage.dart';
import 'package:flutter/material.dart';

class Roots {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SplashPage());
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginPage());
      case orderDetailRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => OrderDetailPage());
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomePage());
      case updateDocumentRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => UpdateDocumentPage());
      default:
        //---------------------hatalı Routing işleminde çalışacak-----------------
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                "Ters giden bir şeyler oldu !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      //-------------------------------------------------------------------------
    }
  }
}

//---------------------------Routing Adlandırmaları-----------------------------
const String splashRoute = "/";
const String loginRoute = "/loginPage";
const String orderDetailRoute = "/orderDetailPage";
const String homeRoute = "/homePage";
const String updateDocumentRoute = "/updateDocumentPage";
//------------------------------------------------------------------------------
