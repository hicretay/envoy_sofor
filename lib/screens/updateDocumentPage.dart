import 'package:envoy/widgets/buttonWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import '../consts.dart';

class UpdateDocumentPage extends StatefulWidget {
  UpdateDocumentPage({Key key}) : super(key: key);

  @override
  _UpdateDocumentPageState createState() => _UpdateDocumentPageState();
}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {
  @override
  Widget build(BuildContext context) {
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
                              SizedBox(
                                height: maxSpace,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "dolum belgesi güncelle",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: leadingFont,
                                      fontSize: 18),
                                ),
                              ),
                              Divider(color: Colors.grey),
                              Container(
                                width: deviceWidth(context),
                                height: deviceHeight(context),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/document.png"),
                                  ),
                                ),
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
                                  onPressed: () {},
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
