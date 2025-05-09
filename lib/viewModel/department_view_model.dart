import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/department_management_model.dart';
import 'package:campus_connects/repository/department_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

class DepartmentViewModel extends ChangeNotifier {
  final _departmentRepo = DepartmentRepo();
  final List<DepartmentManagementModel> _model = [
    DepartmentManagementModel(
      departmentName: "Department 1",
    )
  ];
  String _selectedDepartment = "";
  String get selectedDepartment => _selectedDepartment;
  bool _isCreatingDepartment = false;

  bool get isCreatingDepartment => _isCreatingDepartment;

  bool _isDeletingDepartment = false;

  bool get isDeletingDepartment => _isDeletingDepartment;

  List<String> _departmentsNames = [];

  List<String> get departmemtNames => _departmentsNames;

  setCreatingDepartment(bool value) {
    _isCreatingDepartment = value;
    notifyListeners();
  }


  setSelectedDepartment(String value){
    _selectedDepartment = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }

  Future<String> createDepartmentCalling(
    BuildContext context, {
    String? departmentName,
  }) async {
    setCreatingDepartment(true);
    try {
      String randomId = generateRandomId(20);
      DepartmentManagementModel departmentModel = DepartmentManagementModel(
          id: randomId, departmentName: departmentName);
      await _departmentRepo.createNewDepartment(departmentModel).then((value) {
        if (context.mounted)
          Constants.flushBarErrorMessages(
              "Department has been Added Successfully", context);
        setCreatingDepartment(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingDepartment(false);
      return "Error";
    }
  }

  clearDartmentList(){
    _departmentsNames.clear();
    notifyListeners();
  }

  Future<QuerySnapshot?> getAllDepartmentCallingForAdmin(BuildContext context) async {
    try {
      final value = await _departmentRepo.getAllDepartments();

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

  Future<QuerySnapshot?> getAllDepartmentCalling(BuildContext context) async {
    try {
      final value = await _departmentRepo.getAllDepartments();
      _departmentsNames.clear();
      _departmentsNames = value!.docs.map((doc) => doc.get('departmentName') as String).toList();

      // ✅ Initialize selectedStudentName
      if (_departmentsNames.isNotEmpty) {
        _selectedDepartment = _departmentsNames.first;
      } else {
        _selectedDepartment = "";
      }

      notifyListeners();
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

  setIsDeletingDepartment(bool value) {
    _isDeletingDepartment = value;
    notifyListeners();
  }

  Future<String> deleteDepartmentCalling(BuildContext context, {String? departmentId}) async {
    setIsDeletingDepartment(true);
    try {
      await _departmentRepo.deleteDepartment(id: departmentId).then((value) {
        setIsDeletingDepartment(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingDepartment(false);
      return "Error";
    }
  }

  List<DepartmentManagementModel> get model => _model;

  addToList(String department) {
    _model.add(DepartmentManagementModel(
      departmentName: department,
    ));
    notifyListeners();
  }

  removeFromList(int id) {
    _model.removeAt(id);
    notifyListeners();
  }

  updateFromList(int id, String department) {
    _model.elementAt(id).departmentName = department;
    notifyListeners();
  }
}
