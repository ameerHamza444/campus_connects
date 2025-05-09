import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;

  UserModel({this.id, this.name, this.email, this.role});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    id = documentsnapshot.get("id");
    name = documentsnapshot.get("name");
    email = documentsnapshot.get("email");
    role = documentsnapshot.get("role");
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    return data;
  }

}

