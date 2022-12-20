import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok/constant/Colors.dart';
import 'package:tiktok/view/widgets/TextInputField.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

import '../../controller/UploadVideoController.dart';

class AddCaptionScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const AddCaptionScreen({Key? key,required this.videoFile,required this.videoPath}) : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController=TextEditingController();
  TextEditingController captionController=TextEditingController();

  VideoUploadController videoUploadController= Get.put(VideoUploadController());

  @override
  void initState() {
    setState(() {
      videoPlayerController=VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/1.6,
                width: width,
                child: VideoPlayer(videoPlayerController),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                width: width,
                height: height/4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                        controller: songNameController,
                        myIcon: Icons.music_note,
                        myLabelText: "Song Name"
                    ),
                   const SizedBox(height: 20,),
                    TextInputField(
                        controller: captionController,
                        myIcon: Icons.closed_caption,
                        myLabelText: "Caption"
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    videoUploadController.uploadVideo(songNameController.text, captionController.text, widget.videoPath);
                  },
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  child: const Text("Upload"),
              )

            ],
          ),
        ),
      ),
    );
  }
}
