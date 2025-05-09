import 'dart:async';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/user_model.dart';
import 'package:campus_connects/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthViewModel extends ChangeNotifier {
  final _authRepo = AuthRepo();
  final _auth = FirebaseAuth.instance;
  final _currentUser = FirebaseAuth.instance;
  final _s1 = S1();
  bool _isRegister = false;

  bool get isRegister => _isRegister;
  bool _isLogin = false;

  bool get isLogin => _isLogin;
  bool _isSignOut = false;

  bool get isSignOut => _isSignOut;

  setIsRegister(bool value) {
    _isRegister = value;
    notifyListeners();
  }

  Future<String> registerUser(BuildContext context, {String? username, String? email, String? password, String? role}) async {
    setIsRegister(true);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      UserModel registerModel = UserModel(
        id: userCredential.user!.uid,
        name: username,
        email: userCredential.user!.email,
        role: role ?? "user",
      );
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _authRepo.createNewUser(registerModel);
        if (context.mounted) Constants.flushBarErrorMessages("User has Register Successfully", context);
        Navigator.of(context).pop();
      } else {
        if (context.mounted) Constants.flushBarErrorMessages("User has already exist", context);
      }
      setIsRegister(false);
      return userCredential.user!.uid;
    } catch (e) {
      print("Message: $e");
      setIsRegister(false);
      return "Error";
    }
  }

  setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  Future<String> loginUser(BuildContext context, {String? email, String? password}) async {
    setIsLogin(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      UserModel user = await _authRepo.getUser(userCredential.user!.uid);
      _s1.saveID(key: "userid", value: user.id!);
      Future.delayed(const Duration(milliseconds: 2000), () {
        setIsLogin(false);
        if (context.mounted) Navigator.of(context).pushNamed(AppRoutes.navBarScreen, arguments: user);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      if (context.mounted) Constants.flushBarErrorMessages("Wrong Credentials", context);
      setIsLogin(false);
      return "Error";
    }
  }

  Future checkLogin(BuildContext context) async {
    _currentUser.authStateChanges().listen((user) async {
      if (user == null) {
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.pushNamed(context, AppRoutes.loginScreen);
        });
      } else {
        String? userId = await _s1.getSaveID(key: "userid");
        UserModel user = await _authRepo.getUser(userId);
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.pushNamed(context, AppRoutes.navBarScreen, arguments: user);
        });
      }
    });
  }

  setIsSignOut(bool value) {
    _isSignOut = value;
    notifyListeners();
  }

  Future<String> signOutUser(BuildContext context) async {
    setIsSignOut(true);
    try {
      await _auth.signOut();
      _s1.saveID(key: "userid", value: "");
      Future.delayed(const Duration(milliseconds: 2000), () {
        setIsSignOut(false);
        if (context.mounted) Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.loginScreen);
      });
      return "Success";
    } catch (e) {
      print("Message: $e");
      if (context.mounted) Constants.flushBarErrorMessages("Error While SignOut", context);
      setIsSignOut(false);
      return "Error";
    }
  }

  Future<String> allUserDetails(BuildContext context) async {
    setIsSignOut(true);
    try {

      return "Success";
    } catch (e) {
      print("Message: $e");
      if (context.mounted) Constants.flushBarErrorMessages("Error While SignOut", context);
      setIsSignOut(false);
      return "Error";
    }
  }

}
