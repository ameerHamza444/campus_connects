

import 'package:campus_connects/models/faculty_management_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FacultyRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllFaculty() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Faculty").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<bool?> createNewFaculty(FacultyManagementModel faculty) async {
    try {
      await firestore.collection("Faculty").doc(faculty.id).set({
        "id": faculty.id,
        "facultyName": faculty.facultyName,
        "departmentName": faculty.departmentName,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<FacultyManagementModel> getFacultyById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Faculty').doc(uid).get();
      return FacultyManagementModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> deleteFaculty({String? id}) async {
    try {
      await firestore.collection("Faculty").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

}

