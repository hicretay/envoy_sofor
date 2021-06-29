import 'package:envoy/consts.dart';
import 'package:envoy/widgets/fillEmptyCardWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:envoy/widgets/confirmCardWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //--------------------------Appbar Stili----------------------------------
        appBar: AppBar(
          title: Text(
            "siparişler",
            style: leadingStyle, // text stili
          ),
        ),
        //------------------------------------------------------------------------
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
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/orderDetailPage");
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
