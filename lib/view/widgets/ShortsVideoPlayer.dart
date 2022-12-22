import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const ShortsVideoPlayer({Key? key,required this.videoUrl}) : super(key: key);

  @override
  State<ShortsVideoPlayer> createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<ShortsVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController=VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });
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
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        setState(() {
          if(videoPlayerController.value.isPlaying){
            videoPlayerController.pause();
          }else {
            videoPlayerController.play();
          }
        });
      },
      child: Container(
        width:width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
            Positioned(
              left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child:Icon(videoPlayerController.value.isPlaying ? Icons.pause:Icons.play_arrow)
            )
          ],
        ),
      ),
    );
  }
}
