import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? eventTitle;
  DateTime? eventDate;

  EventModel({this.eventDate, this.id, this.eventTitle});

  EventModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentsnapshot}) {
    eventTitle = documentsnapshot.get("eventTitle");
    id = documentsnapshot.get("id");
    var dateField = documentsnapshot.get("eventDate");
    if (dateField is Timestamp) {
      eventDate = dateField.toDate();
    } else if (dateField is DateTime) {
      eventDate = dateField;
    }
  }

  EventModel.fromJson(Map<String, dynamic> json) {
    eventDate = (json['dateTime'] as Timestamp).toDate();
    eventTitle = json['eventTitle'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventDate'] = eventDate;
    data['eventTitle'] = eventTitle;
    data['id'] = id;
    return data;
  }
}
