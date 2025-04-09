// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool status;
    String message;
    LoginModelData data;

    LoginModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: LoginModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class LoginModelData {
    String imageUrl;
    String id;
    String username;
    String password;
    String createdAt;
    int v;
    String role;

    LoginModelData({
        required this.imageUrl,
        required this.id,
        required this.username,
        required this.password,
        required this.createdAt,
        required this.v,
        required this.role,
    });

    factory LoginModelData.fromJson(Map<String, dynamic> json) => LoginModelData(
        imageUrl: json["imageUrl"],
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        createdAt: json["createdAt"],
        v: json["__v"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "_id": id,
        "username": username,
        "password": password,
        "createdAt": createdAt,
        "__v": v,
        "role": role,
    };
}
