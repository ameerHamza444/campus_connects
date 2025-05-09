
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? notificationName;
  String? notificationTitle;
  String? id;

  NotificationModel({this.notificationName, this.id, this.notificationTitle});

  NotificationModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    notificationName = documentsnapshot.get("notificationName");
    notificationTitle = documentsnapshot.get("notificationTitle");
    id = documentsnapshot.get("id");

  }


  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationName = json['notificationName'];
    notificationTitle = json['notificationTitle'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationName'] = notificationName;
    data['notificationTitle'] = notificationTitle;
    data['id'] = id;
    return data;
  }
}