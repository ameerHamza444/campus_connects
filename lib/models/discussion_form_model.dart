import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionFormModel{
  String? id;
  String? userID;
  String? message;
  DateTime? dateTime;

  DiscussionFormModel({this.id, this.userID, this.message, this.dateTime});

  DiscussionFormModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    id = documentsnapshot.get("id");
    userID = documentsnapshot.get("userID");
    message = documentsnapshot.get("message");
    dateTime = documentsnapshot.get("dateTime");

  }

  DiscussionFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    message = json['message'];
    dateTime = (json['dateTime'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['message'] = message;
    data['dateTime'] = dateTime;
    return data;
  }
}