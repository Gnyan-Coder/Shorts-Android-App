import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constant/Colors.dart';
import 'package:get/get.dart';
import 'package:tiktok/view/screens/AddCaption.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            showDialogOpt(context);
          },
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(child: Text("Add Video",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
          ),
        ),
      ),
    );
  }
  showDialogOpt(BuildContext context){
    return showDialog(context: context, builder: (context)=>SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: (){
            videoPicker(ImageSource.gallery,context);
          },
          child: const Text("Gallery"),
        ),
        SimpleDialogOption(
          onPressed: (){
            videoPicker(ImageSource.camera,context);
          },
          child: const Text("Camera"),
        ),
        SimpleDialogOption(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Close"),
        )
      ],
    )
    );
  }

  videoPicker(ImageSource src ,BuildContext context)async{
    final video=await ImagePicker().pickVideo(source: src);
    if(video!=null){
      Get.snackbar("Video Selected", video.path);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCaptionScreen(videoFile: File(video.path), videoPath: video.path)));
    }else{
      Get.snackbar("Error In Selecting Video", "Please choose a different video");
    }
  }
}
