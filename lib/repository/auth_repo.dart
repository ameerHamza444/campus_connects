

import 'package:campus_connects/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool?> createNewUser(UserModel user) async {
    try {
      await firestore.collection("Users").doc(user.id).set({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "role": user.role,
      });
      return true;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try{
      DocumentSnapshot documentsnapshot = await firestore.collection('Users').doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentsnapshot: documentsnapshot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  }

