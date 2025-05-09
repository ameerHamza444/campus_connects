



import 'package:campus_connects/models/department_management_model.dart';
import 'package:campus_connects/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NotificationRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllNotifications() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Notification").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }




  Future<bool?> createNewNotification(NotificationModel notification) async {
    try {
      await firestore.collection("Notification").doc(notification.id).set({
        "id": notification.id,
        "notificationName": notification.notificationName,
        "notificationTitle": notification.notificationTitle,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<NotificationModel> getDepartmentById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Notification').doc(uid).get();
      return NotificationModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<bool?> deleteNotification({String? id}) async {
    try {
      await firestore.collection("Notification").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

}

