import 'dart:convert';

OrderJsonModel orderJsonModelFromJson(String str) => OrderJsonModel.fromJson(json.decode(str));

String orderJsonModelToJson(OrderJsonModel data) => json.encode(data.toJson());

class OrderJsonModel {
    OrderJsonModel({
        this.success,
        this.siparisList,
    });

    bool success;
    List<SiparisList> siparisList;

    factory OrderJsonModel.fromJson(Map<String, dynamic> json) => OrderJsonModel(
        success: json["success"],
        siparisList: List<SiparisList>.from(json["siparisList"].map((x) => SiparisList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "siparisList": List<dynamic>.from(siparisList.map((x) => x.toJson())),
    };
}

class SiparisList {
    SiparisList({
        this.id,
        this.sirket,
        this.teslimTarihi,
        this.dolumyeri,
        this.teslimatIstasyonu,
        this.teslimatAdresi,
        this.toplamLitre,
        this.durumId,
    });

    int id;
    String sirket;
    String teslimTarihi;
    String dolumyeri;
    String teslimatIstasyonu;
    String teslimatAdresi;
    String toplamLitre;
    int durumId;

    factory SiparisList.fromJson(Map<String, dynamic> json) => SiparisList(
        id: json["id"],
        sirket: json["sirket"],
        teslimTarihi: json["teslimTarihi"],
        dolumyeri: json["dolumyeri"],
        teslimatIstasyonu: json["teslimatIstasyonu"],
        teslimatAdresi: json["teslimatAdresi"],
        toplamLitre: json["toplamLitre"],
        durumId: json["durumId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sirket": sirket,
        "teslimTarihi": teslimTarihi,
        "dolumyeri": dolumyeri,
        "teslimatIstasyonu": teslimatIstasyonu,
        "teslimatAdresi": teslimatAdresi,
        "toplamLitre": toplamLitre,
        "durumId": durumId,
    };
}
