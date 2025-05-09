import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/notification_model.dart';
import 'package:campus_connects/repository/notification_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

class NotificationViewModel extends ChangeNotifier {
  final _notificationRepo = NotificationRepo();
  final List<NotificationModel> _model = [
    NotificationModel(
      notificationName: "Notification",
    )
  ];
  bool _isCreatingNotification = false;

  bool get isCreatingNotification => _isCreatingNotification;

  bool _isDeletingNotification= false;

  bool get isDeletingNotification => _isDeletingNotification;


  List<String> _notificationNames = [];

  List<String> get notificationNames => _notificationNames;



  setCreatingNotification(bool value) {
    _isCreatingNotification = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }

  Future<String> createNotificationCalling(
      BuildContext context, {
        String? notificationName,
        String? notificationTitle,
      }) async {
    setCreatingNotification(true);
    try {
      String randomId = generateRandomId(20);
      NotificationModel notificationModel = NotificationModel(
          id: randomId, notificationName: notificationName, notificationTitle: notificationTitle);
      await _notificationRepo.createNewNotification(notificationModel).then((value) {
        if (context.mounted)
          Constants.flushBarErrorMessages(
              "Notification has been Added Successfully", context);
        setCreatingNotification(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingNotification(false);
      return "Error";
    }
  }

  clearNotificationList(){
    _notificationNames.clear();
    notifyListeners();
  }

  Future<QuerySnapshot?> getAllNotificationCalling(BuildContext context) async {
    try {
      final value = await _notificationRepo.getAllNotifications();
      print("data: $value");
      _notificationNames.clear();
      _notificationNames = value!.docs
          .map((doc) => doc.get('notificationName') as String)
          .toList();

      print("notification names: ${_notificationNames.toList()}");
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

  setIsDeletingNotification(bool value) {
    _isDeletingNotification = value;
    notifyListeners();
  }

  Future<String> deleteNotificationCalling(BuildContext context, {String? notificationId}) async {
    setIsDeletingNotification(true);
    try {
      await _notificationRepo.deleteNotification(id: notificationId).then((value) {
        setIsDeletingNotification(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingNotification(false);
      return "Error";
    }
  }

  List<NotificationModel> get model => _model;

  addToList(String notification) {
    _model.add(NotificationModel(
      notificationName: notification,
    ));
    notifyListeners();
  }

  removeFromList(int id) {
    _model.removeAt(id);
    notifyListeners();
  }

  updateFromList(int id, String notification) {
    _model.elementAt(id).notificationName = notification;
    notifyListeners();
  }
}
