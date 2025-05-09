import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/student_management_model.dart';
import 'package:campus_connects/repository/auth_repo.dart';
import 'package:campus_connects/repository/student_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudentViewModel extends ChangeNotifier {
  final _studentRepo = StudentRepo();
  final _authRepo = AuthRepo();
  final _s1 = S1();
  final _currentUser = FirebaseAuth.instance.currentUser;
  StudentManagementModel? _studentManagementModel;
  StudentManagementModel? get studentManagementModel => _studentManagementModel;

  String _userEmail = "";
  String get userEmail => _userEmail;

  String _selectedStudentName = "";
  String get selectedStudentName => _selectedStudentName;
  String _selectedStudentID = "";
  String get selectedStudentID => _selectedStudentID;
  bool _isCreatingStudent = false;

  bool get isCreatingStudent => _isCreatingStudent;
  bool _isLoadingCurrentStudent = false;

  bool get isLoadingCurrentStudent => _isLoadingCurrentStudent;

  List<String> _studentNames = [];

  List<String> get studentNames => _studentNames;

  List<String> _studentID = [];

  List<String> get studentID => _studentID;

  bool _isDeletingStudent = false;

  bool get isDeletingStudent => _isDeletingStudent;



  setSelectedStudentName(String value){
    _selectedStudentName = value;
    notifyListeners();
  }

  clearStudentNamesList(){
    _studentNames.clear();
    _studentID.clear();
    notifyListeners();
  }

  setCreatingStudent(bool value) {
    _isCreatingStudent = value;
    notifyListeners();
  }

  Future<QuerySnapshot?> getAllUsersNamesCalling(BuildContext context) async {
    try {
      final value = await _studentRepo.getAllUsers();
      _studentNames = value!.docs.map((doc) => doc.get("name") as String).toList();
      _studentID = value.docs.map((doc) => doc.get("id") as String).toList();
      print("Student Nanme: $_studentNames");
      print("Student ID: $_studentID");
      // ✅ Initialize selectedStudentName
      if (_studentNames.isNotEmpty) {
        _selectedStudentName = _studentNames.first;
        _selectedStudentID = _studentID.first;
      } else {
        _selectedStudentName = "";
        _selectedStudentID = "";
      }

      notifyListeners();
      return value;
    } catch (error) {
      if (context.mounted) {
        Constants.flushBarErrorMessages(error.toString(), context);
      }
      return null;
    }
  }

  clearCurrentUser(){
    _userEmail = "";
    _studentManagementModel = StudentManagementModel();
    notifyListeners();
  }

  setLoadingCurrentUser(bool value){
    _isLoadingCurrentStudent = value;
    notifyListeners();
  }

  Future<StudentManagementModel?> getCurrentStudentCalling(BuildContext context) async {
    setLoadingCurrentUser(true);
    try{
      final userID = await _s1.getSaveID(key: "userid");
      final value = await _studentRepo.getCurrentUser(userID);
      final userValue = await _authRepo.getUser(userID);
      _studentManagementModel = StudentManagementModel.fromDocumentSnapshot(documentsnapshot: value!);
      _userEmail = userValue.email!;
      notifyListeners();
      setLoadingCurrentUser(false);
      return _studentManagementModel;
    }catch(error){
      if (context.mounted) {
        Constants.flushBarErrorMessages(error.toString(), context);
      }
      setLoadingCurrentUser(false);
      return null;
    }
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }

  Future<String> createStudentCalling(
    BuildContext context, {
    String? studentName,
    String? departmentName,
    String? advisor,
    String? semester,
    String? grades,
    String? cgpa,
    String? dob,
  }) async {
    setCreatingStudent(true);
    try {
      String randomId = generateRandomId(20);
      //final userValue = await _authRepo.getUser(_currentUser!.uid);
      StudentManagementModel studentModel = StudentManagementModel(
        id: randomId,
        userId: selectedStudentID,
        studentName: studentName,
        departmentName: departmentName,
        advisor: advisor,
        semester: semester,
        grades: grades,
        cgpa: cgpa,
        dob: dob,
      );
      await _studentRepo.createNewStudent(studentModel, context).then((value) {
        setCreatingStudent(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingStudent(false);
      return "Error";
    }
  }

  Future<QuerySnapshot?> getAllUsersCalling(BuildContext context) async {
    try {
      final value = await _studentRepo.getAllUsers();
      return value;
    } catch (error) {
      if (context.mounted) {
        Constants.flushBarErrorMessages(error.toString(), context);
      }
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future<QuerySnapshot?> getAllStudentsCalling(BuildContext context) async {
    try {
      final value = await _studentRepo.getAllStudents();
      print("data: $value");
      return value;
    } catch (error) {
      if (context.mounted) {
        Constants.flushBarErrorMessages(error.toString(), context);
      }
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  setIsDeletingStudent(bool value) {
    _isDeletingStudent = value;
    notifyListeners();
  }

  Future<String> deleteStudentCalling(BuildContext context,
      {String? studentId}) async {
    setIsDeletingStudent(true);
    try {
      await _studentRepo.deleteStudent(id: studentId).then((value) {
        setIsDeletingStudent(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingStudent(false);
      return "Error";
    }
  }
}
