import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/student_management_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class StudentRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("Users")
          .where("role", isNotEqualTo: "admin")
          .get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<DocumentSnapshot?> getCurrentStudent(String id) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("Student")
          .where("userId", isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return null; // No document found
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<QuerySnapshot?> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Student").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<bool?> createNewStudent(
      StudentManagementModel student, BuildContext context) async {
    try {
      // Check if student name already exists
      QuerySnapshot querySnapshot = await firestore
          .collection("Student")
          .where('studentName', isEqualTo: student.studentName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Constants.toastMessage("Student with this name already exists");
        return true;
      } else {
        await firestore.collection("Student").doc(student.id).set({
          'studentName': student.studentName,
          'departmentName': student.departmentName,
          'advisor': student.advisor,
          'id': student.id,
          'semester': student.semester,
          'userId': student.userId,
          'grades': student.grades,
          'cgpa': student.cgpa,
          'dob': student.dob,
        });
        Constants.flushBarErrorMessages(
            "Student has been Added Successfully", context);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<StudentManagementModel> getStudentById(String uid) async {
    try {
      DocumentSnapshot documentsnapshot =
          await firestore.collection('Student').doc(uid).get();
      return StudentManagementModel.fromDocumentSnapshot(
          documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> deleteStudent({String? id}) async {
    try {
      await firestore.collection("Student").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
