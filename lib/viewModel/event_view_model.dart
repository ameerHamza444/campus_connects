import 'package:campus_connects/constants/constants.dart';
import 'package:campus_connects/models/event_model.dart';
import 'package:campus_connects/repository/event_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

class EventViewModel extends ChangeNotifier {
  final _eventRepo = EventRepo();

  bool _isCreatingEvent = false;

  bool get isCreatingEvent => _isCreatingEvent;

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;
  List<EventModel> _events = [];

  List<EventModel> get events => _events;

  setCreatingNotification(bool value) {
    _isCreatingEvent = value;
    notifyListeners();
  }

  String generateRandomId(int length) {
    var random = math.Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    var randomString = base64Url.encode(values);
    return randomString.substring(0, length); // Truncate to desired length
  }

  clearDateTime() {
    _selectedDate = null;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      notifyListeners();

      // Example: print or use the selected date
      print('Selected Date: $_selectedDate');
    }
  }

  Future<String> createEventCalling(
    BuildContext context, {
    String? eventTitle,
    DateTime? eventDate,
  }) async {
    setCreatingNotification(true);
    try {
      String randomId = generateRandomId(20);
      EventModel notificationModel = EventModel(
          id: randomId, eventTitle: eventTitle, eventDate: eventDate);
      await _eventRepo.createEvent(notificationModel).then((value) {
        if (context.mounted) {
          Constants.flushBarErrorMessages(
              "Event has been Created Successfully", context);
        }
        setCreatingNotification(false);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      setCreatingNotification(false);
      return "Error";
    }
  }
  Future<QuerySnapshot?> getAllEventsCallingForAdmin(BuildContext context) async {
    try {
      final value = await _eventRepo.getAllEvent();
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

  Future<QuerySnapshot?> getAllEventsCalling(BuildContext context) async {
    try {
      final value = await _eventRepo.getAllEvent();
      _events = value!.docs.map((doc) {
        return EventModel.fromDocumentSnapshot(documentsnapshot: doc);
      }).toList();
      notifyListeners();
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

  List<EventModel> eventsForDay(DateTime day) {
    return _events
        .where((event) =>
            event.eventDate!.year == day.year &&
            event.eventDate!.month == day.month &&
            event.eventDate!.day == day.day)
        .toList();
  }
}
