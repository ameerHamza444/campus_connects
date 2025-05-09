import 'package:cloud_firestore/cloud_firestore.dart';

class ClubnactitvityModel {
  String? id;
  String? userId;
  String? name;
  String? clubNactivity;



  ClubnactitvityModel({this.id, this.userId, this.name, this.clubNactivity});

  ClubnactitvityModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    name = documentsnapshot.get("name");
    clubNactivity = documentsnapshot.get("clubNactivity");
    userId = documentsnapshot.get("userId");
    id = documentsnapshot.get("id");

  }

  ClubnactitvityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    clubNactivity = json['clubNactivity'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['clubNactivity'] = clubNactivity;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}