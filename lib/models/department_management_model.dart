
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentManagementModel {
  String? departmentName;
  String? id;

  DepartmentManagementModel({this.departmentName, this.id});

  DepartmentManagementModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    departmentName = documentsnapshot.get("departmentName");
    id = documentsnapshot.get("id");

  }


  DepartmentManagementModel.fromJson(Map<String, dynamic> json) {
    departmentName = json['departmentName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentName'] = departmentName;
    data['id'] = id;
    return data;
  }
}