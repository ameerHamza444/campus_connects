

import 'package:campus_connects/models/department_management_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DepartmentRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllDepartments() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Department").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }




  Future<bool?> createNewDepartment(DepartmentManagementModel department) async {
    try {
      await firestore.collection("Department").doc(department.id).set({
        "id": department.id,
        "departmentName": department.departmentName,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<DepartmentManagementModel> getDepartmentById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Department').doc(uid).get();
      return DepartmentManagementModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> deleteDepartment({String? id}) async {
    try {
      await firestore.collection("Department").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}

