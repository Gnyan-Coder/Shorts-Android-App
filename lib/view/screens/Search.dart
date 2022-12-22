import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/view/screens/Profile.dart';

import '../../controller/SearchUserController.dart';
import '../../model/UserModel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController=TextEditingController();
  SearchUserController searchUserController=Get.put(SearchUserController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title:  TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Search Username",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              onChanged: (value){
              searchUserController.searchUser(value);
            },)
          ),
          body: searchUserController.searchedUsers.isEmpty? const Center(
            child: CircularProgressIndicator(),
          ):ListView.builder(
            itemCount: searchUserController.searchedUsers.length,
              itemBuilder: (context,index){
              MyUser user =searchUserController.searchedUsers[index];
              return ListTile(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid)));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(user.profilePhoto),
                ),
                title: Text(user.name),
              );
              }
          ),
        );
      }
    );
  }
}
