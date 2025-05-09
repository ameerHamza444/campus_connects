import 'package:cloud_firestore/cloud_firestore.dart';

class FacultyManagementModel {
  String? facultyName;
  String? departmentName;
  String? id;

  FacultyManagementModel({this.facultyName, this.departmentName, this.id});


  FacultyManagementModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    departmentName = documentsnapshot.get("departmentName");
    facultyName = documentsnapshot.get("facultyName");
    id = documentsnapshot.get("id");

  }


  FacultyManagementModel.fromJson(Map<String, dynamic> json) {
    facultyName = json['facultyName'];
    departmentName = json['departmentName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facultyName'] = facultyName;
    data['departmentName'] = departmentName;
    data['id'] = id;
    return data;
  }
}