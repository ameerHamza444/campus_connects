import 'package:cloud_firestore/cloud_firestore.dart';

class StudentManagementModel {
  String? studentName;
  String? departmentName;
  String? advisor;
  String? id;
  String? semester;
  String? userId;
  String? grades;
  String? cgpa;
  String? dob;

  StudentManagementModel({this.studentName, this.departmentName, this.advisor, this.id, this.semester, this.userId, this.grades, this.cgpa, this.dob});


  StudentManagementModel.fromDocumentSnapshot({required DocumentSnapshot documentsnapshot}) {
    studentName = documentsnapshot.get("studentName");
    departmentName = documentsnapshot.get("departmentName");
    advisor = documentsnapshot.get("advisor");
    id = documentsnapshot.get("id");
    semester = documentsnapshot.get("semester");
    userId = documentsnapshot.get("userId");
    grades = documentsnapshot.get("grades");
    cgpa = documentsnapshot.get("cgpa");
    dob = documentsnapshot.get("dob");


  }

  StudentManagementModel.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'];
    departmentName = json['departmentName'];
    advisor = json['advisor'];
    id = json['id'];
    semester = json['semester'];
    userId = json['userId'];
    grades = json['grades'];
    cgpa = json['cgpa'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentName'] = studentName;
    data['departmentName'] = departmentName;
    data['advisor'] = advisor;
    data['id'] = id;
    data['semester'] = semester;
    data['userId'] = userId;
    data['grades'] = grades;
    data['cgpa'] = cgpa;
    data['dob'] = dob;
    return data;
  }
}