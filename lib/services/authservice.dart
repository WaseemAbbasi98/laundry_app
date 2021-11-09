import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/controller/appstate_controller.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/enums/appstate.dart';
import 'package:laundry_app/views/home/dashboard.dart';
import 'package:laundry_app/views/views/LoginPage.dart';

class AuthService extends AppStateController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final WorkerProvider _workerProvider = WorkerProvider();
  final UserProvider _userProvider = UserProvider();
  // final ClientProvider _clientProvider = ClientProvider();
  late String _verificationId;
  String _phoneNo = '';
  void setverId(String vid) {
    _verificationId = vid;
  }

  String getverId() {
    return _verificationId;
  }

  //GET CURRENT USERID..
  Future<String> getCurrentUID() async {
    return _auth.currentUser!.uid;
  }

  Stream<String> get onAuthStateChanged => _auth.authStateChanges().map(
        (User? user) => user!.uid,
      );
  // GET CURRENT USER
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomeDashboard(
              useremail: '',
            );
          } else {
            return const LoginPage();
          }
        });
  }

  checkAuthentication(String screen, BuildContext context) async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        if (screen == 'owner') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeDashboard(
                        useremail: '',
                      )));
        } else if (screen == 'client') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeDashboard(
                        useremail: '',
                      )));
        }
        // Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

// Register with email..
  Future registerWithEmailandPassword({
    required String email,
    required String password,
    required String name,
    required String type,
    required String phone,
    required String city,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      print('user email is...');
      print(user!.email);
      _userProvider.saveuser(
          useruid: user.uid,
          type: type,
          name: name,
          email: email,
          phone: phone,
          password: password,
          city: city);
      user.updateDisplayName(name);
      user.updateEmail(email);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
        iserror = true;
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // login with email and password....
  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        User? user = userCredential.user;
        iserror = false;
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email';
        iserror = true;
        // print(error);
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
        iserror = true;
        // print(error);
      } else {
        iserror = false;
        error = 'LogIn successful';
      }
      return null;
    }
  }

// logout..

  void logOut() async {
    return await _auth.signOut();
  }

  phonesignIn(AuthCredential authCreds) {
    _auth.signInWithCredential(authCreds);
  }

//SignIn with OTP...
  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    phonesignIn(authCreds);
  }
}
