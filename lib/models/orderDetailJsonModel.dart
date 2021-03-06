// To parse this JSON data, do
//
//     final orderDetailJsonModel = orderDetailJsonModelFromJson(jsonString);

import 'dart:convert';

OrderDetailJsonModel orderDetailJsonModelFromJson(String str) => OrderDetailJsonModel.fromJson(json.decode(str));

String orderDetailJsonModelToJson(OrderDetailJsonModel data) => json.encode(data.toJson());

class OrderDetailJsonModel {
    OrderDetailJsonModel({
        this.success,
        this.siparisDetay,
    });

    bool success;
    OrderDetailJsonModelSiparisDetay siparisDetay;

    factory OrderDetailJsonModel.fromJson(Map<String, dynamic> json) => OrderDetailJsonModel(
        success: json["success"],
        siparisDetay: OrderDetailJsonModelSiparisDetay.fromJson(json["siparisDetay"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "siparisDetay": siparisDetay.toJson(),
    };
}

class OrderDetailJsonModelSiparisDetay {
    OrderDetailJsonModelSiparisDetay({
        this.siparisDetay,
        this.soforonayTarihi,
        this.depoIcerigi,
        this.yuklemeBelgeleri,
        this.bosaltmaBelgeleri,
    });

    SiparisDetaySiparisDetay siparisDetay;
    String soforonayTarihi;
    List<DepoIcerigi> depoIcerigi;
    List<Belgeleri> yuklemeBelgeleri;
    List<Belgeleri> bosaltmaBelgeleri;

    factory OrderDetailJsonModelSiparisDetay.fromJson(Map<String, dynamic> json) => OrderDetailJsonModelSiparisDetay(
        siparisDetay: SiparisDetaySiparisDetay.fromJson(json["siparisDetay"]),
        soforonayTarihi: json["soforonayTarihi"],
        depoIcerigi: List<DepoIcerigi>.from(json["depoIcerigi"].map((x) => DepoIcerigi.fromJson(x))),
        yuklemeBelgeleri: List<Belgeleri>.from(json["yuklemeBelgeleri"].map((x) => Belgeleri.fromJson(x))),
        bosaltmaBelgeleri: List<Belgeleri>.from(json["bosaltmaBelgeleri"].map((x) => Belgeleri.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "siparisDetay": siparisDetay.toJson(),
        "soforonayTarihi": soforonayTarihi,
        "depoIcerigi": List<dynamic>.from(depoIcerigi.map((x) => x.toJson())),
        "yuklemeBelgeleri": List<dynamic>.from(yuklemeBelgeleri.map((x) => x.toJson())),
        "bosaltmaBelgeleri": List<dynamic>.from(bosaltmaBelgeleri.map((x) => x.toJson())),
    };
}

class Belgeleri {
    Belgeleri({
        this.id,
        this.tarih,
        this.belgeLink,
    });

    int id;
    String tarih;
    String belgeLink;

    factory Belgeleri.fromJson(Map<String, dynamic> json) => Belgeleri(
        id: json["id"],
        tarih: json["tarih"],
        belgeLink: json["belgeLink"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tarih": tarih,
        "belgeLink": belgeLink,
    };
}

class DepoIcerigi {
    DepoIcerigi({
        this.yakitTipi,
        this.litre,
    });

    String yakitTipi;
    String litre;

    factory DepoIcerigi.fromJson(Map<String, dynamic> json) => DepoIcerigi(
        yakitTipi: json["yakitTipi"],
        litre: json["litre"],
    );

    Map<String, dynamic> toJson() => {
        "yakitTipi": yakitTipi,
        "litre": litre,
    };
}

class SiparisDetaySiparisDetay {
    SiparisDetaySiparisDetay({
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

    factory SiparisDetaySiparisDetay.fromJson(Map<String, dynamic> json) => SiparisDetaySiparisDetay(
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
