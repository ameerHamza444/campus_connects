import 'package:campus_connects/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EventRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool?> createEvent(EventModel event) async {
    try {
      await firestore.collection("Events").doc(event.id).set({
        "id": event.id,
        "eventTitle": event.eventTitle,
        "eventDate": Timestamp.fromDate(event.eventDate!),
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
  Future<QuerySnapshot?> getAllEvent() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("Events").get();
      return querySnapshot;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
