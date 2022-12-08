import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String name;
  String email;
  String uid;
  String profilePhoto;
  MyUser({required this.name,required this.email,required this.uid,required this.profilePhoto});

  //App -Firebase
  Map<String ,dynamic> toJson(){
    return{
      "name":name,
      "email":email,
      "uid":uid,
      "profilePhoto":profilePhoto
    };
  }
  //Firebase-App
  static MyUser fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return MyUser(name: snapshot["name"], email: snapshot["email"], uid: snapshot["uid"], profilePhoto: snapshot["profilePhoto"]);
  }

}