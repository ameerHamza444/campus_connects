import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsManagementModel {
  String? announcementmsg;
  String? announcementtitle;
  String? departmentName;
  String? id;


  AnnouncementsManagementModel({this.announcementmsg, this.departmentName, this.id, this.announcementtitle});

  AnnouncementsManagementModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    announcementmsg = documentsnapshot.get("announcementMsg");
    announcementtitle = documentsnapshot.get("announcementTitle");
    departmentName = documentsnapshot.get("departmentName");
    id = documentsnapshot.get("id");

  }

  AnnouncementsManagementModel.fromJson(Map<String, dynamic> json) {
    announcementmsg = json['announcementmsg'];
    announcementtitle = json['announcementtitle'];
    departmentName = json['departmentName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['announcementmsg'] = announcementmsg;
    data['announcementtitle'] = announcementtitle;
    data['departmentName'] = departmentName;
    data['id'] = id;
    return data;
  }
}