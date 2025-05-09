

import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AnnouncementRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllAnnouncements() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Announcement").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<bool?> createNewAnnouncement(AnnouncementsManagementModel announcement) async {
    try {
      await firestore.collection("Announcement").doc(announcement.id).set({
        "id": announcement.id,
        "announcementMsg": announcement.announcementmsg,
        "announcementTitle": announcement.announcementtitle,
        "departmentName": announcement.departmentName,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<AnnouncementsManagementModel> getAnnounementById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Announcement').doc(uid).get();
      return AnnouncementsManagementModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> deleteAnnouncement({String? id}) async {
    try {
      await firestore.collection("Announcement").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

}

