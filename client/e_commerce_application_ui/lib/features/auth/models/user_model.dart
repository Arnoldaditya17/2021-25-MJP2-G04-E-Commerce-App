import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  Role role;
  bool enabled;
  List<Authority> authorities;
  String username;
  bool credentialsNonExpired;
  bool accountNonExpired;
  bool accountNonLocked;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.enabled,
    required this.authorities,
    required this.username,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
    required this.accountNonLocked,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    role: Role.fromJson(json["role"]),
    enabled: json["enabled"],
    authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
    username: json["username"],
    credentialsNonExpired: json["credentialsNonExpired"],
    accountNonExpired: json["accountNonExpired"],
    accountNonLocked: json["accountNonLocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "role": role.toJson(),
    "enabled": enabled,
    "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
    "username": username,
    "credentialsNonExpired": credentialsNonExpired,
    "accountNonExpired": accountNonExpired,
    "accountNonLocked": accountNonLocked,
  };
}

class Authority {
  String authority;

  Authority({
    required this.authority,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    authority: json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "authority": authority,
  };
}

class Role {
  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
