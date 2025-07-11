// model_data_user.dart

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

class ModelUser {
  List<User>? users;

  ModelUser({this.users});

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );
}