import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  String userName;
  String comment;
  String datePub;
  List likes;
  String profilePic;
  String uid;
  String id;
  Comment({required this.userName,
    required this.comment,
    required this.datePub,
    required this.likes,
    required this.profilePic,
    required this.uid,
    required this.id
  });
  Map<String,dynamic> toJson()=>{
    'userName':userName,
    'comment':comment,
    'datePub':datePub,
    'likes':likes,
    'profilePic':profilePic,
    'uid':uid,
    'id':id,
  };

  static Comment fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return Comment(
        userName: snapshot ['userName'],
        comment: snapshot['comment'],
        datePub: snapshot['datePub'],
        likes: snapshot['likes'],
        profilePic: snapshot ['profilePic'],
        uid: snapshot['uid'],
        id: snapshot['id']);
  }
}