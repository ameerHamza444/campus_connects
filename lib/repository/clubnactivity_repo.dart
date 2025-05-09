

import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:campus_connects/models/clubnactitvity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ClubnactivityRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> getAllClubnactitvity() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Clubnactivity").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<bool?> createNewClubnactivity(ClubnactitvityModel clubnactivity) async {
    try {
      await firestore.collection("Clubnactivity").doc(clubnactivity.id).set({
        "id": clubnactivity.id,
        "name": clubnactivity.name,
        "clubNactivity": clubnactivity.clubNactivity,
        "userId": clubnactivity.userId,

      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<ClubnactitvityModel> getClubnactivityById(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Clubnactivity').doc(uid).get();
      return ClubnactitvityModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> deleteClubnactivity({String? id}) async {
    try {
      await firestore.collection("Clubnactivity").doc(id).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

}

