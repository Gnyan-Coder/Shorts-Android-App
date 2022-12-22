import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/UserModel.dart';

class SearchUserController extends GetxController{
  final Rx<List<MyUser>> _searchUsers=Rx<List<MyUser>>([]);
  List<MyUser> get searchedUsers=>_searchUsers.value;
  searchUser(String query)async{
    _searchUsers.bindStream(
      FirebaseFirestore.instance.collection("users").where("name",isGreaterThanOrEqualTo: query).snapshots().map((QuerySnapshot queryResult){
        List<MyUser> retVal=[];
        for(var element in queryResult.docs){
          retVal.add(MyUser.fromSnap(element));
        }
        return retVal;
      })
    );

  }

}