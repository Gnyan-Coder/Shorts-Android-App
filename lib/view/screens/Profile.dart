import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controller/AuthController.dart';
import 'package:tiktok/controller/ProfileController.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key,required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController=Get.put(ProfileController());
  final AuthController authController=Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    profileController.updateUserId(widget.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UsrName"),
        centerTitle: true,
        actions: const [
          Icon(Icons.info_outline),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:controller.user["profilePhoto"],
                          height:100,
                          width:100,
                          placeholder: (context,url)=>const CircularProgressIndicator(),
                          errorWidget: (context,url,error)=>const Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(controller.user["followers"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          const Text("Followers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                        ],
                      ),
                      const SizedBox(width: 25,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Text(controller.user["followings"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          const Text("Followings",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                        ],
                      ),
                      const SizedBox(width: 25,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(controller.user["likes"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          const Text("Likes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      border:Border.all(
                        color: Colors.black12
                      )
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: (){
                          if(widget.uid==FirebaseAuth.instance.currentUser!.uid){
                            authController.signOut();
                          }else{
                            controller.followUser();
                          }
                        },
                          child: Text(widget.uid==FirebaseAuth.instance.currentUser!.uid?"Sign Out":
                          controller.user['isFollowing']?"Following":"Follow")),
                    ),
                  ),
                  const SizedBox(height: 15,),
                 const Divider(indent: 30,endIndent: 30,thickness: 2,),
                 const SizedBox(height: 15,),
                  GridView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5
                      ),
                      itemCount: controller.user['thumbnails'].length,
                      itemBuilder: (context,index){
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:controller.user['thumbnails'][index],
                          errorWidget: (context,url,error)=>const Icon(Icons.error),
                        );
                      }
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
