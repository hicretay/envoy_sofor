import 'dart:convert';

DocumentJsonModel documentJsonModelFromJson(String str) => DocumentJsonModel.fromJson(json.decode(str));

String documentJsonModelToJson(DocumentJsonModel data) => json.encode(data.toJson());

class DocumentJsonModel {
    DocumentJsonModel({
        this.success,
        this.message,
    });

    bool success;
    String message;

    factory DocumentJsonModel.fromJson(Map<String, dynamic> json) => DocumentJsonModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}