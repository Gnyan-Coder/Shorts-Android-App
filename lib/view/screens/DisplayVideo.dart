import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/VideoController.dart';
import '../widgets/AlbumRotator.dart';
import '../widgets/ProfileButton.dart';
import '../widgets/ShortsVideoPlayer.dart';
import 'Comment.dart';

class DisplayVideoScreen extends StatefulWidget {
  const DisplayVideoScreen({Key? key}) : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  final VideoController videoController =Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx((){
          return PageView.builder(
              itemCount: videoController.videoList.length,
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0,viewportFraction: 1),
              itemBuilder: (context,index){
                final data=videoController.videoList[index];
                return Stack(
                  children: [
                        ShortsVideoPlayer(videoUrl:data.videoUrl,),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10,left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.userName,style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(data.caption,style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(data.songName,style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: height/2,
                        margin: EdgeInsets.only(top: height/2.6,right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileButton(profilePhotoUrl: data.profilePic,),
                            InkWell(
                              onTap: (){
                                videoController.likedVideo(data.id);
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.favorite,size: 40,color: Colors.pinkAccent,),
                                  Text(data.likes.length.toString(),style: const TextStyle(color: Colors.white,fontSize: 15),)
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Icon(Icons.reply,size: 40,color: Colors.white,),
                                Text(data.shareCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 15),)
                              ],
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentScreen(id: data.id,)));
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.comment,size: 40,color: Colors.white,),
                                  Text(data.commentCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 15),)
                                ],
                              ),
                            ),
                            AlbumRotator(profilePicUrl:data.profilePic ,)
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }
          );
        }
      ),
    );
  }
}
