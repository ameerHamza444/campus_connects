import 'package:campus_connects/models/discussion_form_model.dart';
import 'package:campus_connects/repository/auth_repo.dart';
import 'package:campus_connects/repository/discussion_form_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:math' as math;
import 'dart:convert';

class DiscussionFormViewModel extends ChangeNotifier {
  final _authRepo = AuthRepo();
  final _discussionRepo = DiscussionFormRepo();
  final _currentUser = FirebaseAuth.instance;
  String _userID = "";

  String get userID => _userID;

  setUserID(String id) {
    _userID = id;
    notifyListeners();
  }

  Stream<List<DiscussionFormModel>> get messageStream {
    return _discussionRepo.getMessages();
  }


  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }

  Future<String> sendMessage(String message) async {
    try {
      final userValue = await _authRepo.getUser(_currentUser.currentUser!.uid);
      String randomId = generateRandomId(20);
      DiscussionFormModel discussionFormModel = DiscussionFormModel(
        id: randomId,
        userID: userValue.id,
        message: message,
        dateTime: DateTime.now(),
      );
      await _discussionRepo.createMessage(discussionFormModel);
      return "Success";
    } catch (e) {
      print("Message: $e");
      return "Error";
    }
  }
}
