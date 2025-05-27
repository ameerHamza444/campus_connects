

import 'package:campus_connects/models/discussion_form_model.dart';
import 'package:campus_connects/models/faculty_management_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DiscussionFormRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool?> createMessage(DiscussionFormModel discussionForm) async {
    try {
      await firestore.collection("Messages").doc(discussionForm.id).set({
        "id": discussionForm.id,
        "userID": discussionForm.userID,
        "userName": discussionForm.userName,
        "message": discussionForm.message,
        "dateTime": discussionForm.dateTime,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Stream<List<DiscussionFormModel>> getMessages() {
    return firestore.collection('Messages').orderBy('dateTime', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => DiscussionFormModel.fromJson(doc.data())).toList(),
    );
  }

  Future<DiscussionFormModel> getMessageById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Messages').doc(uid).get();
      return DiscussionFormModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}

