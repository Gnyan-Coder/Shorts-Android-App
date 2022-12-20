import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compressor/video_compressor.dart';
import '../model/Video.dart';

class VideoUploadController extends GetxController{
  static VideoUploadController instance = Get.find();
  var uuid=const Uuid();

  Future<File> _getThumb(String videoPath)async{
    final thumbnail=await VideoCompressor.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoThumbToStorage(String id,String videoPath)async{
    Reference reference=FirebaseStorage.instance.ref().child("Thumbnail").child(id);
    UploadTask uploadTask=reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot =await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //main video upload video
  //video to storage
  //video compress
  //video thumb gen
  //video thumb to storage
  uploadVideo(String songName,String caption,String  videoPath)async{
    try{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection("users").doc(uid).get();
  //  videoID --uuid
    String id=uuid.v1();
    String videoUrl=await _uploadVideoToStorage(id, videoPath);
    String thumbnail=await _uploadVideoThumbToStorage(id,videoPath);

    print("-------------------------------------------- start");
    Video video=Video(
      uid: uid,
      userName: (userDoc.data()! as Map<String,dynamic>)['name'],
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      songName: songName,
      shareCount: 0,
      commentCount: 0,
      likes: [],
      profilePic:(userDoc.data()! as Map<String,dynamic>)['profilePhoto'],
      caption: caption,
      id: id
    );
    await FirebaseFirestore.instance.collection("videos").doc(id).set(video.toJson());
    print("end -------------------------------------");
    Get.snackbar("Video Upload Successfully", "Thank you for sharing");
    Get.back();
    }catch(e){
      Get.snackbar("Error Uploading video", e.toString());
    }
  }

  Future<String> _uploadVideoToStorage(String videoID,String videoPath)async {
    Reference reference = FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(File(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  // _compressVideo(String videoPath) async{
  //   final compressedVideo = await VideoCompressor.compressVideo(videoPath,quality:VideoQuality.LowResQuality);
  //   return compressedVideo!.file;
  // }

}