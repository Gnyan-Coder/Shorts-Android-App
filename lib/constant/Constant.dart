import 'package:flutter/material.dart';
import 'package:tiktok/view/screens/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../view/screens/AddVideo.dart';
import '../view/screens/DisplayVideo.dart';
import '../view/screens/Search.dart';
final pageIndex=[
  const DisplayVideoScreen(),
  const SearchScreen(),
  const AddVideoScreen(),
  const Text("message"),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];