import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:campus_connects/models/clubnactitvity_model.dart';
import 'package:campus_connects/repository/announcement_repo.dart';
import 'package:campus_connects/repository/auth_repo.dart';
import 'package:campus_connects/repository/clubnactivity_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

class ClubnactivityViewModel extends ChangeNotifier {
  final _authRepo = AuthRepo();
  final _clubnactivityRepo = ClubnactivityRepo();

  final List<ClubnactitvityModel> _model = [
    ClubnactitvityModel(
      name: "Name 1",
      clubNactivity: "Activity 1",
    )
  ];

  bool _isCreatingClubnactitvity = false;

  bool get isCreatingClubnactitvity => _isCreatingClubnactitvity;

  bool _isDeletingClubnactitvity = false;

  bool get isDeletingClubnactitvity => _isDeletingClubnactitvity;


  setCreatingClubnactitvity(bool value) {
    _isCreatingClubnactitvity = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }


  Future<String> createClubnactitvityCalling(BuildContext context, {
    String? name,
    String? clubnactivity,
  }) async {
    setCreatingClubnactitvity(true);
    try {
      final userValue = await _authRepo.getUser(FirebaseAuth.instance.currentUser!.uid);
      String randomId = generateRandomId(20);
      ClubnactitvityModel clubnactitvityModel = ClubnactitvityModel(
        id: randomId,
        userId: userValue.id,
        name: name,
        clubNactivity: clubnactivity,

      );
      await _clubnactivityRepo.createNewClubnactivity(clubnactitvityModel)
          .then((value) {
        if (context.mounted) Constants.flushBarErrorMessages(
            "Added Successfully", context);
        setCreatingClubnactitvity(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingClubnactitvity(false);
      return "Error";
    }
  }

  Future<QuerySnapshot?> getAllClubnactitvityCalling(
      BuildContext context) async {
    try {
      final value = await _clubnactivityRepo.getAllClubnactitvity();
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

  setIsDeletingClubnactitvity(bool value) {
    _isDeletingClubnactitvity = value;
    notifyListeners();
  }

  Future<String> deleteClubnactitvityCalling(BuildContext context,
      {String? id}) async {
    setIsDeletingClubnactitvity(true);
    try {
      await _clubnactivityRepo.deleteClubnactivity(id: id).then((value) {
        setIsDeletingClubnactitvity(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingClubnactitvity(false);
      return "Error";
    }
  }
}
