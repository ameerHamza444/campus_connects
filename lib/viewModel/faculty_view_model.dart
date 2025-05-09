import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/faculty_management_model.dart';
import 'package:campus_connects/repository/faculty_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';


class FacultyViewModel extends ChangeNotifier {
  final _facultyRepo = FacultyRepo();
  final List<FacultyManagementModel> _model = [
    FacultyManagementModel(
      facultyName: "Faculty 1",
      departmentName: "Department 1",
    )
  ];

  bool _isCreatingFaculty = false;

  bool get isCreatingFaculty => _isCreatingFaculty;

  bool _isDeletingFaculty = false;

  bool get isDeletingFaculty => _isDeletingFaculty;


  setCreatingFaculty(bool value) {
    _isCreatingFaculty = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }


  Future<String> createFacultyCalling(
      BuildContext context, {
        String? facultyName,
        String? departmentName
      }) async{
    setCreatingFaculty(true);
    try {
      String randomId = generateRandomId(20);
      FacultyManagementModel facultyModel = FacultyManagementModel(
          id: randomId,
          facultyName: facultyName,
          departmentName: departmentName

      );
      await _facultyRepo.createNewFaculty(facultyModel).then((value) {
        if (context.mounted) Constants.flushBarErrorMessages("Faculty has been Added Successfully", context);
        setCreatingFaculty(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingFaculty(false);
      return "Error";
    }
  }
  Future<QuerySnapshot?> getAllFacultyCalling(BuildContext context) async {
    try {
      final value = await _facultyRepo.getAllFaculty();
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

  setIsDeletingFaculty(bool value) {
    _isDeletingFaculty = value;
    notifyListeners();
  }

  Future<String> deleteFacultyCalling(BuildContext context, {String? facultyId}) async {
    setIsDeletingFaculty(true);
    try {
      await _facultyRepo.deleteFaculty(id: facultyId).then((value) {
        setIsDeletingFaculty(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingFaculty(false);
      return "Error";
    }
  }

  List<FacultyManagementModel> get model => _model;

  addToList(String name, String department) {
    _model.add(FacultyManagementModel(
      facultyName: name,
      departmentName: department,
    ));
    notifyListeners();
  }

  removeFromList(int id) {
    _model.removeAt(id);
    notifyListeners();
  }

  updateFromList(int id, String name, String department) {
    _model.elementAt(id).facultyName = name;
    _model.elementAt(id).departmentName = department;
    notifyListeners();
  }
}
