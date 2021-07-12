import 'dart:io';
import 'package:envoy/models.dart/orderJsonModel.dart';
import 'package:envoy/models.dart/userJsonModel.dart';
import 'package:envoy/screens/loginPage.dart';
import 'package:envoy/screens/orderDetailPage.dart';
import 'package:envoy/settings/consts.dart';
import 'package:envoy/widgets/buttonWidget.dart';

import 'package:envoy/widgets/ordersCardWidget.dart';
import 'package:envoy/widgets/logoWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:envoy/settings/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  final UserJsonModel userData;
  final OrderJsonModel orderData;
  const HomePage({Key key, this.userData, this.orderData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userData: userData, orderData: orderData);
}

class _HomePageState extends State<HomePage> {
  UserJsonModel  userData;
  OrderJsonModel orderData;
  _HomePageState({this.userData, this.orderData});

  SharedPreferences logindata;
  String username;

  @override
  void initState() {
  super.initState();
    setState(() {
    refreshList(1, userData.user.id);
    initial();
   });
  }
    void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  List<String> base64DocFill = [];
  // base64 images listesi (yükleme)

  List<String> base64DocEmpty = [];
  // base64 images listesi (boşaltma)

  int id=26;


//--------------------Sipariş Listesi Yenileme Fonksiyonu-----------------------
  Future refreshList(int durumId, int companyId) async {
    final OrderJsonModel orderList = await orderJsonFunc(durumId,companyId); 
    setState(() {
      orderData = orderList;
    });
  }
//------------------------------------------------------------------------------

//--------------------fotoğraf çekme fonksiyonu--------------------------
  Future uploadSelectedImage(ImageSource source,List<String> base) async {
    final imagePicker = ImagePicker();
    final selected    = await imagePicker.getImage(source: source);
   
      if (selected != null) {
        setState(() {
          selectedImage = File(selected.path);
        });
         base.add(imageToBase64(selectedImage));
        //çekilen resim base64 e dönüştürülüp, listeye eklendi
      }  
  }
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //--------------------------Appbar Stili--------------------------------
        appBar: AppBar(
        title: Text("siparişler", style: leadingStyle),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){
            logindata.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          })
        ],
        ),
        //----------------------------------------------------------------------
          body : Container(
          color: bgColor, // arkaplan rengi
          child: Column(
            children: [
              SizedBox(height: maxSpace),
              Flexible(child : RefreshIndicator(
                onRefresh: ()=> refreshList(1, userData.user.id), // yukarıdan aşağı kaydırılınca listeyi yenileme
                child: ListView.builder(
                    itemCount  : orderData.siparisList.length,
                    itemBuilder: (BuildContext context, int index){
                      //this.id = orderData.siparisList[index].id;
                      if(orderData.siparisList.length == 0 && orderData.siparisList == null){
                        return CircularProgressIndicator();
                      }
                      else
                      return OrdersCardWidget(
                        deliveryDate   : orderData.siparisList[index].teslimTarihi,
                        fillingPoint   : orderData.siparisList[index].dolumyeri,
                        deliveryStation: orderData.siparisList[index].teslimatIstasyonu,
                        totalLT        : orderData.siparisList[index].toplamLitre,
                        status         : orderData.siparisList[index].durumId == 1 ? "Yeni Sipariş" : "Onaylandı" ,
                        statusColor    : orderData.siparisList[index].durumId == 1 ? Colors.white : checkedTxtColor,
                        onTap: () async {

                          // slidable onTap'i
                          
                          final orderDetailData = await orderDetailJsonFunc(id);                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => 
                          OrderDetailPage(orderDetailData: orderDetailData,base64DocEmpty: base64DocEmpty,base64DocFill: base64DocFill)));
                        },
                        //sipariş onaylanmışsa doldur - boşalt butonları olan görünüm gelecek
                        
                        child: (orderData.siparisList[index].durumId == 1) 
                            ?  ButtonWidget(
                                buttonText : "onayla",
                                buttonWidth: deviceWidth(context),
                                buttonColor: btnColor,
                                onPressed  : () async{                                                                                                 
                                    await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 2, null);
                                    await refreshList(orderData.siparisList[index].durumId, userData.user.id);                                                                                                                               
                                })

                                :// Sipariş onaylanmamışsa onayla butonu olan görünüm gelecek
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //--------------------------------------doldur butonu------------------------------------
                                  ButtonWidget(
                                    buttonText : "doldur",
                                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                    buttonColor: btnColor,
                                    onPressed  : orderData.siparisList[index].durumId == 2 ?
                                    () async{
                                        await uploadSelectedImage(ImageSource.camera, base64DocFill);
                                        if(base64DocFill.isNotEmpty)
                                        {
                                        await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 3, null);}
                                        await refreshList(orderData.siparisList[index].durumId, userData.user.id);                                       
                                        //show message
                                        showMessage(context, base64DocFill,3);
                                    } 
                                    :  (){}
                                  ),
                                  //----------------------------------------------------------------------------------------
                                  //-------------------------------------boşalt butonu---------------------------------------
                                  ButtonWidget(
                                    buttonText : "boşalt",
                                    buttonWidth: deviceWidth(context) * 0.46, // buton genişliği
                                    buttonColor: checkDateColor,
                                    onPressed  : orderData.siparisList[index].durumId == 3 ? 
                                    () async{
                                        await uploadSelectedImage(ImageSource.camera, base64DocEmpty);
                                        if(base64DocEmpty.isNotEmpty)
                                        {
                                        await documentJsnAddFunc(orderData.siparisList[index].id, userData.user.id, 4, null);}
                                        await refreshList(orderData.siparisList[index].durumId, userData.user.id);  
                                        //show message
                                        showMessage(context, base64DocEmpty,4);
                                    } 
                                    : (){}
                                  ),
                                  //-------------------------------------------------------------------------------------------
                                ],
                              )
                      );  
                    },
                  ),
               ),
             ),
            ],
          ),
        ),
        bottomNavigationBar: LogoWidget()); // en alttaki logo görünümü
  }

  showMessage(BuildContext context, List<String> document,int stateID) { 
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: Text("Tekrar belge fotoğrafı çekmek ister misiniz ?",style: TextStyle(fontFamily: contentFont)),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [   
          //-----------------------------------Evet Butonu-----------------------------------------     
          MaterialButton(
            color: btnColor,
            child: Text("Evet",style: TextStyle(fontFamily: leadingFont)), // fotoğraf çekilmeye devam edilecek
            onPressed: () async{
            await uploadSelectedImage(ImageSource.camera, document);
            }),
          //---------------------------------------------------------------------------------------
          SizedBox(width: maxSpace), // iki buton arası boşluk
          //-----------------------------------Hayır Butonu----------------------------------------
          MaterialButton(
            color    : btnColor,
            child    : Text("Hayır",style: TextStyle(fontFamily: leadingFont)),
            onPressed: () async{                                    
              for (var i = 0; i <= document.length -1; i++){
                if(document.isNotEmpty)
                await documentJsnAddFunc(id, userData.user.id, stateID, document[i]);}

              // Toast message çekilen döküman sayısını gösterecek  
              Toast.show("${document.length} belge kaydedildi !", context, backgroundColor: Colors.grey,duration: 2, textColor: Colors.black);
              refreshList(1, userData.user.id);              
              Navigator.of(context).pop();
            }),
          //---------------------------------------------------------------------------------------
        ]),        
      ],
    );
  });    
}
}


