import 'dart:convert';

UserJsonModel userJsonModelFromJson(String str) => UserJsonModel.fromJson(json.decode(str));

String userJsonModelToJson(UserJsonModel data) => json.encode(data.toJson());

class UserJsonModel {
    UserJsonModel({
        this.success,
        this.user,
    });

    bool success;
    User user;

    factory UserJsonModel.fromJson(Map<String, dynamic> json) => UserJsonModel(
        success: json["success"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.userName,
        this.mail,
        this.sifre,
        this.tcNo,
        this.adSoyad,
        this.telefon,
        this.bayiGrupKodu,
        this.login,
        this.sonGiris,
        this.aktif,
        this.sil,
        this.plasiyeRKodu,
        this.yetki,
        this.yeniSiparis,
        this.netsisAktarildi,
        this.taknerYuklendi,
        this.takerBosaltildi,
        this.eB1,
        this.eB2,
    });

    int id;
    String userName;
    String mail;
    String sifre;
    String tcNo;
    String adSoyad;
    String telefon;
    String bayiGrupKodu;
    bool login;
    DateTime sonGiris;
    bool aktif;
    bool sil;
    String plasiyeRKodu;
    String yetki;
    dynamic yeniSiparis;
    dynamic netsisAktarildi;
    dynamic taknerYuklendi;
    dynamic takerBosaltildi;
    dynamic eB1;
    dynamic eB2;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        mail: json["mail"],
        sifre: json["sifre"],
        tcNo: json["tcNo"],
        adSoyad: json["adSoyad"],
        telefon: json["telefon"],
        bayiGrupKodu: json["bayiGrupKodu"],
        login: json["login"],
        sonGiris: DateTime.parse(json["sonGiris"]),
        aktif: json["aktif"],
        sil: json["sil"],
        plasiyeRKodu: json["plasiyeR_KODU"],
        yetki: json["yetki"],
        yeniSiparis: json["yeniSiparis"],
        netsisAktarildi: json["netsisAktarildi"],
        taknerYuklendi: json["taknerYuklendi"],
        takerBosaltildi: json["takerBosaltildi"],
        eB1: json["eB1"],
        eB2: json["eB2"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "mail": mail,
        "sifre": sifre,
        "tcNo": tcNo,
        "adSoyad": adSoyad,
        "telefon": telefon,
        "bayiGrupKodu": bayiGrupKodu,
        "login": login,
        "sonGiris": sonGiris.toIso8601String(),
        "aktif": aktif,
        "sil": sil,
        "plasiyeR_KODU": plasiyeRKodu,
        "yetki": yetki,
        "yeniSiparis": yeniSiparis,
        "netsisAktarildi": netsisAktarildi,
        "taknerYuklendi": taknerYuklendi,
        "takerBosaltildi": takerBosaltildi,
        "eB1": eB1,
        "eB2": eB2,
    };
}
