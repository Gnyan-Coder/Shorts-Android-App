import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/view/screens/Home.dart';
import 'package:tiktok/view/screens/auth/Login.dart';

import '../model/UserModel.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proImg;

//  User state
  late Rx<User?> _user;
  User get user=>_user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

//  Pic image
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final img = File(image.path);
    proImg = img;
  }

//  User Register
  void signUp(
    String userName,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProPic(image);
        MyUser user = MyUser(
            name: userName,
            email: email,
            uid: credential.user!.uid,
            profilePhoto: downloadUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            "Error Creating Accounting", "Please enter all required filed");
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDownloadUrl = await snapshot.ref.getDownloadURL();
    return imageDownloadUrl;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Login", "Please Enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Login", e.toString());
    }
  }
}
