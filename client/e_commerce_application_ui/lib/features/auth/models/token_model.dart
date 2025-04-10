import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  String accessToken;
  int expiresIn;
  String refreshToken;

  TokenModel({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json["accessToken"],
    expiresIn: json["expiresIn"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "refreshToken": refreshToken,
  };
}