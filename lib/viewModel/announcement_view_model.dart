import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:campus_connects/repository/announcement_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

class AnnouncementViewModel extends ChangeNotifier {
  final _announcementRepo = AnnouncementRepo();

  final List<AnnouncementsManagementModel> _model = [
    AnnouncementsManagementModel(
      announcementmsg: "Announcement 1",
      departmentName: "Department 1",
    )
  ];

  bool _isCreatingAnnouncement = false;

  bool get isCreatingAnnouncement => _isCreatingAnnouncement;

  bool _isDeletingAnnouncement = false;

  bool get isDeletingAnnouncement => _isDeletingAnnouncement;


  setCreatingAnnouncement(bool value) {
    _isCreatingAnnouncement = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }


  Future<String> createAnnouncementCalling(
      BuildContext context, {
        String? announcementmsg,
        String? announcementtitle,
        String? departmentName
      }) async{
    setCreatingAnnouncement(true);
    try {
      String randomId = generateRandomId(20);
      AnnouncementsManagementModel announcementModel = AnnouncementsManagementModel(
          id: randomId,
          announcementmsg: announcementmsg,
          announcementtitle: announcementtitle,
          departmentName: departmentName

      );
      await _announcementRepo.createNewAnnouncement(announcementModel).then((value) {
        if (context.mounted) Constants.flushBarErrorMessages("Announcement has been Added Successfully", context);
        setCreatingAnnouncement(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingAnnouncement(false);
      return "Error";
    }
  }

  Future<QuerySnapshot?> getAllAnnouncementsCalling(BuildContext context) async {
    try {
      final value = await _announcementRepo.getAllAnnouncements();
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
  setIsDeletingAnnouncement(bool value) {
    _isDeletingAnnouncement = value;
    notifyListeners();
  }

  Future<String> deleteAnnouncementCalling(BuildContext context, {String? announcementId}) async {
    setIsDeletingAnnouncement(true);
    try {
      await _announcementRepo.deleteAnnouncement(id: announcementId).then((value) {
        setIsDeletingAnnouncement(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setIsDeletingAnnouncement(false);
      return "Error";
    }
  }
  List<AnnouncementsManagementModel> get model => _model;

  addToList(String announcementmsg, String department, String announcementtitle) {
    _model.add(AnnouncementsManagementModel(
      announcementmsg: announcementmsg,
      announcementtitle: announcementtitle,
      departmentName: department,
    ));
    notifyListeners();
  }

  removeFromList(int id) {
    _model.removeAt(id);
    notifyListeners();
  }

  updateFromList(int id, String announcementmsg, String department, String announcementtitle) {
    _model.elementAt(id).announcementmsg = announcementmsg;
    _model.elementAt(id).announcementtitle = announcementtitle;
    _model.elementAt(id).departmentName = department;
    notifyListeners();
  }
}
